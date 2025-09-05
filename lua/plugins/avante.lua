return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- Switch to OpenAI as primary to avoid rate limits
      provider = "openai",
      -- Disable global temperature to let GPT-5 mini use default
      temperature = 1.0, -- GPT-5 mini only supports default temperature
      providers = {
        -- OpenAI as primary - GPT-5 mini for superior coding performance
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- Fall back to GPT-4o which supports temperature
          timeout = 30000,
          extra_request_body = {
            max_completion_tokens = 4096, -- Reasonable token limit
          },
        },
        -- Claude as secondary option for complex tasks
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022", -- More stable model
          timeout = 30000,
          extra_request_body = {
            -- temperature = 0.1, -- Very low for code generation
            max_tokens = 4096, -- Reduced to avoid rate limits
          },
        },
      },
      -- Add provider toggle keybinding
      mappings = {
        toggle = {
          provider = "<leader>hp", -- Toggle between providers
        },
      },
      -- Optimize for rate limit management
      auto_suggestions_provider = "openai", -- Use OpenAI for auto-suggestions
      dual_boost = { enabled = false }, -- Disable experimental dual requests
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
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
}
