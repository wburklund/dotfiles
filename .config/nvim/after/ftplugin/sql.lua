vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>W', '<Plug>(DBUI_SaveQuery)', { desc = '[W]rite query' })
vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>E', '<Plug>(DBUI_EditBindParameters)', { desc = '[E]dit bind parameters' })
vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>S', '<Plug>(DBUI_ExecuteQuery)', { desc = 'Execute query' })
vim.api.nvim_buf_set_keymap(0, 'v', '<localleader>S', '<Plug>(DBUI_ExecuteQuery)', { desc = 'Execute query' })
