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
        -- ["eruby"] = { "erb_lint" },
        -- ["eruby"] = { "erb_format" },
        -- ["eruby"] = { erb_formatter" },
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
        -- To debug: bundle exec htmlbeautifier --indent 2 app/path/of/file.html.erb                                                                                                                                        main
        htmlbeautifier = {
          command = "bundle",
          args = {
            "exec",
            "htmlbeautifier",
            "--keep-blank-lines",
            "1",
            "$FILENAME",
          },
          stdin = false,
          exit_codes = { 0 },
        },
        erb_lint = {
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
        erb_format = {
          command = "erb-format",
          args = {
            "--stdin",
            "--stdin-filename",
            "$FILENAME",
            "--print-width",
            "150",
          },
          stdin = true,
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
