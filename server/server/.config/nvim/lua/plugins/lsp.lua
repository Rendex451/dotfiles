return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Общие маппинги, вешаются на буфер при подключении LSP-сервера.
    -- (Аналог того, что раньше в IDE-стиле давал coc.nvim "из коробки".)
    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr, silent = true }
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
    end

    -- Go
    lspconfig.gopls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          usePlaceholders = true,
          semanticTokens = true,
        },
      },
    })

    -- C/C++ (флаги перенесены из старого coc-settings.json)
    lspconfig.clangd.setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
    lspconfig.pylsp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
  end,
}
