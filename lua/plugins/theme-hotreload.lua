return {
  {
    name = "theme-hotreload",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 999, -- Load just before theme (which has priority 1000)
    config = function()
      -- Watch for changes to the theme.lua file
      local theme_file = vim.fn.stdpath("config") .. "/lua/plugins/theme.lua"

      -- Create autocmd to reload theme when file changes
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyReload",
        callback = function()
          -- Unload the theme module to force fresh reload
          package.loaded["plugins.theme"] = nil

          vim.schedule(function()
            -- Try to load the new theme spec
            local ok, theme_spec = pcall(require, "plugins.theme")
            if not ok then
              vim.notify("Failed to load theme.lua: " .. tostring(theme_spec), vim.log.levels.ERROR)
              return
            end

            -- Extract the theme plugin and colorscheme name
            local theme_plugin_name = nil
            local colorscheme_name = nil

            -- Find the main theme plugin (not LazyVim)
            for _, spec in ipairs(theme_spec) do
              if spec[1] and spec[1] ~= "LazyVim/LazyVim" then
                theme_plugin_name = spec.name or spec[1]
              end
              -- Extract colorscheme from LazyVim opts or from the main theme
              if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
                if type(spec.opts.colorscheme) == "string" then
                  colorscheme_name = spec.opts.colorscheme
                end
              end
            end

            -- Clear all highlight groups before applying new theme
            vim.cmd("highlight clear")
            if vim.fn.exists("syntax_on") then
              vim.cmd("syntax reset")
            end

            -- Reset background to default (theme will set it appropriately)
            vim.o.background = "dark"

            -- Unload theme plugin modules to force full reload
            if theme_plugin_name then
              local plugin = require("lazy.core.config").plugins[theme_plugin_name]
              if plugin and plugin.dir then
                local plugin_dir = plugin.dir .. "/lua"
                if vim.fn.isdirectory(plugin_dir) == 1 then
                  pcall(function()
                    require("lazy.core.util").walkmods(plugin_dir, function(modname)
                      package.loaded[modname] = nil
                      package.preload[modname] = nil
                    end)
                  end)
                end
              end
            end

            -- Reload the theme plugin with lazy.nvim
            vim.defer_fn(function()
              -- Load the colorscheme plugin
              if colorscheme_name then
                pcall(require("lazy.core.loader").colorscheme, colorscheme_name)
              elseif theme_plugin_name then
                pcall(require("lazy.core.loader").colorscheme, theme_plugin_name)
              end

              -- Apply theme configuration
              for _, spec in ipairs(theme_spec) do
                if spec.config and type(spec.config) == "function" then
                  pcall(spec.config)
                end
              end

              -- Apply the colorscheme
              if colorscheme_name then
                pcall(vim.cmd.colorscheme, colorscheme_name)
              end

              -- Trigger ColorScheme event for plugins to update
              vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })

              -- Force redraw to update all UI elements
              vim.cmd("redraw!")

              vim.notify("Theme reloaded successfully", vim.log.levels.INFO)
            end, 10)
          end)
        end,
      })

      -- Optional: Add a command to manually reload the theme
      vim.api.nvim_create_user_command("ThemeReload", function()
        -- Trigger the LazyReload event
        vim.api.nvim_exec_autocmds("User", { pattern = "LazyReload" })
      end, { desc = "Manually reload theme from theme.lua" })
    end,
  },
}
