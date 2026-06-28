-- UI and Theme configurations
-- Retro colorscheme, statusline, start screen, and commandline aesthetics

local theme_path = vim.fn.expand("~/.config/theme.lua")
local ok, theme = pcall(dofile, theme_path)
local nvim_theme = (ok and theme and theme.nvim_theme) or 'everforest'
local nvim_plugin = (ok and theme and theme.nvim_plugin) or 'neanias/everforest-nvim'

return {
  -- Colorscheme
  {
    nvim_plugin,
    priority = 1000,
    config = function()
      -- If the plugin requires setup(), it will run with defaults or we skip it
      pcall(function()
        require(nvim_theme).setup {
          background = 'hard',
          italics = true,
        }
      end)
      vim.cmd.colorscheme(nvim_theme)

      -- Custom brace highlighting (clean underline instead of a thick block)
      vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'NONE', underline = true, bold = true, sp = '#A7C080' })
    end,
  },

  -- Statusline (Lualine)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
      }
    end,
  },

  -- Retro Dashboard (Alpha)
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local dashboard = require('alpha.themes.dashboard')

      dashboard.section.header.val = {
        [[                                  __]],
        [[     ___     ___    ___   __  __ /\_\    ___ ___]],
        [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
        [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        [[]],
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '⚙  Config', ':e $MYVIMRC <CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      dashboard.section.header.opts.hl = 'String'
      dashboard.section.buttons.opts.hl = 'Function'

      require('alpha').setup(dashboard.opts)
    end,
  },

  -- UI Notifications and Popups (Noice)
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = true, -- Classic bottom search
        command_palette = false, -- Classic bottom cmdline
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      cmdline = {
        view = "cmdline", -- Force classic view for cmdline
        format = {
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        },
      },
    },
  },

  -- Indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },

  -- Color preview for hex codes
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('colorizer').setup {
        filetypes = { '*' },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          AARRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = 'background',
          tailwind = false,
        },
      }
    end,
  },
}
