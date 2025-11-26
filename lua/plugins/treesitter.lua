return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        -- Use array syntax for specific filetypes where vim-rails needs regex highlighting
        -- This is the LazyVim-recommended approach for Ruby
        additional_vim_regex_highlighting = { "ruby", "eruby" },
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
