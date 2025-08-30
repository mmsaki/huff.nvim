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

	local parser_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/nvim-treesitter/parser/huff-treesitter"
	local queries_path = parser_path .. "/queries"

	if vim.fn.isdirectory(queries_path) == 1 then
		local ts_query = require("nvim-treesitter.query")
		ts_query.set_query_path("huff", { queries_path })
	else
		vim.notify("[huff.nvim] Queries folder not found at: " .. queries_path, vim.log.levels.WARN)
	end
end

return M
