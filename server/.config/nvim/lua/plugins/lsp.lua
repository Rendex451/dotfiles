return {
  "neovim/nvim-lspconfig",
  -- nvim-lspconfig теперь используется не как обёртка с .setup() (это API
  -- задеприкейчено и будет выпилено в v3.0.0), а просто как поставщик
  -- дефолтных конфигов под конкретные LSP-серверы (lsp/*.lua внутри плагина),
  -- которые подхватывает нативный vim.lsp.config. См. :help lspconfig-nvim-0.11
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Общие маппинги вешаем через LspAttach — срабатывает для любого
    -- подключившегося сервера, без дублирования одного и того же
    -- on_attach в конфиге каждого сервера отдельно.
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })

    -- "*" — общие для всех серверов настройки (тут — capabilities под nvim-cmp)
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- Go
    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          usePlaceholders = true,
          semanticTokens = true,
        },
      },
    })

    -- C/C++ (флаги перенесены из старого coc-settings.json)
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
        "--all-scopes-completion",
        "--cross-file-rename",
        "--fallback-style=llvm",
      },
    })

    -- Python (тот же набор включённых/выключенных плагинов pylsp, что был раньше)
    vim.lsp.config("pylsp", {
      settings = {
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
    })

    -- Включаем сами серверы. mason-lspconfig (см. mason.lua) следит за тем,
    -- чтобы бинарники gopls/clangd/pylsp были поставлены через Mason.
    vim.lsp.enable({ "gopls", "clangd", "pylsp" })
  end,
}
