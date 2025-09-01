local M = {
	opcodes = nil,
	config = {
		window_type = "floating", -- "floating" or "split"
	},
}

M.load_opcodes = function()
	if M.opcodes then
		return M.opcodes
	end

	local plugin_paths = vim.api.nvim_get_runtime_file("lua/huff/data/opcodes.json", false)
	local path = plugin_paths[1]

	if not path then
		vim.notify("[huff.nvim] Failed to locate opcodes.json", vim.log.levels.ERROR)
		return
	end

	local fd = io.open(path, "r")
	if not fd then
		vim.notify("[huff.nvim] Failed to load opcodes JSON: " .. path, vim.log.levels.ERROR)
		return
	end

	local content = fd:read("*a")
	fd:close()

	local success, decoded = pcall(vim.fn.json_decode, content)
	if not success then
		vim.notify("[huff.nvim] Failed to parse opcodes JSON", vim.log.levels.ERROR)
		return
	end

	M.opcodes = decoded
	return M.opcodes
end

local function format_info(name, data)
	local lines = {}

	-- First line: [0x35] calldataload(i)
	local input_params = ""
	if data.input and data.input ~= "" then
		input_params = "(" .. data.input .. ")"
	else
		input_params = "()"
	end
	if data.opcode and data.opcode ~= "" then
		table.insert(lines, "[0x" .. data.opcode .. "] " .. name .. input_params)
	else
		table.insert(lines, name .. input_params)
	end

	-- Second line: -> output
	if data.output and data.output ~= "" then
		table.insert(lines, "  -> " .. data.output)
	end

	-- Third line: description
	vim.list_extend(lines, (vim.split(data.desc, "\n") or "No description available"))

	return lines
end

local function show_floating_buffer(lines)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)

	local width = math.max(unpack(vim.tbl_map(function(line)
		return #line
	end, lines))) + 2
	local height = #lines

	local win_opts = {
		relative = "cursor",
		width = width,
		height = height,
		row = 1,
		col = 0,
		style = "minimal",
		border = "rounded",
		title = " EVM_LOOKUP ",
		title_pos = "center",
	}

	local win = vim.api.nvim_open_win(buf, true, win_opts)
	vim.fn.matchadd("Number", "0x[0-9a-fA-F]\\+", -1, -1, { window = win })
	local close_keys = { "q", "<Esc>", "<CR>" }
	for _, key in ipairs(close_keys) do
		vim.api.nvim_buf_set_keymap(buf, "n", key, "<cmd>close<CR>", { noremap = true, silent = true })
	end

	vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
		buffer = buf,
		once = true,
		callback = function()
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end,
	})

	return buf
end

local function show_split_buffer(lines)
	vim.cmd("topleft split")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(0, buf)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_win_set_height(0, #lines)
	vim.api.nvim_win_set_option(0, "statusline", " EVM_LOOKUP")
	vim.fn.matchadd("Number", "0x[0-9a-fA-F]\\+", -1, -1, { window = 0 })
	local close_keys = { "q", "<Esc>", "<CR>" }
	for _, key in ipairs(close_keys) do
		vim.api.nvim_buf_set_keymap(buf, "n", key, "<cmd>q<CR>", { noremap = true, silent = true })
	end
	vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
		buffer = buf,
		once = true,
		callback = function()
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end,
	})
	return buf
end

M.lookup_opcode = function(opcode)
	local loaded_opcodes = M.load_opcodes()

	if not loaded_opcodes or vim.tbl_isempty(loaded_opcodes) then
		vim.notify("[huff.nvim] No opcodes loaded", vim.log.levels.ERROR)
		return
	end

	local word
	if opcode and opcode ~= "" then
		word = opcode
	else
		word = vim.fn.expand("<cword>")
		if not word or word == "" then
			vim.notify("[huff.nvim] No word under cursor", vim.log.levels.WARN)
			return
		end
	end

	local data = loaded_opcodes[word]
	if not data then
		return
	end

	local lines = format_info(word, data)
	if M.config.window_type == "floating" then
		show_floating_buffer(lines)
	else
		show_split_buffer(lines)
	end
end

function M.setup(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)

	local ok, parsers = pcall(require, "nvim-treesitter.parsers")
	if not ok or not parsers then
		vim.notify("[huff.nvim] nvim-treesitter not available", vim.log.levels.WARN)
		return
	end

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.huff = {
		install_info = {
			url = "https://github.com/mmsaki/huff-treesitter",
			files = { "src/parser.c" },
			branch = "main",
			generate_requires_npm = true,
		},
		filetype = "huff",
	}

	vim.filetype.add({
		extension = { huff = "huff" },
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "huff",
		callback = function(args)
			local buf = args.buf
			vim.keymap.set("n", "K", M.lookup_opcode, {
				desc = "EVM Opcode Lookup",
				silent = true,
				buffer = buf,
			})
		end,
	})

	vim.api.nvim_create_user_command("OpcodeInfo", function(opts)
		M.lookup_opcode(opts.args)
	end, {
		desc = "Look up EVM opcode information",
		nargs = "?",
	})
end

return M
