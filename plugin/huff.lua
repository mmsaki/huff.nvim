pcall(function()
	require("huff").setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "huff" },
		highlight = { enable = true },
		indent = { enable = true },
	})
end)
