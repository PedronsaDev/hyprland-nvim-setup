-- LSP configurations
-- Manages Mason, LSPs, autoformatting, and C++ extensions

return {
  -- Main LSP Config
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason for downloading servers
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Nice status messages for LSP actions
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- Set up beautiful, clean diagnostics signs
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
          },
        },
      })
      -- Define sharp borders for LSP floating windows without using deprecated vim.lsp.with
      local orig_hover = vim.lsp.handlers['textDocument/hover']
      vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
        config = config or {}
        config.border = 'single'
        return orig_hover(err, result, ctx, config)
      end

      local orig_sig = vim.lsp.handlers['textDocument/signatureHelp']
      vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
        config = config or {}
        config.border = 'single'
        return orig_sig(err, result, ctx, config)
      end

      -- Autocmd on LspAttach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
          end

          -- Standard LSP mappings
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gK', vim.lsp.buf.signature_help, 'Signature Help')
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Telescope-based LSP mappings (if telescope is loaded)
          local has_telescope, builtin = pcall(require, 'telescope.builtin')
          if has_telescope then
            map('grd', builtin.lsp_definitions, '[G]oto [D]efinition')
            map('<F12>', builtin.lsp_definitions, '[G]oto [D]efinition (Rider)')
            map('grr', builtin.lsp_references, '[G]oto [R]eferences')
            map('gri', builtin.lsp_implementations, '[G]oto [I]mplementation')
            map('<C-F12>', builtin.lsp_implementations, '[G]oto [I]mplementation (Rider)')
            map('grt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')
            map('gO', builtin.lsp_document_symbols, 'Document Symbols')
            map('gW', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          else
            map('grd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            map('<F12>', vim.lsp.buf.definition, '[G]oto [D]efinition (Rider)')
            map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')
            map('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            map('<C-F12>', vim.lsp.buf.implementation, '[G]oto [I]mplementation (Rider)')
            map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
          end

          -- Highlight symbols under cursor
          if client and client:supports_method('textDocument/documentHighlight', buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('custom-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('custom-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'custom-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Inlay hints toggle
          if client and client:supports_method('textDocument/inlayHint', buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Supported servers configuration
      local servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
          },
          },
        cmake = {},
        lua_ls = {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                return
              end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
              },
              workspace = {
                checkThirdParty = false,
                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                  '${3rd}/luv/library',
                  '${3rd}/busted/library',
                }),
              },
            })
          end,
          settings = {
            Lua = {},
          },
        },
      }

      -- Set up Mason installer
      local ensure_installed = vim.tbl_keys(servers or {})
      local manual_servers = { cmake = true }
      ensure_installed = vim.tbl_filter(function(server) return not manual_servers[server] end, ensure_installed)
      vim.list_extend(ensure_installed, {
        'clang-format',
        'stylua',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Dynamic server setup using capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Merge capability overrides from blink if loaded
      local has_blink, blink = pcall(require, 'blink.cmp')
      if has_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      for name, server in pairs(servers) do
        if name ~= 'cmake' or vim.fn.executable 'cmake-language-server' == 1 then
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          vim.lsp.config(name, server)
          vim.lsp.enable(name)
        end
      end
    end,
  },

  -- Autoformatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
      },
      formatters = {
        ['clang-format'] = {
          prepend_args = { '-fallback-style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}' },
        },
      },
    },
  },

  -- Clangd Extensions for C++ Visuals/AST/Hierarchy
  {
    'p00f/clangd_extensions.nvim',
    ft = { 'c', 'cpp', 'objc', 'objcpp' },
    config = function()
      require('clangd_extensions').setup {}
      vim.keymap.set('n', '<leader>ch', '<cmd>ClangdSwitchSourceHeader<CR>', { desc = 'Clangd: Switch Source/Header' })
      vim.keymap.set('n', '<leader>cA', '<cmd>ClangdAST<CR>', { desc = 'Clangd: AST' })
      vim.keymap.set('n', '<leader>cH', '<cmd>ClangdTypeHierarchy<CR>', { desc = 'Clangd: Type Hierarchy' })
      vim.keymap.set('n', '<leader>cI', '<cmd>ClangdSymbolInfo<CR>', { desc = 'Clangd: Symbol Info' })
      vim.keymap.set('n', '<leader>cM', '<cmd>ClangdMemoryUsage<CR>', { desc = 'Clangd: Memory Usage' })
    end,
  },
}
