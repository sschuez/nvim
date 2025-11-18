return {
  {
    name = "theme-hotreload",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 999,
    config = function()
      -- Theme pairing map - which light theme to use when toggling from a dark theme
      local theme_pairs = {
        ["nord"] = "snow",                    -- Nord (dark) -> Snow (light)
        ["catppuccin-mocha"] = "catppuccin-latte",
        ["catppuccin-frappe"] = "catppuccin-latte",
        ["catppuccin-macchiato"] = "catppuccin-latte",
        ["gruvbox"] = "gruvbox-light",
        ["everforest-dark"] = "everforest-light",
        ["tokyo-night"] = "rose-pine",        -- Tokyo Night -> Rose Pine (light)
        ["kanagawa"] = "snow",                 -- Kanagawa -> Snow
        ["jellybeans"] = "milky-matcha",      -- Jellybeans -> Milky Matcha
        ["matte-black"] = "snow",              -- Matte Black -> Snow
        ["ristretto"] = "solarized",          -- Ristretto -> Solarized (light)
      }

      -- Reverse map for going back to dark
      local reverse_pairs = {}
      for dark, light in pairs(theme_pairs) do
        reverse_pairs[light] = dark
      end

      -- Function to get theme file path
      local function get_theme_file_path(theme_name)
        return vim.fn.expand("~/code/dotfiles/themes/neovim/" .. theme_name .. ".lua")
      end

      -- Function to apply a theme file
      local function apply_theme_file(theme_name)
        local source_file = get_theme_file_path(theme_name)
        local dest_file = vim.fn.expand("~/.config/nvim/lua/plugins/theme.lua")

        if vim.fn.filereadable(source_file) == 1 then
          -- Copy the theme file
          vim.fn.system("cp " .. source_file .. " " .. dest_file)

          -- Unload and reload the theme module
          package.loaded["plugins.theme"] = nil

          -- Clear all highlights
          vim.cmd("highlight clear")
          if vim.fn.exists("syntax_on") then
            vim.cmd("syntax reset")
          end

          -- Load the new theme
          vim.schedule(function()
            local ok, theme_spec = pcall(require, "plugins.theme")
            if ok then
              -- Extract colorscheme name
              local colorscheme_name = nil
              for _, spec in ipairs(theme_spec) do
                if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
                  colorscheme_name = spec.opts.colorscheme
                end
              end

              -- Apply the colorscheme
              if colorscheme_name then
                vim.cmd("colorscheme " .. colorscheme_name)
              end

              -- Apply theme config if exists
              for _, spec in ipairs(theme_spec) do
                if spec.config and type(spec.config) == "function" then
                  pcall(spec.config)
                end
              end

              -- Trigger events
              vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
              vim.api.nvim_exec_autocmds("VimEnter", { modeline = false })

              vim.notify("Switched to " .. theme_name .. " theme", vim.log.levels.INFO)
            end
          end)

          return true
        end
        return false
      end

      -- Function to determine if a theme is light
      local function is_light_theme(theme_name)
        local light_themes = {
          ["catppuccin-latte"] = true,
          ["gruvbox-light"] = true,
          ["everforest-light"] = true,
          ["snow"] = true,
          ["milky-matcha"] = true,
          ["rose-pine"] = true,
          ["solarized"] = true,
        }
        return light_themes[theme_name] or false
      end

      -- Function to get current theme name from colorscheme
      local function get_current_theme_name()
        local colorscheme = vim.g.colors_name
        if not colorscheme then
          return nil
        end

        -- Map colorscheme names to theme file names
        local colorscheme_to_theme = {
          ["catppuccin-latte"] = "catppuccin-latte",
          ["catppuccin-mocha"] = "catppuccin-mocha",
          ["catppuccin-frappe"] = "catppuccin-frappe",
          ["catppuccin-macchiato"] = "catppuccin-macchiato",
          ["catppuccin"] = "catppuccin-mocha",
          ["gruvbox"] = "gruvbox",
          ["nord"] = "nord",
          ["everforest"] = "everforest-dark",
          ["tokyonight"] = "tokyo-night",
          ["kanagawa"] = "kanagawa",
          ["jellybeans"] = "jellybeans",
          ["snow"] = "snow",
          ["solarized"] = "solarized",
          ["rose-pine"] = "rose-pine",
        }

        return colorscheme_to_theme[colorscheme] or colorscheme
      end

      -- Command to toggle between light and dark themes
      vim.api.nvim_create_user_command("ThemeToggleBackground", function()
        local current_theme = get_current_theme_name()
        if not current_theme then
          vim.notify("Could not determine current theme", vim.log.levels.ERROR)
          return
        end

        local target_theme = nil

        -- Check if current theme is light
        if is_light_theme(current_theme) then
          -- Switch to dark variant
          target_theme = reverse_pairs[current_theme] or current_theme
        else
          -- Switch to light variant
          target_theme = theme_pairs[current_theme] or current_theme
        end

        if target_theme ~= current_theme then
          if apply_theme_file(target_theme) then
            vim.notify("Switched from " .. current_theme .. " to " .. target_theme, vim.log.levels.INFO)
          else
            vim.notify("Could not find theme file: " .. target_theme, vim.log.levels.ERROR)
          end
        else
          vim.notify("No light/dark pair configured for " .. current_theme, vim.log.levels.WARN)
        end
      end, {
        desc = "Toggle between paired light and dark themes"
      })

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