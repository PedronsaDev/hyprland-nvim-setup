-- Quality of Life Plugins
-- Snippets, auto-indent detection, symbols tree, session recovery, search/replace, and Git blame

return {
  -- Guess indentation settings automatically (Guess-indent)
  {
    'NMAC427/guess-indent.nvim',
    opts = {},
  },

  -- Commenting helper (Comment.nvim)
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  -- Diagnostics Panel (Trouble)
  {
    'folke/trouble.nvim',
    version = 'v2.*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<CR>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document Diagnostics' },
      { '<leader>xl', '<cmd>TroubleToggle loclist<CR>', desc = 'Location List' },
      { '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', desc = 'Quickfix List' },
      { 'gR', '<cmd>TroubleToggle lsp_references<CR>', desc = 'LSP References (Trouble)' },
    },
  },

  -- Symbols Outline (Aerial)
  {
    'stevearc/aerial.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
      layout = { min_width = 30 },
      show_guides = true,
    },
    keys = {
      { '<leader>o', '<cmd>AerialToggle!<CR>', desc = 'Symbols Outline' },
    },
  },

  -- Match word highlights under cursor (Vim-illuminate)
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('illuminate').configure {
        delay = 200,
        large_file_cutoff = 2000,
        min_count_to_highlight = 2,
        filetypes_denylist = {
          'NvimTree',
          'neo-tree',
          'TelescopePrompt',
          'help',
          'lazy',
          'mason',
          'qf',
        },
      }

      vim.keymap.set('n', ']r', function() require('illuminate').goto_next_reference(false) end, { desc = 'Next reference' })
      vim.keymap.set('n', '[r', function() require('illuminate').goto_prev_reference(false) end, { desc = 'Prev reference' })
    end,
  },

  -- Git blame details inline (Git-blame)
  {
    'f-person/git-blame.nvim',
    cmd = { 'GitBlameToggle', 'GitBlameEnable', 'GitBlameDisable', 'GitBlameOpenCommitURL' },
    init = function() vim.g.gitblame_enabled = 0 end,
    keys = {
      { '<leader>gb', '<cmd>GitBlameToggle<CR>', desc = 'Git Blame (toggle)' },
    },
  },

  -- Session persistence (Persistence)
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
    },
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session' },
      { '<leader>ql', function() require('persistence').load { last = true } end, desc = 'Restore Last Session' },
      { '<leader>qd', function() require('persistence').stop() end, desc = 'Disable Session Saving' },
    },
  },

  -- Project manager with Telescope integration (Project.nvim)
  {
    'coffebar/project.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      detection_methods = { 'pattern' },
      patterns = { '.git', 'compile_commands.json', 'CMakeLists.txt', 'Makefile', 'meson.build' },
      silent_chdir = false,
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
      require('telescope').load_extension 'projects'
    end,
    keys = {
      { '<leader>sp', '<cmd>Telescope projects<CR>', desc = 'Search Projects' },
    },
  },

  -- Interactive find and replace (Spectre)
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>sR', function() require('spectre').open() end, desc = 'Search & Replace (Spectre)' },
    },
  },

  -- Mini utilities (mini.ai, mini.surround)
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },
}
