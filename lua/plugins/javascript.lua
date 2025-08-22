return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          mason = false,
        },
        stimulus_ls = {
          mason = false,
        },
      },
    },
  },
}