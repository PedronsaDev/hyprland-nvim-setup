-- Completion configuration
-- Uses blink.cmp for blazing fast code completions
-- Copilot is integrated as a blink source so LSP and AI share one unified dropdown

return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
      -- Snippet engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      -- Copilot as a blink source (unified dropdown, no ghost text conflicts)
      { 'giuxtaposition/blink-cmp-copilot' },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        -- Show documentation panel automatically on selection
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
        },
        -- Disable blink ghost text — Copilot handles AI suggestions in dropdown
        ghost_text = {
          enabled = false,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100, -- Copilot suggestions float to the top
            async = true,
          },
        },
      },

      snippets = {
        preset = 'luasnip',
      },

      fuzzy = {
        implementation = 'lua',
      },

      signature = {
        enabled = true,
      },
    },
  },
}
