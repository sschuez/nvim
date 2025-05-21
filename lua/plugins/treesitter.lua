return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "css",
          "diff",
          "helm",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "regex",
          "ruby",
          "scss",
          "slim",
          "ssh_config",
          "tmux",
          "vim",
          "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
