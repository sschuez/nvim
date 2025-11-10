# Neovim Keybindings Reference

## Completion (blink.cmp)

### Core Navigation
- `<C-Space>` - Manually show completions
- `<C-n>` or `<Down>` - Select next item
- `<C-p>` or `<Up>` - Select previous item
- `<CR>` (Enter) - Accept selected item
- `<C-e>` - Hide/cancel completion menu

### Documentation
- `<C-b>` - Scroll documentation up
- `<C-f>` - Scroll documentation down
- `<C-Space>` (when menu open) - Toggle documentation

### Snippets
- `<Tab>` - Jump to next snippet placeholder
- `<S-Tab>` - Jump to previous snippet placeholder

### Signature Help
- `<C-h>` - Show/hide function signature

## Window Management

### Window Resizing
- `<C-S-Up>` - Increase window height
- `<C-S-Down>` - Decrease window height
- `<C-S-Left>` - Decrease window width
- `<C-S-Right>` - Increase window width

## General Editing

### Custom Mappings
- `Y` - Yank to end of line (consistent with D and C)

## CodeCompanion (AI Assistant)

### Main Commands
- `:CodeCompanion` - Open inline assistant
- `:CodeCompanionChat` - Open chat buffer
- `:CodeCompanionChat Toggle` - Toggle chat buffer (create/show/hide)
- `:CodeCompanionActions` - Open action palette
- `:CodeCompanionCmd` - Generate command-line mode command

### Chat Buffer Navigation
- `<CR>` or `<C-s>` - Send message to LLM
- `<C-c>` - Close chat buffer
- `q` - Stop current request
- `[[` - Move to previous header/response
- `]]` - Move to next header/response
- `{` - Move to previous chat buffer
- `}` - Move to next chat buffer

### Chat Buffer Actions
- `ga` - Change adapter (switch between models)
- `gc` - Insert codeblock
- `gd` - View/debug chat contents
- `gD` - View super diff feature
- `gf` - Fold all codeblocks
- `gM` - Clear all memory
- `gp` - Pin context item
- `gr` - Regenerate last response
- `gR` - Jump to file under cursor
- `gs` - Toggle system prompt
- `gS` - Show Copilot usage stats
- `gta` - Toggle auto tool mode
- `gw` - Watch buffer as context
- `gx` - Clear chat contents
- `gy` - Yank last codeblock

### Inline Assistant
- `ga` - Accept suggested change
- `gr` - Reject suggested change
- `gdy` - Accept all changes (yolo mode)

### Context Triggers (in chat buffer)
- `#{variable}` - Insert variables (e.g., `#{buffer}`, `#{buffers}`)
- `@{tool}` - Invoke tools (e.g., `@files`, `@cmd_runner`)
- `/{slash_command}` - Run slash commands (e.g., `/buffer`, `/file`)
- `\command` - ACP agent commands (converts to `/command`)
