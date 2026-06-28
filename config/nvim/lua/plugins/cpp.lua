-- C++ and CMake Specific Configurations
-- Sets up CMake integration, debugging via codelldb, and debug UI extensions

return {
  -- CMake Integration (cmake-tools)
  {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      cmake_regenerate_on_save = true,
      cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' },
      cmake_build_directory = 'build/${variant:buildType}',
      cmake_compile_commands_options = {
        action = 'soft_link', -- Link compile_commands.json to workspace root so clangd finds it
      },
    },
    keys = {
      { '<leader>cg', '<cmd>CMakeGenerate<CR>', desc = 'CMake: Generate' },
      { '<leader>cb', '<cmd>CMakeBuild<CR>', desc = 'CMake: Build' },
      { '<leader>cB', '<cmd>CMakeSelectBuildType<CR>', desc = 'CMake: Select Build Type' },
      { '<leader>cT', '<cmd>CMakeSelectBuildTarget<CR>', desc = 'CMake: Select Build Target' },
      { '<leader>cL', '<cmd>CMakeLaunchArgs<CR>', desc = 'CMake: Set Run Args' },
      { '<leader>cr', '<cmd>CMakeRun<CR>', desc = 'CMake: Run' },
      { '<leader>cR', '<cmd>CMakeRunTest<CR>', desc = 'CMake: Test (ctest)' },
      { '<leader>cC', '<cmd>CMakeClean<CR>', desc = 'CMake: Clean' },
      { '<leader>cS', '<cmd>CMakeQuickStart<CR>', desc = 'CMake: Quick Start' },
    },
  },

  -- Debugger Support (nvim-dap)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- DAP UI for visual debugging panel
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      -- Install debuggers via Mason automatically
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>B',
        function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
        desc = 'Debug: Set Breakpoint with Condition',
      },
      { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle Debug UI' },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = { 'codelldb' },
        handlers = {
          function(config) require('mason-nvim-dap').default_setup(config) end,
        },
      }

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Auto-open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Dynamic Executable Picker
      local function get_executable() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end

      local function get_args()
        local input = vim.fn.input 'Arguments: '
        return input == '' and {} or vim.split(input, ' +')
      end

      -- C/C++ Config
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = get_executable,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = get_args,
          runInTerminal = false,
        },
        {
          name = 'Attach',
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },

  -- Inline virtual text for debugged variables
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
    opts = {
      commented = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
    },
  },
}
