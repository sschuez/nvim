return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      emmet_ls = {
        capabilities = vim.lsp.protocol.make_client_capabilities({
          textDocument = {
            completion = {
              completionItem = { snippetSupport = true },
            },
          },
        }),
        filetypes = {
          "css",
          "eruby",
          "html",
          "javascript",
          "sass",
          "scss",
          "pug",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      },
    },
  },
}
