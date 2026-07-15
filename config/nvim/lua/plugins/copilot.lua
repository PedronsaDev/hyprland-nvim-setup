-- AI Assistant Integration (GitHub Copilot & CopilotChat)
-- Clean, fast, unobtrusive inline suggestions and side-by-side chat

return {
  -- Inline Copilot completion (Ghost text)
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false, -- Don't need the split panel, inline is much cleaner
        },
        suggestion = {
          enabled = true,  -- Copilot is the ONLY ghost text source
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<C-l>',  -- Accept full AI suggestion
            accept_word = '<M-w>',
            accept_line = '<M-j>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
      }
    end,
    keys = {
      {
        '<leader>ai',
        function()
          local suggestion = require('copilot.suggestion')
          if suggestion.is_visible() then
            suggestion.dismiss()
          end
          -- Track state ourselves since copilot internals are unreliable
          vim.g._copilot_manual_enabled = vim.g._copilot_manual_enabled ~= false
          if vim.g._copilot_manual_enabled then
            require('copilot.command').disable()
            vim.g._copilot_manual_enabled = false
            vim.notify('Copilot suggestions disabled', vim.log.levels.INFO, { title = 'Copilot' })
          else
            require('copilot.command').enable()
            vim.g._copilot_manual_enabled = true
            vim.notify('Copilot suggestions enabled', vim.log.levels.INFO, { title = 'Copilot' })
          end
        end,
        desc = 'AI: Toggle [I]nline Suggestions',
      },
    },
  },

  -- AI Assistant Sidebar & Actions (CopilotChat)
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatExplain',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatTests',
      'CopilotChatDocs',
    },
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {
      show_help = false, -- Clean up UI
      window = {
        layout = 'vertical', -- Vertical split on the right (sidebar) instead of blocking popup
        width = 0.35, -- 35% of screen width
        border = 'single', -- Match old-school sharp borders
      },
    },
    config = function(_, opts)
      require('CopilotChat').setup(opts)
    end,
    keys = {
      { '<leader>ac', '<cmd>CopilotChatToggle<CR>', desc = 'AI: Toggle [C]hat Sidebar', mode = { 'n', 'v' } },
      { '<leader>ae', '<cmd>CopilotChatExplain<CR>', desc = 'AI: [E]xplain Code', mode = { 'n', 'v' } },
      { '<leader>af', '<cmd>CopilotChatFix<CR>', desc = 'AI: [F]ix Bug/Diagnostic', mode = { 'n', 'v' } },
      { '<leader>ao', '<cmd>CopilotChatOptimize<CR>', desc = 'AI: [O]ptimize Code', mode = { 'n', 'v' } },
      { '<leader>at', '<cmd>CopilotChatTests<CR>', desc = 'AI: Generate [T]ests', mode = { 'n', 'v' } },
      { '<leader>ad', '<cmd>CopilotChatDocs<CR>', desc = 'AI: Generate [D]ocs/Comments', mode = { 'n', 'v' } },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Ask AI: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'AI: [Q]uick Question on Buffer',
        mode = { 'n', 'v' },
      },
      { '<leader>ar', '<cmd>CopilotChatReset<CR>', desc = 'AI: [R]eset Chat History', mode = { 'n' } },
    },
  },
}
