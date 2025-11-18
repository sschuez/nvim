vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xml",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        xml = { "xmllint" },
      },
      formatters = {
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
