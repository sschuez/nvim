return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY", -- Reads from environment variable
            },
            schema = {
              model = {
                default = "claude-haiku-4-5-20251001",
                choices = {
                  "claude-sonnet-4-5-20250929", -- Best coding model, 77.2% on SWE-bench (Sept 2025)
                  "claude-opus-4-1-20250815", -- Most powerful model for complex reasoning (Aug 2025)
                  "claude-haiku-4-5-20251001", -- Fastest, cheapest model (Oct 2025)
                },
              },
            },
          })
        end,
      },
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG",
      },
    },
  },
}
