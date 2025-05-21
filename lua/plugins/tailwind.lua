return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = {
            "html",
            "eruby", -- for .erb
            "javascriptreact",
            "typescriptreact",
            "vue",
            "svelte",
            "php",
            "blade",
            "astro",
            "templ",
            "heex",
          },
          init_options = {
            userLanguages = {
              eruby = "html",
              heex = "html",
              templ = "html",
            },
          },
          root_dir = require("lspconfig.util").root_pattern(
            "tailwind.config.js",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.ts",
            "package.json",
            "node_modules",
            ".git"
          ),
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        },
      },
    },
  },
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   opts = {
  --     user_default_options = {
  --       tailwind = true,
  --     },
  --   },
  -- },
}
