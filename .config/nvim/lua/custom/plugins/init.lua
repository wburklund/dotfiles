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
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {
        enable_builtin = true,
        default_to_projects_v2 = true,

        mappings = {
          issue = {
            reload = { lhs = '<C-r>', desc = '[R]eload issue' },
            open_in_browser = { lhs = '<C-b>', desc = 'Open in [b]rowser' },
            copy_url = { lhs = '<C-y>', desc = 'Copy URL' },
            next_comment = { lhs = ']c', desc = 'Next comment' },
            prev_comment = { lhs = '[c', desc = 'Previous comment' },
            close_issue = { lhs = '<localleader>ic', desc = '[I]ssue [c]lose' },
            reopen_issue = { lhs = '<localleader>io', desc = '[I]ssue re[o]pen' },
            list_issues = { lhs = '<localleader>il', desc = '[I]ssues [l]ist (open, same repo)' },
            add_assignee = { lhs = '<localleader>aa', desc = '[A]ssignee [a]dd' },
            remove_assignee = { lhs = '<localleader>ad', desc = '[A]ssignee [d]elete' },
            create_label = { lhs = '<localleader>lc', desc = '[L]abel [c]reate' },
            add_label = { lhs = '<localleader>la', desc = '[L]abel [a]dd' },
            remove_label = { lhs = '<localleader>ld', desc = '[L]abel [d]elete' },
            goto_issue = { lhs = '<localleader>gi', desc = '[G]oto [i]ssue (local repo)' },
            add_comment = { lhs = '<localleader>ca', desc = '[C]omment [a]dd' },
            delete_comment = { lhs = '<localleader>cd', desc = '[C]omment [d]elete' },
            react_hooray = { lhs = '<localleader>rp', desc = '[R]eact 🎉' },
            react_heart = { lhs = '<localleader>rh', desc = '[R]eact ❤️' },
            react_eyes = { lhs = '<localleader>re', desc = '[R]eact 👀' },
            react_thumbs_up = { lhs = '<localleader>r+', desc = '[R]eact 👍' },
            react_thumbs_down = { lhs = '<localleader>r-', desc = '[R]eact 👎' },
            react_rocket = { lhs = '<localleader>rr', desc = '[R]eact 🚀' },
            react_laugh = { lhs = '<localleader>rl', desc = '[R]eact 😄' },
            react_confused = { lhs = '<localleader>rc', desc = '[R]eact 😕' },
          },
          pull_request = {
            goto_file = { lhs = 'gf', desc = '[G]oto [f]ile' },
            reload = { lhs = '<C-r>', desc = '[R]eload' },
            open_in_browser = { lhs = '<C-b>', desc = 'Open in [b]rowser' },
            copy_url = { lhs = '<C-y>', desc = 'Copy URL' },
            next_comment = { lhs = ']c', desc = 'Next [c]omment' },
            prev_comment = { lhs = '[c', desc = 'Previous [c]omment' },
            checkout_pr = { lhs = '<localleader>po', desc = '[P]R check[o]ut' },
            merge_pr = { lhs = '<localleader>pm', desc = '[P]R [m]erge' },
            squash_and_merge_pr = { lhs = '<localleader>psm', desc = '[P]R [s]quash and [m]erge' },
            rebase_and_merge_pr = { lhs = '<localleader>prm', desc = '[P]R [r]ebase and [m]erge' },
            list_commits = { lhs = '<localleader>pc', desc = '[P]R list [c]ommits' },
            list_changed_files = { lhs = '<localleader>pf', desc = '[P]R list changed [f]iles' },
            show_pr_diff = { lhs = '<localleader>pd', desc = '[P]R show [d]iff' },
            add_reviewer = { lhs = '<localleader>va', desc = 'Re[v]iewer [a]dd' },
            remove_reviewer = { lhs = '<localleader>vd', desc = 'Re[v]iewer [d]elete' },
            review_start = { lhs = '<localleader>vs', desc = 'Re[v]iew [s]tart' },
            review_resume = { lhs = '<localleader>vr', desc = 'Re[v]iew [r]esume' },
            close_issue = { lhs = '<localleader>ic', desc = '[I]ssue [c]lose' },
            reopen_issue = { lhs = '<localleader>io', desc = '[I]ssue re[o]pen' },
            list_issues = { lhs = '<localleader>il', desc = '[I]ssues [l]ist (open, same repo)' },
            add_assignee = { lhs = '<localleader>aa', desc = '[A]ssignee [a]dd' },
            remove_assignee = { lhs = '<localleader>ad', desc = '[A]ssignee [d]elete' },
            create_label = { lhs = '<localleader>lc', desc = '[L]abel [c]reate' },
            add_label = { lhs = '<localleader>la', desc = '[L]abel [a]dd' },
            remove_label = { lhs = '<localleader>ld', desc = '[L]abel [d]elete' },
            goto_issue = { lhs = '<localleader>gi', desc = '[G]oto [i]ssue (local repo)' },
            add_comment = { lhs = '<localleader>ca', desc = '[C]omment [a]dd' },
            delete_comment = { lhs = '<localleader>cd', desc = '[C]omment [d]elete' },
            react_hooray = { lhs = '<localleader>rp', desc = '[R]eact 🎉' },
            react_heart = { lhs = '<localleader>rh', desc = '[R]eact ❤️' },
            react_eyes = { lhs = '<localleader>re', desc = '[R]eact 👀' },
            react_thumbs_up = { lhs = '<localleader>r+', desc = '[R]eact 👍' },
            react_thumbs_down = { lhs = '<localleader>r-', desc = '[R]eact 👎' },
            react_rocket = { lhs = '<localleader>rr', desc = '[R]eact 🚀' },
            react_laugh = { lhs = '<localleader>rl', desc = '[R]eact 😄' },
            react_confused = { lhs = '<localleader>rc', desc = '[R]eact 😕' },
          },
          review_thread = {
            next_comment = { lhs = ']c', desc = 'Next [c]omment' },
            prev_comment = { lhs = '[c', desc = 'Previous [c]omment' },
            select_next_entry = { lhs = ']q', desc = 'Next changed file' },
            select_prev_entry = { lhs = '[q', desc = 'Previous changed file' },
            select_first_entry = { lhs = '[Q', desc = 'First changed file' },
            select_last_entry = { lhs = ']Q', desc = 'Last changed file' },
            close_review_tab = { lhs = '<C-c>', desc = '[C]lose review tab' },
            goto_issue = { lhs = '<localleader>gi', desc = '[G]oto [i]ssue (local repo)' },
            add_comment = { lhs = '<localleader>ca', desc = '[C]omment [a]dd' },
            delete_comment = { lhs = '<localleader>cd', desc = '[C]omment [d]elete' },
            add_suggestion = { lhs = '<localleader>sa', desc = '[S]uggestion [a]dd' },
            react_hooray = { lhs = '<localleader>rp', desc = '[R]eact 🎉' },
            react_heart = { lhs = '<localleader>rh', desc = '[R]eact ❤️' },
            react_eyes = { lhs = '<localleader>re', desc = '[R]eact 👀' },
            react_thumbs_up = { lhs = '<localleader>r+', desc = '[R]eact 👍' },
            react_thumbs_down = { lhs = '<localleader>r-', desc = '[R]eact 👎' },
            react_rocket = { lhs = '<localleader>rr', desc = '[R]eact 🚀' },
            react_laugh = { lhs = '<localleader>rl', desc = '[R]eact 😄' },
            react_confused = { lhs = '<localleader>rc', desc = '[R]eact 😕' },
          },
          submit_win = {
            approve_review = { lhs = '<C-a>', desc = '[A]pprove review' },
            comment_review = { lhs = '<C-m>', desc = 'Co[m]ment review' },
            request_changes = { lhs = '<C-r>', desc = '[R]equest changes review' },
            close_review_tab = { lhs = '<C-c>', desc = '[C]lose review tab' },
          },
          review_diff = {
            goto_file = { lhs = 'gf', desc = '[G]oto [f]ile' },
            next_thread = { lhs = ']t', desc = 'Next [t]hread' },
            prev_thread = { lhs = '[t', desc = 'Previous [t]hread' },
            select_next_entry = { lhs = ']q', desc = 'Next changed file' },
            select_prev_entry = { lhs = '[q', desc = 'Previous changed file' },
            select_first_entry = { lhs = '[Q', desc = 'First changed file' },
            select_last_entry = { lhs = ']Q', desc = 'Last changed file' },
            close_review_tab = { lhs = '<C-c>', desc = '[C]lose review tab' },
            submit_review = { lhs = '<localleader>vs', desc = '[R]eview [s]ubmit' },
            discard_review = { lhs = '<localleader>vd', desc = '[R]eview [d]iscard' },
            add_review_comment = { lhs = '<localleader>ca', desc = 'Review [c]omment [a]dd' },
            add_review_suggestion = { lhs = '<localleader>sa', desc = 'Review [s]uggestion [a]dd' },
            focus_files = { lhs = '<localleader>e', desc = 'Focus changed file panel' },
            toggle_files = { lhs = '<localleader>b', desc = 'Toggle changed files panel' },
            toggle_viewed = { lhs = '<localleader><space>', desc = 'Toggle viewer viewed state' },
          },
          file_panel = {
            next_entry = { lhs = 'j', desc = 'Next changed file' },
            prev_entry = { lhs = 'k', desc = 'Previous changed file' },
            select_entry = { lhs = '<cr>', desc = 'Show file diffs' },
            refresh_files = { lhs = 'R', desc = '[R]efresh changed files panel' },
            select_next_entry = { lhs = ']q', desc = 'Next changed file' },
            select_prev_entry = { lhs = '[q', desc = 'Previous changed file' },
            select_first_entry = { lhs = '[Q', desc = 'First changed file' },
            select_last_entry = { lhs = ']Q', desc = 'Last changed file' },
            close_review_tab = { lhs = '<C-c>', desc = '[C]lose review tab' },
            submit_review = { lhs = '<localleader>vs', desc = 'Re[v]iew [s]ubmit' },
            discard_review = { lhs = '<localleader>vd', desc = 'Re[v]iew [d]iscard' },
            focus_files = { lhs = '<localleader>e', desc = 'Focus changed file panel' },
            toggle_files = { lhs = '<localleader>b', desc = 'Toggle changed files panel' },
            toggle_viewed = { lhs = '<localleader><space>', desc = 'Toggle viewer viewed state' },
          },
        },
      }

      -- Use treesitter markdown parser with octo buffers
      vim.treesitter.language.register('markdown', 'octo')
    end,
    -- TODO: More global keybinds for the use cases I encounter
    keys = {
      { '<leader>Hp', '<cmd>Octo pr list<cr>', desc = 'Git[H]ub list [P]Rs' },
      { '<leader>HP', '<cmd>Octo pr create<cr>', desc = 'Git[H]ub create [P]R' },
    },
  },
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
    end,
  },
}
