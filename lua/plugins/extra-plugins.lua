return {
  -- { "tpope/vim-commentary" },
  -- { "tpope/vim-surround" },
  -- { "tpope/vim-ragtag" },
  { "mg979/vim-visual-multi" },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby", "haml", "slim", "rspec" },
    dependencies = { "tpope/vim-bundler" },
    init = function()
      -- Force vim-rails to recognize the project
      vim.g.rails_projections = {}
    end,
    config = function()
      -- Ensure syntax is enabled for eruby files so vim-rails can detect context
      -- Use BufEnter so it fires EVERY time we enter a ruby/eruby buffer
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.rb", "*.erb", "*.haml", "*.slim", "*.rake", "*.ru" },
        callback = function()
          local ft = vim.bo.filetype
          if ft == "ruby" or ft == "eruby" or ft == "haml" or ft == "slim" then
            -- Enable syntax (required for vim-rails gf to work)
            vim.cmd("syntax enable")
            -- Force set the syntax to match filetype
            vim.bo.syntax = ft
          end
        end,
      })
    end,
  },
  -- Add vim-bundler as vim-rails dependency
  { "tpope/vim-bundler", lazy = true },
  -- { "vim-ruby/vim-ruby" },
  -- { "brenoprata10/nvim-highlight-colors" },
}
