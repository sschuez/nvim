return {
  {
    name = "theme-hotreload",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 999,
    config = function()
      -- Command to manually reload theme
      vim.api.nvim_create_user_command("ThemeReload", function()
        -- Unload the theme module
        package.loaded["plugins.theme"] = nil

        -- Clear all highlights
        vim.cmd("highlight clear")
        if vim.fn.exists("syntax_on") then
          vim.cmd("syntax reset")
        end

        vim.schedule(function()
          -- Reload the theme
          local ok, theme_spec = pcall(require, "plugins.theme")
          if not ok then
            vim.notify("Failed to load theme.lua", vim.log.levels.ERROR)
            return
          end

          -- Extract and apply colorscheme
          local colorscheme_name = nil
          for _, spec in ipairs(theme_spec) do
            if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
              colorscheme_name = spec.opts.colorscheme
            end
          end

          if colorscheme_name then
            -- Handle both string colorscheme names and functions
            if type(colorscheme_name) == "function" then
              colorscheme_name()  -- Call the function to apply the theme
            else
              vim.cmd("colorscheme " .. colorscheme_name)
            end
          end

          -- Apply theme config
          for _, spec in ipairs(theme_spec) do
            if spec.config and type(spec.config) == "function" then
              pcall(spec.config)
            end
          end

          -- Trigger events
          vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
          vim.api.nvim_exec_autocmds("VimEnter", { modeline = false })

          vim.notify("Theme reloaded successfully", vim.log.levels.INFO)
        end)
      end, {
        desc = "Manually reload theme from theme.lua"
      })

      -- Create autocmd for LazyReload event (for hot reload)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyReload",
        callback = function()
          vim.cmd("ThemeReload")
        end,
      })
    end,
  },
}