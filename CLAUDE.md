# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [LazyVim](https://www.lazyvim.org/), a Neovim configuration framework built on top of [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. LazyVim provides a modern, well-structured starting point with sensible defaults and a modular architecture.

## Architecture

### Directory Structure

- `init.lua` - Entry point that bootstraps the config by requiring `config.lazy`
- `lua/config/` - Core configuration files:
  - `lazy.lua` - Bootstraps lazy.nvim and defines plugin loading strategy
  - `options.lua` - Custom Neovim options (extends LazyVim defaults)
  - `keymaps.lua` - Custom keymaps (extends LazyVim defaults)
  - `autocmds.lua` - Custom autocommands (extends LazyVim defaults)
- `lua/plugins/` - Plugin specifications and configurations
  - Each `.lua` file here is automatically loaded by lazy.nvim
  - Files should return a table with plugin specifications
  - `example.lua` exists but is disabled (returns empty table)

### Plugin Management

LazyVim uses a two-layer plugin system:
1. **Base LazyVim plugins** - Imported from `lazyvim.plugins`
2. **Custom plugins** - Defined in `lua/plugins/` directory

The configuration in `lazy.lua` shows:
- Plugins are lazy-loaded by default (only LazyVim core plugins)
- Custom plugins load during startup unless configured otherwise
- Plugin updates are automatically checked
- Default colorschemes: tokyonight, habamax

### Configuration Strategy

LazyVim follows an override/extend pattern:
- Default settings come from LazyVim
- Custom configs in `lua/config/*.lua` are loaded automatically and extend/override defaults
- Plugin specs in `lua/plugins/` can:
  - Add new plugins
  - Override LazyVim plugin configurations using `opts` tables or functions
  - Disable plugins with `enabled = false`
  - Import LazyVim extras: `{ import = "lazyvim.plugins.extras.lang.typescript" }`

## Development

### Adding New Plugins

Create a new file in `lua/plugins/` (e.g., `myplugin.lua`) that returns a plugin spec:

```lua
return {
  "author/plugin-name",
  opts = {
    -- plugin options
  },
}
```

### Overriding LazyVim Plugins

In any `lua/plugins/*.lua` file, return a spec with the same plugin name:

```lua
return {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "my-colorscheme",
  },
}
```

### Extending Options/Keymaps/Autocmds

Edit the respective files in `lua/config/`:
- Options: `vim.opt.setting = value`
- Keymaps: `vim.keymap.set(mode, key, action, opts)`
- Autocmds: `vim.api.nvim_create_autocmd(events, opts)`

### Code Formatting

Lua code should follow these style guidelines (defined in `stylua.toml`):
- Indent: 2 spaces
- Column width: 120 characters
- Format with: `stylua .`

### Plugin State

- `lazy-lock.json` - Locks plugin versions for reproducibility
- Update locked versions: Run `:Lazy update` in Neovim
- Sync plugins: Run `:Lazy sync` in Neovim

## Important Notes

- The `lua/plugins/example.lua` file is disabled with `if true then return {} end` - it serves as documentation only
- LazyVim automatically loads configs on the `VeryLazy` event for performance
- Check LazyVim documentation for default keymaps and options: https://lazyvim.github.io
- The config uses `neodev` and `neoconf` for enhanced Lua development support (configured in `.neoconf.json`)
