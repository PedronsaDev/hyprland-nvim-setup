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
      local module_name = nvim_plugin:match("/([^%.]+)") or nvim_plugin
      pcall(function()
        require(module_name).setup {
          theme = nvim_theme:match('%-(.*)') or 'wave', -- e.g. kanagawa-dragon -> dragon
          background = 'hard',
          italics = false,
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
      -- Read theme.json for exact hex colors
      local theme_json_path = vim.fn.expand("~/.config/theme.json")
      local json_ok, theme_data = pcall(function()
        local content = table.concat(vim.fn.readfile(theme_json_path), "\n")
        return vim.fn.json_decode(content)
      end)

      local lualine_theme = 'auto'
      if json_ok and theme_data then
        local bg = '#' .. theme_data.background
        local fg = '#' .. theme_data.foreground
        local accent = '#' .. theme_data.accent
        local muted = '#' .. theme_data.muted
        local red = '#' .. (theme_data.red or 'c4746e')
        local blue = '#' .. (theme_data.blue or '8ba4b0')
        local yellow = '#' .. (theme_data.yellow or 'c4b28a')
        local magenta = '#' .. (theme_data.magenta or 'a292a3')

        lualine_theme = {
          normal = {
            a = { bg = accent, fg = bg, bold = true },
            b = { bg = muted, fg = fg },
            c = { bg = bg, fg = fg },
          },
          insert = {
            a = { bg = blue, fg = bg, bold = true },
            b = { bg = muted, fg = fg },
            c = { bg = bg, fg = fg },
          },
          visual = {
            a = { bg = magenta, fg = bg, bold = true },
            b = { bg = muted, fg = fg },
            c = { bg = bg, fg = fg },
          },
          replace = {
            a = { bg = red, fg = bg, bold = true },
            b = { bg = muted, fg = fg },
            c = { bg = bg, fg = fg },
          },
          command = {
            a = { bg = yellow, fg = bg, bold = true },
            b = { bg = muted, fg = fg },
            c = { bg = bg, fg = fg },
          },
          inactive = {
            a = { bg = bg, fg = muted, bold = true },
            b = { bg = bg, fg = muted },
            c = { bg = bg, fg = muted },
          },
        }
      end

      require('lualine').setup {
        options = {
          theme = lualine_theme,
          component_separators = { left = '│', right = '│' },
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
