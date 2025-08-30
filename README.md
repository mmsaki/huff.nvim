# ♟️ huff.nvim

> **Neovim Treesitter integration for the [Huff language](https://docs.huff.sh/)**

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-57A143?style=flat\&logo=neovim)](https://neovim.io)
[![Tree-sitter](https://img.shields.io/badge/Tree--sitter-Supported-blue?style=flat)](https://tree-sitter.github.io/tree-sitter/)
[![License](https://img.shields.io/github/license/mmsaki/huff.nvim?color=blue)](LICENSE)

`huff.nvim` is a lightweight Neovim plugin that brings **Treesitter-powered syntax highlighting** and **indentation support** for the [Huff](https://docs.huff.sh/) low-level EVM language.

## ✨ Features

* 🧩 **Treesitter-powered parsing** — accurate syntax highlighting
* 📜 **Huff language support** — compatible with `.huff` files
* ⚡ **Lazy-loaded** for performance
* 🛠️ Simple setup, no extra configuration needed

## 📦 Installation

Using **[lazy.nvim](https://github.com/folke/lazy.nvim)**:

```lua
return {
  "mmsaki/huff.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  tag = "0.1.1",
  ft = { "huff" },
  config = function()
    require("huff").setup()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "huff" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
```

## ⚒️ Commands

| Command           | Description              |
| ----------------- | ------------------------ |
| `:TSInstall huff` | Installs the Huff parser |
| `:TSUpdate`       | Updates all parsers      |

## 🔄 Alternatives

If you prefer a non-Treesitter implementation:

* [vim-huff](https://github.com/pedrommaiaa/vim-huff)

## 🤝 Contributing

Contributions are welcome!
If you’d like to improve the parser, fix bugs, or add features, open an **issue** or submit a **PR**.

## 📜 License

[MIT](LICENSE) © 2025 [mmsaki](https://github.com/mmsaki)
