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
        -- Herb LSP for ERB files - provides linting, formatting, and diagnostics
        herb_ls = {
          mason = false, -- Use globally installed herb-language-server
          cmd = { "herb-language-server" },
          filetypes = { "eruby" },
          root_dir = function()
            return vim.fn.getcwd()
          end,
          settings = {
            herb = {
              -- Enable format-on-save (experimental - can be disabled if issues occur)
              formatter = {
                enable = true,
                formatOnSave = false, -- Start with false, enable manually when ready
              },
              linter = {
                enable = true,
              },
            },
          },
        },
      },
    },
  },
}
