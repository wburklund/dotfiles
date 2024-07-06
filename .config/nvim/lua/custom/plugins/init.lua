-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      -- 'ibhagwan/fzf-lua', -- optional
    },
    keys = {
      { '<leader>G', '<cmd>Neogit<cr>', desc = 'Neo[g]it' },
    },
    config = true,
  },
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
