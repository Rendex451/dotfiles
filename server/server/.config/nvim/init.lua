-- ========================================================================== --
-- { ОСНОВНЫЕ НАСТРОЙКИ }
-- ========================================================================== --

-- Leader-клавиша — используется в маппингах telescope/dap/lsp ниже.
-- Ставим до require("lazy"), чтобы плагины подхватили её при настройке.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Кодировка и совместимость (в Neovim nocompatible и utf8 стоят по умолчанию)
opt.encoding = "utf-8"

-- Поиск
opt.ignorecase = true      -- Игнорировать регистр
opt.smartcase = true       -- Не игнорировать, если есть заглавные
opt.hlsearch = true        -- Подсветка поиска
opt.incsearch = true       -- Интерактивный поиск

-- Табуляция и отступы
opt.tabstop = 4            -- Размер таба
opt.softtabstop = 4
opt.shiftwidth = 4         -- Ширина отступа
opt.expandtab = true       -- Табы в пробелы
opt.smarttab = true
opt.autoindent = true      -- Автоматические отступы
opt.smartindent = true
opt.clipboard = "unnamedplus" -- Системный буфер обмена

-- Интерфейс
opt.number = true          -- Номера строк
opt.relativenumber = true  -- Относительные номера
opt.wildmode = { "longest", "list" } -- Автодополнение в командной строке
opt.mouse = "a"            -- Поддержка мыши
opt.scrolloff = 30         -- Курсор в центре при скролле (в vim это 'so')
opt.termguicolors = true   -- Включить поддержку 24-битного цвета
opt.signcolumn = "yes"     -- Место под значки диагностики LSP всегда зарезервировано,
                           -- чтобы текст не "прыгал" при появлении ошибок

-- Синтаксис и плагины
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Диагностика LSP: показывать текст ошибки прямо в строке
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- ========================================================================== --
-- { ПЛАГИНЫ }
-- ========================================================================== --
-- Используем lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- ========================================================================== --
-- { НАСТРОЙКИ ЦВЕТОВ }
-- ========================================================================== --

opt.background = "dark"
