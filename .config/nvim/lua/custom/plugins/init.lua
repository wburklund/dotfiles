-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'tpope/vim-fugitive', -- Install Vim Fugitive
  {
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

      -- Override table helpers since the inconsistent capitalization bugs me
      local basic_constraint_query =
        [[SELECT tc.constraint_name, tc.table_name, kcu.column_name, ccu.table_name AS foreign_table_name, ccu.column_name AS foreign_column_name, rc.update_rule, rc.delete_rule
FROM
     information_schema.table_constraints AS tc
     JOIN information_schema.key_column_usage AS kcu
       ON tc.constraint_name = kcu.constraint_name
     JOIN information_schema.referential_constraints as rc
       ON tc.constraint_name = rc.constraint_name
     JOIN information_schema.constraint_column_usage AS ccu
       ON ccu.constraint_name = tc.constraint_name
]]
      local postgres_pk_query = [[SELECT a.attname, format_type(a.atttypid, a.atttypmod) AS data_type, array_position(i.indkey, a.attnum) AS position
FROM pg_index i
JOIN   pg_attribute a ON a.attrelid = i.indrelid
                     AND a.attnum = ANY(i.indkey)
WHERE  i.indrelid = '{schema}.{table}'::regclass
AND    i.indisprimary
ORDER BY position;]]

      vim.g.db_ui_table_helpers = {
        postgres = {
          List = 'SELECT * FROM {optional_schema}"{table}" LIMIT 200',
          Columns = "SELECT * FROM information_schema.columns WHERE table_name = '{table}' AND table_schema = '{schema}'",
          Indexes = "SELECT * FROM pg_indexes WHERE tablename = '{table}' AND schemaname = '{schema}'",
          ['Foreign Keys'] = basic_constraint_query .. "WHERE constraint_type = 'FOREIGN KEY'\nAND tc.table_name = '{table}'\nAND tc.table_schema = '{schema}'",
          ['References'] = basic_constraint_query .. "WHERE constraint_type = 'FOREIGN KEY'\nAND ccu.table_name = '{table}'\nAND tc.table_schema = '{schema}'",
          ['Primary Keys'] = postgres_pk_query,
        },
      }
    end,
    keys = {
      { '<leader>S', '<cmd>DBUI<cr>', desc = 'Dadbod [S]QL Client' },
    },
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

      vim.keymap.set('n', '<C-y>', function()
        harpoon:list():add()
      end, { desc = 'Harpoon add file' })
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
  {
    'lervag/vimtex',
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'skim'
    end,
  },
}
