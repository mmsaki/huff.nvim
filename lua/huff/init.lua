local M = {}

function M.setup()
	local ok, parsers = require("nvim-treesitter.parsers")
	if not ok then
		vim.notify("[huff.nvim] nvim-treesitter not found", vim.log.levels.WARN)
		return
	end

	local parser_config = parsers.get_parser_configs()
	parser_config.huff = {
		install_info = {
			url = "https://github.com/mmsaki/huff-treesitter",
			files = { "src/parser.c" },
			generate_requires_npm = true,
			requires_generate_from_grammar = true,
		},
		filetype = "huff",
	}

	local ts_ok, configs = require("nvim-treesitter.configs")
	if ts_ok then
	end
end

return M
