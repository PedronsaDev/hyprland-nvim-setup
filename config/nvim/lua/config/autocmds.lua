-- Autocommands configuration for Neovim

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Open Neo-tree and Alpha dashboard together when starting with a directory argument (e.g. nvim .)
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('custom-dir-dashboard', { clear = true }),
  callback = function()
    local argv = vim.fn.argv()
    if #argv == 1 then
      local path = vim.fn.fnamemodify(argv[1], ':p')
      if vim.fn.isdirectory(path) == 1 then
        -- 1. Change the global working directory to the specified path
        vim.api.nvim_set_current_dir(path)
        -- 2. Create a new empty scratch buffer for the main window
        vim.cmd('enew')
        -- 3. Render the Alpha dashboard in the main window
        local has_alpha, alpha = pcall(require, 'alpha')
        if has_alpha then
          alpha.start(false)
        end
        -- 4. Open and focus Neo-tree sidebar in the target directory
        local has_neotree, neotree_cmd = pcall(require, 'neo-tree.command')
        if has_neotree then
          neotree_cmd.execute({ action = 'focus', dir = path })
        end
        -- 5. Delete the original directory buffer to keep the buffer list clean
        vim.schedule(function()
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.api.nvim_buf_get_name(bufnr)
            if vim.fn.isdirectory(name) == 1 then
              pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
            end
          end
        end)
      end
    end
  end,
})
