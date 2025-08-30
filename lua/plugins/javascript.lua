return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              preferences = {
                quoteStyle = "double",
                includePackageJsonAutoImports = "auto",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
              },
              suggest = {
                completeFunctionCalls = true,
                includeCompletionsForModuleExports = true,
                includeAutomaticOptionalChainCompletions = true,
              },
            },
            javascript = {
              preferences = {
                quoteStyle = "double",
                includePackageJsonAutoImports = "auto",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
              },
              suggest = {
                completeFunctionCalls = true,
                includeCompletionsForModuleExports = true,
                includeAutomaticOptionalChainCompletions = true,
              },
            },
          },
        },
        stimulus_ls = {
          mason = false,
        },
      },
    },
  },
}