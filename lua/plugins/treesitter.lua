return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true,
      },
      folds = { enable = true },
      ensure_installed = {
        "css",
        "bash",
        "diff",
        "helm",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "ruby",
        "scss",
        "slim",
        "ssh_config",
        "tmux",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
