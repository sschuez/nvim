-- Let the middle of the status line show the terminal background (based on omarchy-nvim).
-- Lualine's auto theme paints the middle section c a solid colour, so clear it on each theme
-- it builds; it rebuilds on every colorscheme change. x is listed too, because some themes
-- (monokai-pro) set it instead of reusing c. The outer sections (a, b and y, z) keep their
-- colours. StatusLine itself is cleared in config/autocmds.lua.
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.theme = function()
      local theme = require("lualine.utils.loader").load_theme("auto")
      for _, mode in pairs(theme) do
        for _, section in ipairs({ "c", "x" }) do
          if mode[section] then
            mode[section].bg = "None"
          end
        end
      end
      return theme
    end
  end,
}
