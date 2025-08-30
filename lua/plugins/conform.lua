vim.api.nvim_create_autocmd("FileType", {
  pattern = "eruby.yaml",
  command = "set filetype=yaml",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xml",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        -- ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        -- ["typescriptreact"] = { "prettier" },
        -- ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["eruby"] = { "erb_lint_ruby", "htmlbeautifier" },
        ["xml"] = { "xmllint" },
        ["json"] = { "prettier" },
        -- ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        -- ["markdown.mdx"] = { "prettier" },
        -- ["graphql"] = { "prettier" },
        -- ["handlebars"] = { "prettier" },
        -- ["sh"] = { "shfmt" },
        -- ["lua"] = { "stylua" },
      },
      formatters = {
        -- ERB formatters - require erb_lint and htmlbeautifier gems in project
        erb_lint_ruby = {
          command = "bundle",
          args = {
            "exec",
            "erb_lint",
            "--autocorrect",
            "--format",
            "compact",
            "--config",
            ".erb_lint.yml",
            "$FILENAME",
          },
          stdin = false,
          exit_codes = { 0, 1 },
        },
        htmlbeautifier = {
          command = "bundle",
          args = { "exec", "htmlbeautifier", "--keep-blank-lines", "1", "$FILENAME" },
          stdin = false,
          exit_codes = { 0 },
        },
        xmllint = {
          command = "xmllint",
          args = { "--format", "-" },
          stdin = true,
        },
      },
    },
  },
}
