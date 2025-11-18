return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.local/share/mise/shims/ruby-lsp") },
          -- Override the default reuse_client to properly match by root_dir
          reuse_client = function(client, config)
            -- Match if same server name and same root directory
            return client.name == "ruby_lsp" and client.config.root_dir == config.root_dir
          end,
        },
        rubocop = {
          enabled = false,
        },
      },
    },
  },
}
