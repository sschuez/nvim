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

## vim-rails Navigation

### Go to File (gf variants)
- `gf` - Go to file under cursor
  - From `render 'partial_name'` → jumps to `_partial_name.html.erb`
  - From model name → jumps to model file
  - From association → jumps to associated model
- `<C-W>f` - Open file in horizontal split
- `<C-W>gf` - Open file in new tab
- `<C-W><C-F>` - Open file in horizontal split (same as `<C-W>f`)

### Alternate Files
- `:A` - Switch to alternate file (e.g., controller ↔ test)
- `:AS` - Open alternate in horizontal split
- `:AV` - Open alternate in vertical split
- `:AT` - Open alternate in new tab

### Related Files
- `:R` - Switch to related file (e.g., view → controller)
- `:RS` - Open related in horizontal split
- `:RV` - Open related in vertical split
- `:RT` - Open related in new tab

### Quick Navigation Commands
- `:Econtroller [name]` - Edit controller
- `:Emodel [name]` - Edit model
- `:Eview [name]` - Edit view
- `:Ehelper [name]` - Edit helper
- `:Ejavascript [name]` or `:Estylesheet [name]` - Edit assets
- `:Emigration [name]` - Edit migration
- `:Espec [name]` or `:Etest [name]` - Edit test/spec

#### Split Variants
Each navigation command has split variants:
- `:S` prefix = horizontal split (e.g., `:Scontroller users`)
- `:V` prefix = vertical split (e.g., `:Vmodel post`)
- `:T` prefix = new tab (e.g., `:Tview posts/index`)

### Generate/Destroy
- `:Rgenerate controller posts` - Generate controller
- `:Rdestroy model post` - Destroy model

### Common Workflow Examples
```vim
" Open users controller in vertical split
:Vcontroller users

" Open post model in horizontal split
:Smodel post

" Open posts/index view in new tab
:Tview posts/index

" Navigate to partial from render statement
" Cursor on 'project_documents' in render 'project_documents'
gf              " Opens in same window
<C-W>f          " Opens in horizontal split
<C-W>gf         " Opens in new tab
```

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
