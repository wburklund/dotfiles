--[[i

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

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
vim.keymap.set('n', '<leader>K', function()
  if vim.api.nvim_buf_get_name(0) ~= '' or vim.api.nvim_tabpage_list_wins(0)[2] ~= nil then
    vim.cmd 'tabnew'
  end
  vim.fn.termopen 'k9s'
  vim.keymap.set('n', '<Esc>q', function()
    vim.api.nvim_feedkeys('i', 'n', true)
    vim.api.nvim_feedkeys(vim.api.nvim_eval '"\\<esc>"', 'n', true)
  end, { desc = 'K9s Back/Clear', buffer = true })
  vim.keymap.set('t', '<Esc>q', function()
    vim.api.nvim_feedkeys(vim.api.nvim_eval '"\\<esc>"', 'n', true)
  end, { desc = 'K9s Back/Clear', buffer = true })
end, { desc = 'Open [k]9s' })

-- Terminal keybinds for awless clone

-- Command table

local aws_commands = {
  '[A]WS',
  c = {
    'A[C]M',
    c = {
      '[C]ertificate',
      g = 'acm describe-certificate',
      l = 'acm list-certificates',
    },
  },
  e = {
    '[E]C2',
    a = {
      'Elastic IP [A]ddress',
      l = 'ec2 describe-addresses',
    },
    i = {
      '[I]nstance',
      l = 'ec2 describe-instances',
    },
    k = {
      '[K]eypair',
      l = 'ec2 describe-key-pairs',
    },
    n = {
      '[N]etwork Interface',
      l = 'ec2 describe-network-interfaces',
    },
    s = {
      '[S]ecurity Group',
      l = 'ec2 describe-security-groups',
    },
    ['<C-s>'] = {
      '[S]napshot',
      l = 'ec2 describe-snapshots',
    },
    v = {
      '[V]olume',
      l = 'ec2 describe-volumes',
    },
    g = {
      'Internet [G]ateway',
      l = 'ec2 describe-internet-gateways',
    },
    G = {
      'NAT [G]ateway',
      l = 'ec2 describe-nat-gateways',
    },
    z = {
      'Availability [Z]one',
      l = 'ec2 describe-availability-zones',
    },
    l = {
      'Elastic [L]oad Balancing',
      b = {
        'Load [B]alancer',
        l = 'elb describe-load-balancers',
      },
    },
    L = {
      'Elastic [L]oad Balancing V2',
      b = {
        'Load [B]alancer',
        g = 'elbv2 describe-load-balancer-attributes',
        l = 'elbv2 describe-load-balancers',
      },
      l = {
        '[L]istener',
        l = 'elbv2 describe-listeners',
      },
      t = {
        '[T]arget Group',
        g = 'elbv2 describe-target-group-attributes',
        l = 'elbv2 describe-target-groups',
      },
    },
    S = {
      'EC2 Auto[s]caling',
      c = {
        '[C]onfiguration',
        l = 'autoscaling describe-launch-configurations',
      },
      g = {
        '[G]roup',
        l = 'autoscaling describe-auto-scaling-groups',
      },
      p = {
        '[P]olicy',
        l = 'autoscaling describe-policies',
      },
    },
  },
  E = {
    '[E]CS/[E]CR',
    r = {
      '[R]epository',
      l = 'ecr describe-repositories',
    },
    c = {
      '[C]luster',
      l = 'ecs list-clusters',
      L = 'ecs describe-clusters',
    },
    s = {
      '[S]ervice',
      l = 'ecs list-services',
      L = 'ecs describe-services',
    },
    d = {
      'Task [D]efinition',
      g = 'ecs describe-task-definition',
      l = 'ecs list-task-definitions',
    },
    t = {
      '[T]ask',
      l = 'ecs list-tasks',
      L = 'ecs describe-tasks',
    },
  },
  f = {
    'Cloud[F]ormation',
    s = {
      '[S]tack',
      l = 'cloudformation list-stacks',
      L = 'cloudformation describe-stacks',
    },
  },
  F = {
    'Cloud[F]ront',
    g = 'cloudfront get-distribution',
    l = 'cloudfront list-distributions',
  },
  i = {
    '[I]AM',
    u = {
      '[U]ser',
      g = 'iam get-user',
      l = 'iam list-users',
    },
    g = {
      '[G]roup',
      g = 'iam get-group',
      l = 'iam list-groups',
    },
    r = {
      '[R]ole',
      g = 'iam get-role',
      l = 'iam list-roles',
    },
    p = {
      '[P]olicy',
      g = 'iam get-policy',
      l = 'iam list-policies',
    },
    k = {
      '[K]ey',
      l = 'iam list-access-keys',
    },
    i = {
      '[I]nstance Profile',
      g = 'iam get-instance-profile',
      l = 'iam list-instance-profiles',
    },
    m = {
      '[M]FA Device',
      g = 'iam get-mfa-device',
      l = 'iam list-mfa-devices',
    },
  },
  l = {
    '[L]ambda',
    f = {
      '[F]unction',
      g = 'lambda get-function',
      l = 'lambda list-functions',
    },
  },
  r = {
    '[R]DS',
    d = {
      '[D]B Instance',
      l = 'rds desribe-db-instances',
    },
    s = {
      '[S]ubnet Group',
      l = 'rds describe-db-subnet-groups',
    },
  },
  R = {
    '[R]oute 53',
    r = {
      '[R]ecord Set',
      l = 'route53 list-resource-record-sets',
    },
    z = {
      'Hosted [Z]one',
      g = 'route53 get-hosted-zone',
      l = 'route53 list-hosted-zones',
    },
  },
  s = {
    '[S]3',
    b = {
      '[B]ucket',
      l = 's3api list-buckets',
    },
    o = {
      '[O]bject',
      g = 's3api get-object',
      l = 's3api list-objects',
      L = 's3api list-objects-v2',
    },
  },
  S = {
    '[S]NS/[S]QS',
    s = {
      '[S]ubscription',
      g = 'sns get-subscription-attributes',
      l = 'sns list-subscriptions',
    },
    t = {
      '[T]opic',
      g = 'sns get-topic-attributes',
      l = 'sns list-topics',
    },
    q = {
      '[Q]ueue',
      g = 'sqs get-queue-attributes',
      l = 'sqs list-queues',
    },
  },
  v = {
    '[V]PC',
    v = {
      '[V]PC',
      l = 'ec2 describe-vpcs',
    },
    s = {
      '[S]ubnet',
      l = 'ec2 describe-subnets',
    },
    t = {
      'Route [T]able',
      l = 'ec2 describe-route-tables',
    },
  },
  w = {
    'Cloud[W]atch',
    a = {
      '[A]larm',
      l = 'cloudwatch describe-alarms',
    },
    l = {
      '[L]og',
      e = {
        '[E]vent',
        l = 'logs filter-log-events',
      },
      g = {
        '[G]roup',
        l = 'logs describe-log-groups',
      },
      s = {
        '[S]tream',
        l = 'logs describe-log-streams',
      },
    },
    m = {
      '[M]etric',
      g = 'cloudwatch get-metric-data',
      l = 'cloudwatch list-metrics',
    },
  },
}

-- Register AWS commands upon opening a terminal
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    local wk = require 'which-key'

    local function cmds(table, prefix)
      for k, v in pairs(table) do
        -- Register group name in which-key
        if k == 1 then
          wk.add {
            { prefix, group = v, buffer = true },
          }

        -- Register command
        elseif type(v) == 'string' then
          local cmd = 'aws ' .. v
          wk.add {
            { prefix .. k, 'i' .. cmd .. '<cr>', buffer = true, desc = cmd },
          }

        -- Recur into subtables
        elseif type(v) == 'table' then
          cmds(v, prefix .. k)
        end
      end
    end

    cmds(aws_commands, '<localleader>a')
  end,
})

vim.keymap.set('n', '<C-T>', function()
  ---@diagnostic disable-next-line: param-type-mismatch
  print(os.time(os.date '!*t'))
end, { desc = 'UNIX [T]imestamp (UTC)' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

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

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

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

-- Configure venv for Molten
vim.g.python3_host_prog = vim.fn.expand '~/venvs/neovim.venv/bin/python3'

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    -- dir = '~/Repos/which-key.nvim/',  -- Example to override with local Git repo

    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup {
        spec = {
          { '<leader>M', group = '[M]arp' },
          { '<leader>c', group = '[C]ode' },
          { '<leader>s', group = '[S]earch' },
          { '<leader>t', group = 'Neo[T]est' },
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

      -- Document existing key chains
      -- require('which-key').register {
      --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      --   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      --   ['<leader>M'] = { name = '[M]arp', _ = 'which_key_ignore' },
      -- }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'debugloop/telescope-undo.nvim', -- Undo tree search
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'xiyaowong/telescope-emoji.nvim' },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
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

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'undo')
      pcall(require('telescope').load_extension, 'emoji')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>se', '<cmd>Telescope emoji<cr>', { desc = '[S]earch [E]mojis' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sp', builtin.builtin, { desc = '[S]earch [P]ickers' })
      vim.keymap.set('n', '<leader>sr', builtin.lsp_references, { desc = '[S]earch [R]eferences' })
      vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch [S]ymbols' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>', { desc = '[S]earch [U]ndo tree' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          prompt_title = 'Live Grep in Open File',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gY', require('telescope.builtin').lsp_type_definitions, '[G]oto T[y]pe Definition')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>r', vim.lsp.buf.rename, '[R]ename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
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

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local get_capabilities = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        return vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      end
      local capabilities = get_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

      local servers = {
        -- clangd = {},
        -- gopls = {},
        basedpyright = {
          capabilities = (function() -- Trim capabilities since we are using Ruff
            local caps = get_capabilities()
            caps.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 } -- Disable pyright hints
            return caps
          end)(),
          settings = {
            basedpyright = {
              disableOrganizeImports = true, -- Let Ruff handle import sorting
              analysis = {
                diagnosticSeverityOverrides = { -- Disable basedpyright diagnostic messages in favor of Ruff's
                  reportAny = false,
                  reportExplicitAny = false,
                  reportImplicitRelativeImport = false,
                  reportMissingTypeArgument = false,
                  reportMissingTypeStubs = false,
                  reportOptionalMemberAccess = false,
                  reportTypedDictNotRequiredAccess = false,
                  reportUnknownArgumentType = false,
                  reportUnknownMemberType = false,
                  reportUnknownParameterType = false,
                  reportUnknownVariableType = false,
                  reportUnusedImport = false,
                },
              },
            },
          },
          before_init = function(_, config) -- Include Pylance type stubs
            config.settings.basedpyright.analysis.stubPath = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy', 'python-type-stubs')
          end,
        },
        ruff_lsp = {
          on_attach = function(client)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end,
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              args = { '--config=' .. os.getenv 'HOME' .. '/.config/nvim/ruff.toml' }, -- Use custom Ruff ruleset (Hatch-like)
            },
          },
        },
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        gopls = {},

        html = {},
        jsonls = {
          capabilities = (function() -- Add snippet support
            local caps = get_capabilities()
            caps.textDocument.completion.completionItem.snippetSupport = true
          end)(),
        },
        texlab = {},
        yamlls = {},
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  { 'microsoft/python-type-stubs' },
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
    },
    event = 'VeryLazy',
    config = function()
      local function shorten_name(filename) -- Prune unnecessary parts of displayed venv paths
        local hatch_home = os.getenv 'HOME' .. '/Library/Application Support/hatch'
        return filename:gsub(hatch_home, '~Hatch'):gsub(os.getenv 'HOME', '~'):gsub('/bin/python', '')
      end

      require('venv-selector').setup {
        settings = {
          options = {
            on_telescope_result_callback = shorten_name,
          },

          search = {
            hatch = { -- Look specifically at Hatch's environments, filtering out debugpy
              command = "fd -p -d 6 '/bin/python$' ~/Library/Application\\\\ Support/hatch/env",
            },
            my_envs = { -- My personal venv directory
              command = "fd -p -d 3 '/bin/python$' ~/venvs",
            },
          },
        },
      }
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      popup_border_style = 'rounded',
      window = {
        position = 'float',
        mappings = {
          s = false,
          S = false,
          o = 'system_open',
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- macOs: open file in default application in the background.
          vim.fn.jobstart({ 'open', '-g', path }, { detach = true })
        end,
      },
    },
    keys = {
      { '<leader>F', '<cmd>Neotree reveal<cr>', desc = '[F]ile tree' },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      columns = { 'icon', 'permissions', 'size' },
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
        case_insensitive = true,
        is_always_hidden = function(name)
          return vim.endswith(name, '.pyc')
        end,
      },
    },
    keys = {
      { '<leader><C-F>', '<cmd>Oil<cr>', desc = '[F]ilesystem browser' },
    },
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 1000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
        html = { 'prettierd' },
        css = { 'prettierd' },
        javascript = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
      },
      formatters = {
        ruff_format = {
          args = { 'format', '--config=' .. os.getenv 'HOME' .. '/.config/nvim/ruff.toml', '--force-exclude', '--stdin-filename', '$FILENAME', '-' },
        },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      'MattiasMTS/cmp-dbee',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },

        cmp.setup.filetype({ 'sql' }, {
          sources = {
            -- { name = 'vim-dadbod-completion' },
            { name = 'cmp-dbee' },
            { name = 'buffer' },
          },
        }),
      }
    end,
  },
  {
    'someone-stole-my-name/yaml-companion.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function(opts)
      local cfg = require('yaml-companion').setup(opts)
      require('lspconfig')['yamlls'].setup(cfg)
      require('telescope').load_extension 'yaml_schema'
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.

    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    --'folke/tokyonight.nvim',
    -- 'ellisonleao/gruvbox.nvim',
    'neanias/everforest-nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.colorscheme 'gruvbox'
      -- vim.g.gruvbox_contrast_dark = 'soft'
      vim.cmd.colorscheme 'everforest'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      background = 'hard',
      ui_contrast = 'high',
    },
    main = 'everforest',
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'rmagatti/auto-session',
    },
    config = function()
      -- Need opts in here so that the auto-session dependency is processed before accessing
      require('lualine').setup {
        options = {
          globalstatus = true,
        },
        sections = {
          lualine_c = { require('auto-session.lib').current_session_name },
          lualine_x = {},
          lualine_y = { 'filename' },
        },
        extensions = { 'nvim-dap-ui', 'oil' },
      }
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim

      --  TODO: Is there more I need to do to enable icons?
      require('mini.icons').setup() -- Icons.
      require('mini.pairs').setup() -- Auto complete bracket pairs
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        disable = { 'latex' },
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  -- Only show one line of context per scope
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup { multiline_threshold = 1 }
      vim.keymap.set('n', '[c', function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end, { silent = true })
    end,
  },
  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- https://github.com/nvim-lua/kickstart.nvim
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  {
    'windwp/nvim-ts-autotag',
    branch = 'nvim_0.9',
    opts = { -- Use </ for closing tags instead of auto like for VSCode: friendlier with auto-indent
      enable_close = false,
      enable_close_on_slash = true,
    },
  }, -- Automate tag handling
  { import = 'custom.plugins' },
}, {
  change_detection = {
    enabled = false,
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Auto open preview in Oil file browser
vim.api.nvim_create_autocmd('User', {
  pattern = 'OilEnter',
  callback = vim.schedule_wrap(function(args)
    local oil = require 'oil'
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
