-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'tpope/vim-fugitive', -- Install Vim Fugitive
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>G', '<cmd>LazyGit<cr>', desc = 'Lazy[G]it' },
    },
  },
  {
    'crnvl96/lazydocker.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>D', '<cmd>LazyDocker<cr>', desc = 'Lazy[D]ocker' },
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  }, -- Dadbod SQL client
  {
    'mpas/marp-nvim',
    opts = {},
    keys = {
      { '<leader>MT', '<cmd>MarpToggle<cr>', desc = '[M]arp [T]oggle' },
      { '<leader>MS', '<cmd>MarpStatus<cr>', desc = '[M]arp [S]tatus' },
    },
  }, -- Markdown presentation framework
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = '[A]dd Harpoon file' })
      vim.keymap.set('n', '<C-[>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon quick menu' })

      vim.keymap.set('n', '<C-u>', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon file 1' })
      vim.keymap.set('n', '<C-i>', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon file 2' })
      vim.keymap.set('n', '<C-o>', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon file 3' })
      vim.keymap.set('n', '<C-p>', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon file 4' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end, { desc = '[P]revious Harpoon file' })
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end, { desc = '[N]ext Harpoon file' })

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader>s[', function()
        toggle_telescope(harpoon:list())
      end, { desc = '[S]earch Harpoon' })
    end,
  },
}
