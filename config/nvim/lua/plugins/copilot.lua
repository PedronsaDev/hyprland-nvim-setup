-- Copilot Integration
-- Sets up github copilot and the floating chat helper

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
    },
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {
      window = {
        layout = 'float',
        width = 0.8,
        height = 0.8,
      },
    },
    config = function(_, opts)
      require('copilot').setup {}
      require('CopilotChat').setup(opts)
    end,
    keys = {
      {
        '<leader>ccq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
    },
  },
}
