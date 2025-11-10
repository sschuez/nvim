return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "LazyFile", "VeryLazy" },
    build = ":TSUpdate",
    opts = {
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
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
    },
  },
}
