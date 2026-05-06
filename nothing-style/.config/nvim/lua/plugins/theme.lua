-- В файле плагинов (например, lua/plugins/theme.lua)
return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true, -- Прозрачность как в Nothing (OS)
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        },
        palettes = {
          carbonfox = {
            -- Делаем акцент красным (фирменный цвет Nothing)
            red = "#FF2D2D",
            bg1 = "#000000", -- Чистый черный
          }
        }
      })
      vim.cmd("colorscheme carbonfox")
    end
  }
}
