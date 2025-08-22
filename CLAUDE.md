# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration built on LazyVim, a modern Neovim distribution. The configuration is primarily focused on Ruby on Rails development with additional web development tooling.

## Commands

### Code Formatting

- `stylua .` - Format Lua code using StyLua (configured in stylua.toml with 2-space indentation, 120 column width)
- `bundle exec rubocop --lsp` - Ruby linting (requires project Gemfile with RuboCop)

#### ERB/HTML Formatting (Herb Tools - Fast C-based)

- `herb-format <file>` or `herb-format --stdin` - Fast ERB/HTML formatting (sub-10ms vs 100+ms legacy)
- `herb-lint <file>` - ERB/HTML linting with 20+ rules and detailed diagnostics
- `herb-language-server` - LSP server providing real-time formatting and linting

#### Legacy ERB Formatting (Slow - replaced by Herb)

- `bundle exec erb_lint --autocorrect --format compact --config .erb_lint.yml <file>` - ERB template linting
- `bundle exec htmlbeautifier --keep-blank-lines 1 <file>` - HTML/ERB formatting

### Testing (via vim-test plugin)

- `<leader>t` - Run test nearest to cursor
- `<leader>T` - Run current test file
- `<leader>H` - Run last test
- `<leader>h` - Run entire test suite
- Tests run in tmux split panes via custom strategy in ruby-test.lua:4-12

## Architecture

### Plugin Management

- Uses Lazy.nvim for plugin management (lua/config/lazy.lua:17-53)
- LazyVim base configuration with custom plugin overrides in lua/plugins/
- Plugin specifications are auto-loaded from lua/plugins/ directory

### Key Components

#### LSP Configuration (lua/plugins/lsp-config.lua)

- Ruby LSP via ruby-lsp gem (requires rbenv setup at ~/.rbenv/shims/ruby-lsp)
- RuboCop LSP integration for linting
- Herb LSP for ERB files - provides real-time formatting, linting, and diagnostics
- Mason disabled for Ruby tooling to use project-local versions

#### AI Integration (lua/plugins/avante.lua)

- Avante.nvim plugin for AI assistance
- Configured with OpenAI GPT-4o model
- Includes image pasting support via img-clip.nvim

#### Formatting (lua/plugins/conform.lua)

- Conform.nvim for code formatting
- **Herb formatter for ERB files** - C-based parser providing sub-10ms formatting (replaces slow erb_lint + htmlbeautifier)
- Prettier for JS/TS/CSS/HTML/JSON/YAML/Markdown
- XML formatting via xmllint
- Legacy Ruby-based ERB formatters kept for reference but replaced by Herb

#### Ruby on Rails Support

- vim-rails plugin enabled (lua/plugins/nvim-plugins.lua:6)
- Custom ERB file type detection for .eruby.yaml files (lua/plugins/conform.lua:1-4)

### File Organization

- `init.lua` - Entry point, bootstraps lazy.nvim
- `lua/config/` - Core LazyVim configuration overrides
- `lua/plugins/` - Custom plugin specifications and configurations
- `lazy-lock.json` - Locked plugin versions
- `stylua.toml` - Lua code style configuration

### Development Environment

- Requires rbenv for Ruby version management
- Requires tmux for test runner integration
- **Node.js 16+** for Herb tools (@herb-tools/language-server, @herb-tools/formatter, @herb-tools/linter)
- Node.js dependencies for Prettier XML plugin
- Bundle/Gemfile setup expected for Ruby projects

### Installation Commands

```bash
# Install Herb tools globally for fast ERB formatting
npm install -g @herb-tools/language-server @herb-tools/formatter @herb-tools/linter
```

## Important Notes

**Do not include Claude/AI references in PRs or commits.** All pull request descriptions and commit messages should be professional and not mention AI assistance, Claude Code, or similar references.
