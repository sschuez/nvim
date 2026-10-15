-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Fix YAML filetype detection for Rails projects
-- Rails YAML files are detected as eruby.yaml, but we want plain yaml for Treesitter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "eruby.yaml",
  command = "set filetype=yaml",
})

-- Fix turbo_stream.erb filetype detection
-- turbo_stream.erb files should be eruby, not eruby.html
vim.api.nvim_create_autocmd("FileType", {
  pattern = "eruby.html",
  command = "set filetype=eruby",
})

-- Add transparency
-- Clear only the background, so each group keeps its foreground and styles
local transparent_groups = {
  -- transparent background
  "Normal",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "Terminal",
  "EndOfBuffer",
  "FoldColumn",
  "Folded",
  "SignColumn",
  "NormalNC",
  "WhichKeyFloat",
  "TelescopeBorder",
  "TelescopeNormal",
  "TelescopePromptBorder",
  "TelescopePromptTitle",
  "SnacksDashboardNormal",
  "StatusLine",

  -- transparent background for neotree
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "NeoTreeVertSplit",
  "NeoTreeWinSeparator",
  "NeoTreeEndOfBuffer",

  -- transparent background for nvim-tree
  "NvimTreeNormal",
  "NvimTreeVertSplit",
  "NvimTreeEndOfBuffer",

  -- transparent notify background
  "NotifyINFOBody",
  "NotifyERRORBody",
  "NotifyWARNBody",
  "NotifyTRACEBody",
  "NotifyDEBUGBody",
  "NotifyINFOTitle",
  "NotifyERRORTitle",
  "NotifyWARNTitle",
  "NotifyTRACETitle",
  "NotifyDEBUGTitle",
  "NotifyINFOBorder",
  "NotifyERRORBorder",
  "NotifyWARNBorder",
  "NotifyTRACEBorder",
  "NotifyDEBUGBorder",
}

local theme_highlights = vim.api.nvim_create_augroup("theme_highlights", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = theme_highlights,
  callback = function()
    for _, name in ipairs(transparent_groups) do
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      hl.bg = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end,
})

-- Fix fuzzy finder highlights for light themes
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = theme_highlights,
  callback = function()
    vim.schedule(function()
      if vim.o.background == "light" then
        -- Check if theme provides custom fzf colors
        local fzf_colors = vim.g.theme_fzf_colors
          or {
            text_fg = "#4c4f69", -- Default dark text for readability
            match_fg = "#d7827e", -- Default rose color for matched text
            selection_bg = "#e6e9ef", -- Default light gray for selection
          }

        vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = fzf_colors.match_fg, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = fzf_colors.selection_bg })
        vim.api.nvim_set_hl(0, "FzfLuaNormal", { fg = fzf_colors.text_fg })
        vim.api.nvim_set_hl(0, "FzfLuaFzfMatch", { fg = fzf_colors.match_fg, bold = true })
        vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { bg = fzf_colors.selection_bg, fg = fzf_colors.text_fg })
      end
    end)
  end,
})

-- Without a file argument, LazyVim loads this file after VimEnter, so run the handlers above now
if vim.v.vim_did_enter == 1 then
  vim.api.nvim_exec_autocmds("VimEnter", { group = theme_highlights })
end
