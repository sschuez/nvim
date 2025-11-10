return {
  -- Load all theme plugins but don't apply them
  -- This ensures all colorschemes are available for hot-reloading

  -- Catppuccin (mocha and latte variants)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = "auto", -- Will be overridden by individual theme files
    },
  },

  -- Everforest (dark and light variants)
  {
    "neanias/everforest-nvim",
    lazy = true,
    priority = 1000,
  },

  -- Gruvbox (dark and light variants)
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Jellybeans (requires lush.nvim as dependency)
  {
    "rktjmp/lush.nvim",
    lazy = true,
  },
  {
    "metalelf0/jellybeans-nvim",
    lazy = true,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Matte Black
  {
    "tahayvr/matteblack.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Milky Matcha (custom theme, defined inline in theme file)
  -- No plugin needed, colorscheme is applied via function in theme file

  -- Nord
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Ristretto (Monokai Pro variant)
  {
    "gthelding/monokai-pro.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
  },

  -- Snow
  {
    "bjarneo/snow.nvim",
    name = "snow",
    lazy = true,
    priority = 1000,
  },

  -- Solarized
  {
    "maxmx03/solarized.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
  },
}
