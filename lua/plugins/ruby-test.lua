-- User a custom strategy to run test in tmux vertical pane
vim.cmd([[
function! TestStrategy(cmd)
  let l:escaped_cmd = shellescape(a:cmd)
  call system("tmux split-window -v")
  call system("tmux send-keys " . l:escaped_cmd . " C-m")
  " Optionally, keep the pane open by sending 'bash' or another command
endfunction

let g:test#custom_strategies = {'tmux_custom': function('TestStrategy')}
let g:test#strategy = 'tmux_custom'
]])

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.api.nvim_set_keymap("n", "<leader>t", ":TestNearest<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>T", ":TestFile<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>H", ":TestLast<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>h", ":TestSuite<CR>", { noremap = true, silent = true })
  end,
})

return {
  {
    "vim-test/vim-test",
    config = function()
      -- Set tmux as the default strategy for running tests
      vim.cmd([[let test#strategy = "tmux_custom"]])
    end,
  },
}
