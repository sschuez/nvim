return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        herb_ls = function(_, opts)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")
          
          -- Define herb_ls as a custom server if not already defined
          if not configs.herb_ls then
            configs.herb_ls = {
              default_config = {
                cmd = { "herb-language-server", "--stdio" },
                filetypes = { "eruby" },
                root_dir = lspconfig.util.root_pattern(".git", "Gemfile", "package.json"),
                single_file_support = true,
                name = "herb_ls",
              },
            }
          end
          
          lspconfig.herb_ls.setup(opts)
          return true -- Prevent default setup
        end,
      },
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
        herb_ls = {
          mason = false,
        },
      },
    },
  },
}
