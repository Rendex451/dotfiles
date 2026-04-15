return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",            -- Интерфейс
    "leoluz/nvim-dap-go",             -- Настройки для Go
    "nvim-neotest/nvim-nio",          -- Зависимость для UI
    "theHamsta/nvim-dap-virtual-text", -- Показывает значения переменных прямо в коде
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Инициализация плагинов
    require("dap-go").setup()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup()

    -- Автоматическое открытие и закрытие окон отладчика
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- ГОРЯЧИЕ КЛАВИШИ (Настроены как в популярных IDE)
    
    -- F5: Запуск или продолжение отладки
    vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Debug: Start/Continue" })
    
    -- F10: Шаг через (Step Over)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "Debug: Step Over" })
    
    -- F11: Шаг внутрь (Step Into)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "Debug: Step Into" })
    
    -- F12: Шаг наружу (Step Out)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "Debug: Step Out" })

    -- <leader>b: Поставить/снять точку остановки (Breakpoint)
    vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
    
    -- <leader>B: Точка остановки с условием (Conditional Breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = "Debug: Set Breakpoint with Condition" })

    -- Настройка иконок для точек остановки
    vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})
  end,
}
