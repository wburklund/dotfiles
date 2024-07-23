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
  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require('dbee').install()
    end,
    config = function() -- Override table helpers since the inconsistent capitalization bugs me
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

      local postgres_pk_query = [[SELECT tc.constraint_name, tc.table_name, kcu.column_name, kcu.ordinal_position
FROM
information_schema.table_constraints AS tc
  JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
  WHERE tc."table_schema" = '{{ .Schema }}' AND tc."table_name" = '{{ .Table }}'
    AND tc.constraint_type = 'PRIMARY KEY'
]]

      local map_opts = function(opts)
        opts.noremap = true
        opts.nowait = true
        return opts
      end

      require('dbee').setup {
        extra_helpers = {
          postgres = {
            List = 'SELECT * FROM {{ .Schema }}.{{ .Table }} LIMIT 500',
            Columns = "SELECT * FROM information_schema.Columns WHERE table_schema = '{{ .Schema }}' AND table_name = '{{ .Table }}'",
            Indexes = "SELECT * FROM pg_indexes WHERE schemaname = '{{ .Schema }}' AND tablename = {{ .Table }}",
            ['Primary Keys'] = postgres_pk_query,
            ['Foreign Keys'] = basic_constraint_query
              .. "WHERE constraint_type = 'FOREIGN KEY' AND tc.table_schema = '{{ .Schema }}' AND tc.table_name = '{{ .Table }}'",
            References = basic_constraint_query
              .. "WHERE constraint_type = 'FOREIGN KEY' AND ccu.table_schema = '{{ .Schema }}' AND ccu.table_name = '{{ .Table }}'",
          },
        },
        drawer = {
          mappings = {
            { key = 'r', mode = 'n', action = 'refresh', opts = map_opts { desc = '[R]efresh' } },
            { key = '<cr>', mode = 'n', action = 'action_1', opts = map_opts { desc = 'Open/execute' } },
            { key = 'e', mode = 'n', action = 'action_2', opts = map_opts { desc = 'R[e]name/s[e]t connection as active' } },
            { key = 'd', mode = 'n', action = 'action_3', opts = map_opts { desc = '[D]elete' } },
            { key = 't', mode = 'n', action = 'toggle', opts = map_opts { desc = '[T]oggle' } },
            { key = '<cr>', mode = 'n', action = 'menu_confirm', opts = map_opts { desc = 'Menu confirm' } },
            { key = 'y', mode = 'n', action = 'menu_yank', opts = map_opts { desc = 'Menu yank' } },
            { key = '<esc>', mode = 'n', action = 'menu_close', opts = map_opts { desc = 'Menu close' } },
          },
        },
        editor = {
          mappings = {
            { key = '<C-r>', mode = 'x', action = 'run_selection', opts = map_opts { desc = '[R]un selection' } },
            { key = '<C-r>', mode = 'n', action = 'run_file', opts = map_opts { desc = '[R]un all' } },
          },
        },
        result = {
          mappings = {
            -- next/previous page
            { key = '[p', mode = '', action = 'page_prev', opts = map_opts { desc = 'Previous [p]age' } },
            { key = ']p', mode = '', action = 'page_next', opts = map_opts { desc = 'Next [p]age' } },
            { key = '[P', mode = '', action = 'page_first', opts = map_opts { desc = 'First [p]age' } },
            { key = ']P', mode = '', action = 'page_last', opts = map_opts { desc = 'Last [p]age' } },
            -- yank rows as csv/json
            { key = '<C-y>j', mode = 'n', action = 'yank_current_json', opts = map_opts { desc = '[Y]ank row [J]SON' } },
            { key = '<C-y>j', mode = 'x', action = 'yank_selection_json', opts = map_opts { desc = '[Y]ank selection [J]SON' } },
            { key = '<C-y>J', mode = 'n', action = 'yank_all_json', opts = map_opts { desc = '[Y]ank all [J]SON' } },
            { key = '<C-y>c', mode = 'n', action = 'yank_current_csv', opts = map_opts { desc = '[Y]ank row [C]SV' } },
            { key = '<C-y>c', mode = 'x', action = 'yank_selection_csv', opts = map_opts { desc = '[Y]ank selection [C]SV' } },
            { key = '<C-y>C', mode = 'n', action = 'yank_all_csv', opts = map_opts { desc = '[Y]ank all [C]SV' } },
            -- cancel current call execution
            { key = '<C-c>', mode = '', action = 'cancel_call', opts = map_opts { desc = '[C]ancel current execution' } },
          },
        },
      }
    end,
    keys = {
      { '<leader>S', '<cmd>Dbee<cr>', desc = 'DBee [S]QL client' },
    },
  },
  {
    'MattiasMTS/cmp-dbee',
    dependencies = {
      { 'kndndrj/nvim-dbee' },
    },
    ft = 'sql',
    config = function()
      require('cmp-dbee').setup()
      -- I like capitalized SQL keywords
      local sql_keywords = require('cmp-dbee.constants').reserved_sql_keywords
      for _, item in pairs(sql_keywords) do
        item.name = string.upper(item.name)
      end
    end,
  },
}
