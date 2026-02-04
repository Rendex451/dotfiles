return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'gruvbox-material',
        -- Use separators for a cleaner look
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'neo-tree' } },
      },
      sections = {
        lualine_a = { { 'mode', right_padding = 2 } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } }, -- path = 1 shows relative path
        lualine_x = { 
          {
            'filetype',
            colored = true,   -- делать иконку цветной
            icon_only = false, -- показывать и иконку, и текст
            icon = { align = 'left' } -- иконка слева от текста
          }
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    })
  end,
}
