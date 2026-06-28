-- Treesitter configuration
-- Provides smart syntax highlighting and indentation for languages

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local parsers = {
        'bash',
        'c',
        'c_sharp',
        'cpp',
        'cmake',
        'diff',
        'html',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'ninja',
        'query',
        'vim',
        'vimdoc',
      }

      -- Install parsers programmatically
      require('nvim-treesitter').install(parsers)

      -- Load parser highlights and indentation based on file type
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf = args.buf
          local filetype = args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          -- Load the language parser if it exists
          if not vim.treesitter.language.add(language) then
            return
          end

          -- Start treesitter highlight engine on buffer
          vim.treesitter.start(buf, language)

          -- Enable treesitter based smart indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enable = true,
      max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      separator = nil,
      zindex = 20,
    },
  },
}
