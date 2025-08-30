# huff.nvim

Huff Treesitter support for Neovim.

## Usage

```lua
{
  "mmsaki/huff.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "huff" },
  config = function()
    require("huff").setup()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "huff" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
```

## Commands

`:TSInstall huff` → Install parser

## Links

- [GitHub](https://github.com/mmsaki/huff.nvim)
