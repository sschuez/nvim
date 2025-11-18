return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set to "*" to use releases, or false to always use the latest code
    build = "make", -- Build from source
    opts = {
      -- Provider configuration
      provider = "claude",
      auto_suggestions_provider = "claude",

      -- Mode: "legacy" shows diffs, "agentic" auto-applies changes via tools
      mode = "legacy", -- Use legacy mode to see diffs and manually accept changes

      -- Providers configuration (follows the new structure from migration guide)
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-haiku-4-5-20251001", -- Same model as Code Companion
          timeout = 30000,
          api_key_name = "ANTHROPIC_API_KEY",
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        },
      },

      -- Behavior: Controls how changes are applied
      behaviour = {
        auto_set_keymaps = true, -- Automatically set up keybindings
        auto_apply_diff_after_generation = false, -- Don't auto-apply, show diff first
      },
    },

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      -- Optional: Image pasting support
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },

      -- Optional: Markdown rendering
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },

      -- blink.cmp integration
      {
        "saghen/blink.cmp",
        optional = true,
        dependencies = {
          "Kaiser-Yang/blink-cmp-avante",
        },
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          opts.sources.default = opts.sources.default or {}
          opts.sources.providers = opts.sources.providers or {}

          -- Add avante to sources
          table.insert(opts.sources.default, "avante")

          -- Configure avante provider
          opts.sources.providers.avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            enabled = true,
            score_offset = 100,
          }

          return opts
        end,
      },
    },
  },
}
