return {
  -- vim-lsp — лёгкий LSP-клиент на чистом vimscript.
  -- vim-lsp-settings — как в ~/.vimrc: сам определяет сервер по filetype,
  -- ставит его по :LspInstallServer (в ~/.local/share/vim-lsp-settings/servers)
  -- и регистрирует в vim-lsp. Если сервер уже есть в $PATH — берёт системный.
  "prabirshrestha/vim-lsp",
  lazy = false,
  dependencies = { "mattn/vim-lsp-settings" },
  init = function()
    -- Диагностика: текст ошибки прямо в строке + значки в signcolumn
    vim.g.lsp_diagnostics_enabled = 1
    vim.g.lsp_diagnostics_virtual_text_enabled = 1
    vim.g.lsp_diagnostics_signs_enabled = 1
    vim.g.lsp_diagnostics_echo_cursor = 1
    vim.g.lsp_document_highlight_enabled = 0

    -- Свои настройки поверх дефолтов vim-lsp-settings
    vim.g.lsp_settings = {
      gopls = {
        initialization_options = { semanticTokens = true },
      },
      -- C/C++ (флаги из старого coc-settings.json)
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--all-scopes-completion",
          "--cross-file-rename",
          "--query-driver=/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang,/usr/bin/clang++",
          "--fallback-style=llvm",
        },
      },
      -- Python (тот же набор включённых/выключенных плагинов pylsp)
      pylsp = {
        workspace_config = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = true },
              pycodestyle = { enabled = false },
              pylint = { enabled = true },
              flake8 = { enabled = false },
              mypy = { enabled = false },
            },
          },
        },
      },
    }
  end,
  config = function()
    -- Маппинги вешаются на буфер, когда к нему подключился любой сервер
    vim.api.nvim_create_autocmd("User", {
      pattern = "lsp_buffer_enabled",
      callback = function()
        vim.bo.omnifunc = "lsp#complete"
        local opts = { buffer = true, silent = true, remap = true }
        vim.keymap.set("n", "K", "<plug>(lsp-hover)", opts)
        vim.keymap.set("n", "gd", "<plug>(lsp-definition)", opts)
        vim.keymap.set("n", "gD", "<plug>(lsp-declaration)", opts)
        vim.keymap.set("n", "gi", "<plug>(lsp-implementation)", opts)
        vim.keymap.set("n", "gr", "<plug>(lsp-references)", opts)
        vim.keymap.set("n", "<leader>rn", "<plug>(lsp-rename)", opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<plug>(lsp-code-action)", opts)
        vim.keymap.set("n", "<leader>e", "<plug>(lsp-document-diagnostics)", opts)
        vim.keymap.set("n", "[d", "<plug>(lsp-previous-diagnostic)", opts)
        vim.keymap.set("n", "]d", "<plug>(lsp-next-diagnostic)", opts)
        vim.keymap.set("n", "<leader>f", "<plug>(lsp-document-format)", opts)
      end,
    })
  end,
}
