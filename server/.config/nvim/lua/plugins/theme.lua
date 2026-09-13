return {
  "ellisonleao/gruvbox.nvim", -- активно поддерживаемый lua-нативный форк (не устаревший morhetz/gruvbox)
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- "hard" | "" | "soft"
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end,
}
