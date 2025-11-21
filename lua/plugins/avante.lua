return {
  {
    "yetone/avante.nvim",
    -- Build configuration matching the standard setup
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- Instructions file for project-specific context
      instructions_file = "avante.md",

      -- Provider configuration
      provider = "claude",
      auto_suggestions_provider = "claude",

      -- Providers configuration
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-haiku-4-5-20251001", -- Your preferred Claude Haiku model
          timeout = 30000, -- Timeout in milliseconds
          api_key_name = "ANTHROPIC_API_KEY",
          extra_request_body = {
            temperature = 0.75, -- Standard temperature from the example
            max_tokens = 8192, -- Increased for better responses
          },
        },
      },

      -- Mode configuration
      -- mode = "legacy", -- Use legacy mode to see diffs and manually accept changes
      -- -- Behavior configuration
      -- behaviour = {
      --   auto_set_keymaps = true,
      --   auto_apply_diff_after_generation = false,
      --
      --   auto_add_current_file = true, -- Auto-add current file to context
      --   acp_follow_agent_locations = true, -- Auto-open files when agent edits
      -- },
      --
      mode = "agentic",
      behaviour = {
        auto_apply_diff_after_generation = false, -- Still review changes
        auto_approve_tool_permissions = { "read_file", "git_diff" }, -- Only safe tools
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- Note: nvim-cmp is commented out as we're using blink.cmp
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- Blink.cmp configuration for Avante integration
  -- This follows the Kaiser-Yang/blink-cmp-avante setup
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = function(_, opts)
      -- Ensure the sources table structure exists
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      opts.sources.providers = opts.sources.providers or {}

      -- Add avante to the default sources
      -- Check if avante is not already in the list before adding
      if not vim.tbl_contains(opts.sources.default, "avante") then
        table.insert(opts.sources.default, "avante")
      end

      -- Configure the avante provider for blink.cmp
      opts.sources.providers.avante = {
        module = "blink-cmp-avante",
        name = "Avante",
        enabled = true,
        score_offset = 100, -- High priority for Avante suggestions
      }

      return opts
    end,
  },
}
