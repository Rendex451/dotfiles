return {
  -- asyncomplete — штатная пара к vim-lsp (nvim-cmp завязан на встроенный LSP)
  "prabirshrestha/asyncomplete.vim",
  lazy = false,
  dependencies = {
    "prabirshrestha/asyncomplete-lsp.vim",       -- источник из vim-lsp
    "prabirshrestha/asyncomplete-buffer.vim",    -- слова из открытых буферов
    "prabirshrestha/asyncomplete-file.vim",      -- пути к файлам
  },
  init = function()
    vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
  end,
  config = function()
    vim.cmd([[
      augroup asyncomplete_sources
        autocmd!
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
              \ 'name': 'buffer',
              \ 'allowlist': ['*'],
              \ 'priority': -1,
              \ 'completor': function('asyncomplete#sources#buffer#completor'),
              \ }))
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
              \ 'name': 'file',
              \ 'allowlist': ['*'],
              \ 'priority': 10,
              \ 'completor': function('asyncomplete#sources#file#completor'),
              \ }))
      augroup END
    ]])

    local opts = { expr = true, silent = true, replace_keycodes = false }
    vim.keymap.set("i", "<C-Space>", "asyncomplete#force_refresh()", opts)
    vim.keymap.set("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', opts)
    vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', opts)
    vim.keymap.set("i", "<CR>", 'pumvisible() ? asyncomplete#close_popup() : "\\<CR>"', opts)
  end,
}
