local M = {}

local opcodes = nil

local function load_opcodes()
	if opcodes then
		return opcodes
	end

	local plugin_paths = vim.api.nvim_get_runtime_file("lua/huff/data/opcodes.json", false)
	local path = plugin_paths[1]

	if not path then
		vim.notify("[huff.nvim] Failed to locate opcodes.json", vim.log.levels.ERROR)
		opcodes = {}
		return opcodes
	end

	local fd = io.open(path, "r")
	if not fd then
		vim.notify("[huff.nvim] Failed to load opcodes JSON: " .. path, vim.log.levels.ERROR)
		opcodes = {}
		return opcodes
	end

	local content = fd:read("*a")
	fd:close()

	local success, decoded = pcall(vim.fn.json_decode, content)
	if not success then
		vim.notify("[huff.nvim] Failed to parse opcodes JSON", vim.log.levels.ERROR)
		opcodes = {}
		return opcodes
	end

	opcodes = decoded
	return opcodes
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
	table.insert(lines, "[0x" .. data.opcode:lower() .. "] " .. name:lower() .. input_params)

	-- Second line: -> output
	if data.output and data.output ~= "" then
		table.insert(lines, "  -> " .. data.output)
	end

	-- Third line: description
	table.insert(lines, (data.desc or "No description available"))

	return lines
end

local function show_horizontal_buffer(lines)
	vim.cmd("split")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_win_set_buf(0, buf)
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
	local loaded_opcodes = load_opcodes()

	if not loaded_opcodes or vim.tbl_isempty(loaded_opcodes) then
		vim.notify("[huff.nvim] No opcodes loaded", vim.log.levels.ERROR)
		return
	end

	local word
	if opcode and opcode ~= "" then
		word = opcode:lower()
	else
		word = vim.fn.expand("<cword>"):lower()
		if not word or word == "" then
			vim.notify("[huff.nvim] No word under cursor", vim.log.levels.WARN)
			return
		end
	end

	local data = loaded_opcodes[word]
	if not data then
		local suggestions = {}
		for opcode_name, _ in pairs(loaded_opcodes) do
			if opcode_name:sub(1, 1) == word:sub(1, 1) then
				table.insert(suggestions, opcode_name)
			end
		end
		vim.notify("Opcode not found", vim.log.levels.INFO)
		return
	end

	local lines = format_info(word, data)
	show_horizontal_buffer(lines)
end

local function get_opcode_hover_info(word)
	load_opcodes()
	local data = opcodes[word:lower()]
	if data then
		return format_info(word, data)
	end
	return nil
end

local function setup_hover_handler(buf)
	local current_hover_buf = nil
	local hover_timer = nil
	local function close_hover_buffer()
		if current_hover_buf and vim.api.nvim_buf_is_valid(current_hover_buf) then
			local wins = vim.api.nvim_list_wins()
			for _, win in ipairs(wins) do
				if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == current_hover_buf then
					vim.api.nvim_win_close(win, true)
					break
				end
			end
			current_hover_buf = nil
		end
	end

	local function show_hover()
		local word = vim.fn.expand("<cword>")

		if not word or word == "" then
			close_hover_buffer()
			return
		end

		local hover_info = get_opcode_hover_info(word)
		if not hover_info then
			close_hover_buffer()
			return
		end

		close_hover_buffer()
		current_hover_buf = show_horizontal_buffer(hover_info)
	end

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = buf,
		callback = function()
			if hover_timer then
				hover_timer:close()
			end

			hover_timer = vim.loop.new_timer()
			hover_timer:start(800, 0, vim.schedule_wrap(show_hover))
		end,
	})

	vim.api.nvim_create_autocmd("BufUnload", {
		buffer = buf,
		callback = function()
			close_hover_buffer()
			if hover_timer then
				hover_timer:close()
			end
		end,
	})
end

function M.setup()
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

			-- Set up hover functionality
			setup_hover_handler(buf)
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
