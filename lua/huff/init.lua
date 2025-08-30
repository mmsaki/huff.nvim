local M = {}

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
end

return M
