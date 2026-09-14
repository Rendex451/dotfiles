-- ~/.config/nvim/lua/plugins/coc.lua
return {
  'neoclide/coc.nvim',
  branch = 'master',
  build = 'npm ci',
  config = function()
    -- Вспомогательная функция (если она вам понадобится для расширенной логики)
    local function check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- Настройка клавиши Tab для подтверждения выбора
    vim.keymap.set("i", "<Tab>", function()
      if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#confirm"]()
      end
      return "<Tab>"
    end, { silent = true, expr = true, replace_keycodes = true })

    -- Esc закрывает меню CoC
    vim.keymap.set("i", "<Esc>", function()
      if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#cancel"]()
      end
      return "<Esc>"
    end, { silent = true, expr = true, replace_keycodes = true })
  end
}
