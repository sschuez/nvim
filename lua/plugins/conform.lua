return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = {}, -- Use LSP (ruby_lsp with RuboCop)
        eruby = { "herb" }, -- Use Herb for ERB files
        xml = { "xmllint" },
      },
      formatters = {
        herb = {
          command = "herb-format",
          args = { "$FILENAME" },
          stdin = false,
        },
        xmllint = {
          command = "xmllint",
          args = { "--format", "-" },
          stdin = true,
        },
        rubocop = {
          command = false,
        },
      },
    },
  },
}
