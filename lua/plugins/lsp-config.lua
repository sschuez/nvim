return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false, -- Disable Mason for Ruby LSP
          cmd = { "ruby-lsp" }, -- Let mise handle the PATH
          init_options = {
            formatter = "auto", -- Automatically choose the formatter
          },
        },
        rubocop = {
          mason = false,
          cmd = { "bundle", "exec", "rubocop", "--lsp" }, -- Use project RuboCop
        },
      },
    },
  },
}
