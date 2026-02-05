return {
  'ryanoasis/vim-devicons',
  
  -- Цветовая схема
  { 
    "ellisonleao/gruvbox.nvim", 
    priority = 1000,
    config = function()
    require("gruvbox").setup({
      transparent_mode = true, -- ВКЛЮЧАЕТ ПРОЗРАЧНОСТЬ
    })
    vim.cmd([[colorscheme gruvbox]])
    end
  },

  -- LSP и автодополнение
  { 'neoclide/coc.nvim', branch = 'master', build = 'npm ci' },
}
