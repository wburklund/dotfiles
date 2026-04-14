-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
-- vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Configure tabstop/shiftwidth
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.expandtab = true

if vim.g.neovide then
  -- Disable Neovide animations
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00

  -- Start with home as working directory
  vim.api.nvim_set_current_dir '~'
end

vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Allow running .nvimrc, .exrc, or init.lua from project directories
vim.o.exrc = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [d]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show [d]iagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic [q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>T', function()
  if vim.api.nvim_buf_get_name(0) ~= '' or vim.api.nvim_tabpage_list_wins(0)[2] ~= nil then
    vim.cmd 'tabnew'
  end
  vim.cmd.terminal()
end, { desc = 'Open [T]erminal' })

vim.keymap.set('n', '<C-T>', function()
  ---@diagnostic disable-next-line: param-type-mismatch
  print(os.time(os.date '!*t'))
end, { desc = 'UNIX [T]imestamp (UTC)' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Post-install hooks
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path })
    elseif ev.data.spec.name == 'nvim-dbee' then
      require('dbee').install()
    end
  end,
})

-- Install packages
vim.pack.add {
  -- Everforest
  'https://github.com/neanias/everforest-nvim',

  -- Lualine
  'https://github.com/nvim-lualine/lualine.nvim',

  -- Tree-sitter
  'https://github.com/arborist-ts/arborist.nvim',

  -- Telescope
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/debugloop/telescope-undo.nvim', -- Undo tree search
  'https://github.com/xiyaowong/telescope-emoji.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',

  -- LSP
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/folke/lazydev.nvim',

  -- DAP
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',

  -- Git
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/kdheepak/lazygit.nvim',

  -- Docker
  'https://github.com/akinsho/toggleterm.nvim',
  'https://github.com/mgierada/lazydocker.nvim',

  -- Database
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/kndndrj/nvim-dbee',

  -- Markdown
  'https://github.com/mpas/marp-nvim',

  -- LaTeX
  'https://github.com/lervag/vimtex',

  -- Oil
  'https://github.com/stevearc/oil.nvim',

  -- Todo-comments
  'https://github.com/folke/todo-comments.nvim',

  -- Autocomplete
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/MattiasMTS/cmp-dbee',
  'https://github.com/hrsh7th/nvim-cmp',

  -- Formatting
  'https://github.com/stevearc/conform.nvim',

  -- Which-key
  'https://github.com/folke/which-key.nvim',
}

--: Everforest
require('everforest').setup { background = 'hard', ui_contrast = 'high' }
vim.cmd.colorscheme 'everforest'
vim.cmd.hi 'Comment gui=none'

--: Lualine
require('lualine').setup {
  options = {
    globalstatus = true,
  },
}

--: Tree-sitter
require('arborist').setup()

--: Telescope
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<C-d>'] = require('telescope.actions').delete_buffer,
        },
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
    undo = {
      mappings = {
        i = {
          ['<A-cr>'] = require('telescope-undo.actions').yank_deletions,
        },
      },
    },
  },
}
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'undo'
require('telescope').load_extension 'emoji'

-- Global searches
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>se', '<cmd>Telescope emoji<cr>', { desc = '[S]earch [E]mojis' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').builtin, { desc = '[S]earch [P]ickers' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').lsp_references, { desc = '[S]earch [R]eferences' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[S]earch [S]ymbols' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>', { desc = '[S]earch [U]ndo tree' })
vim.keymap.set('n', '<leader>s.', require('telescope.builtin').oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sn', function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim Files ("." for repeat)' })

-- LSP-scoped searches
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('gY', require('telescope.builtin').lsp_type_definitions, '[G]oto T[y]pe Definition')
    map('<leader>r', vim.lsp.buf.rename, '[R]ename')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end,
})

--: LSP
require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'lua_ls',
    'stylua',
    'ty',
    'ruff',
  },
}
require('lazydev').setup {
  library = { 'nvim-dap-ui' },
}

-- Diagnotic configuration: show LSP and error code
vim.diagnostic.config {
  virtual_text = {
    source = true,
    format = function(diagnostic)
      if diagnostic.code then
        return ('[%s] %s'):format(diagnostic.code, diagnostic.message)
      end

      return diagnostic.message
    end,
  },
  signs = true,
  float = {
    header = 'Diagnostics',
    source = true,
    border = 'rounded',
  },
}

-- Highlights, inlay hints
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup('telescope-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'telescope-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- The following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

--: DAP
require('mason-nvim-dap').setup { ---@diagnostic disable-line: missing-fields
  automatic_installation = true,
}
vim.keymap.set('n', '<F5>', require('dap').continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', require('dap').step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', require('dap').step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', require('dap').step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', require('dap').toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })

require('dapui').setup()
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F7>', require('dapui').toggle, { desc = 'Debug: See last session result.' })
require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close
vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

--vim.o.complete = '.,o' -- use buffer and omnifunc
--vim.o.completeopt = 'fuzzy,menuone,popup,noselect'
--vim.o.autocomplete = true

--: Git
require('gitsigns').setup {
  current_line_blame = true,
  numhl = true,
  sign_priority = 15,
}
vim.keymap.set('n', '<leader>G', '<cmd>LazyGit<cr>', { desc = 'Lazy[G]it' })

--: Docker
require('lazydocker').setup()
vim.keymap.set('n', '<leader>D', require('lazydocker').open, { desc = 'Lazy[D]ocker' })

--: Database
local dbee_opts = function(opts)
  opts.noremap = true
  opts.nowait = true
  return opts
end
if not vim.g.dbee_setup_called then
  require('dbee').setup { ---@diagnostic disable-line: missing-fields
    drawer = {
      mappings = {
        { key = 'r', mode = 'n', action = 'refresh', opts = dbee_opts { desc = '[R]efresh' } },
        { key = '<cr>', mode = 'n', action = 'action_1', opts = dbee_opts { desc = 'Open/execute' } },
        { key = 'e', mode = 'n', action = 'action_2', opts = dbee_opts { desc = 'R[e]name/s[e]t connection as active' } },
        { key = 'd', mode = 'n', action = 'action_3', opts = dbee_opts { desc = '[D]elete' } },
        { key = 't', mode = 'n', action = 'toggle', opts = dbee_opts { desc = '[T]oggle' } },
        { key = '<cr>', mode = 'n', action = 'menu_confirm', opts = dbee_opts { desc = 'Menu confirm' } },
        { key = 'y', mode = 'n', action = 'menu_yank', opts = dbee_opts { desc = 'Menu yank' } },
        { key = '<esc>', mode = 'n', action = 'menu_close', opts = dbee_opts { desc = 'Menu close' } },
      },
    },
    editor = {
      mappings = {
        { key = '<C-r>', mode = 'x', action = 'run_selection', opts = dbee_opts { desc = '[R]un selection' } },
        { key = '<C-r>', mode = 'n', action = 'run_file', opts = dbee_opts { desc = '[R]un all' } },
      },
    },
    result = {
      mappings = {
        -- next/previous page
        { key = '[p', mode = '', action = 'page_prev', opts = dbee_opts { desc = 'Previous [p]age' } },
        { key = ']p', mode = '', action = 'page_next', opts = dbee_opts { desc = 'Next [p]age' } },
        { key = '[P', mode = '', action = 'page_first', opts = dbee_opts { desc = 'First [p]age' } },
        { key = ']P', mode = '', action = 'page_last', opts = dbee_opts { desc = 'Last [p]age' } },
        -- yank rows as csv/json
        { key = '<C-y>j', mode = 'n', action = 'yank_current_json', opts = dbee_opts { desc = '[Y]ank row [J]SON' } },
        { key = '<C-y>j', mode = 'x', action = 'yank_selection_json', opts = dbee_opts { desc = '[Y]ank selection [J]SON' } },
        { key = '<C-y>J', mode = 'n', action = 'yank_all_json', opts = dbee_opts { desc = '[Y]ank all [J]SON' } },
        { key = '<C-y>c', mode = 'n', action = 'yank_current_csv', opts = dbee_opts { desc = '[Y]ank row [C]SV' } },
        { key = '<C-y>c', mode = 'x', action = 'yank_selection_csv', opts = dbee_opts { desc = '[Y]ank selection [C]SV' } },
        { key = '<C-y>C', mode = 'n', action = 'yank_all_csv', opts = dbee_opts { desc = '[Y]ank all [C]SV' } },
        -- cancel current call execution
        { key = '<C-c>', mode = '', action = 'cancel_call', opts = dbee_opts { desc = '[C]ancel current execution' } },
      },
    },
  }
  vim.g.dbee_setup_called = true
end
vim.keymap.set('n', '<leader>S', '<cmd>Dbee<cr>', { desc = 'DBee [S]QL client' })

--: Markdown
require('marp').setup()
vim.keymap.set('n', '<leader>MT', '<cmd>MarpToggle<cr>', { desc = '[M]arp [T]oggle' })
vim.keymap.set('n', '<leader>MS', '<cmd>MarpStatus<cr>', { desc = '[M]arp [S]tatus' })

--: LaTeX
vim.g.vimtex_view_method = 'skim'

--: Oil
require('oil').setup {
  columns = {
    'icon',
    'size',
  },
  view_options = {
    case_insensitive = true,
    is_always_hidden = function(name)
      return vim.endswith(name, '.pyc')
    end,
    show_hidden = true,
  },
  watch_for_changes = true,
}

vim.keymap.set('n', '<leader>F', '<cmd>Oil<cr>', { desc = '[F]ilesystem browser' })

-- Auto open preview
vim.api.nvim_create_autocmd('User', {
  pattern = 'OilEnter',
  callback = vim.schedule_wrap(function(args)
    if vim.api.nvim_get_current_buf() == args.data.buf and require('oil').get_cursor_entry() then
      require('oil').open_preview()
    end
  end),
})

--: Todo-comments
require('todo-comments').setup()

--: Autocomplete
require('cmp').setup {
  completion = { completeopt = 'menu,menuone,popup,noinsert' },
  mapping = {
    ['<C-n>'] = require('cmp').mapping.select_next_item(),
    ['<C-p>'] = require('cmp').mapping.select_prev_item(),
    -- Scroll the documentation window [b]ack / [f]orward
    ['<C-b>'] = require('cmp').mapping.scroll_docs(-4),
    ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
    -- Accept ([y]es) the completion.
    ['<C-y>'] = require('cmp').mapping.confirm { select = true },
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
}
require('cmp').setup.filetype({ 'sql' }, {
  sources = {
    { name = 'cmp-dbee' },
    { name = 'buffer' },
  },
})
require('cmp-dbee').setup()
-- Capitalize SQL keywords
for _, item in pairs(require('cmp-dbee.constants').reserved_sql_keywords) do
  item.name = string.upper(item.name)
end

--: Formatting
require('conform').setup {
  format_on_save = {},
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff' },
  },
}

--: Which-key
require('which-key').setup {
  spec = {
    { '<leader>M', group = '[M]arp' },
    { '<leader>c', group = '[C]ode' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>d', group = '[D]iagnostic' },
    { '<leader>H', group = 'Git[H]ub' },
    {
      '<localleader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Show buffer-local keymaps',
    },
  },
}
