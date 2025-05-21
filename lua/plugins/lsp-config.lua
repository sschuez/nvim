return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false, -- Disable Mason for Ruby LSP
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") }, -- Path for rbenv
          init_options = {
            formatter = "auto", -- Automatically choose the formatter
            -- skipBundlerChecks = true,
            -- Additional initialization options can be added here
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
