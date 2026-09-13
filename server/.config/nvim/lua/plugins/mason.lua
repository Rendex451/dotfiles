return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Серверы под твой стек: gopls (Go), clangd (C/C++), pylsp (Python).
      -- Дополни список, если понадобится ещё язык — например, "bashls".
      ensure_installed = { "gopls", "clangd", "pylsp" },
      automatic_installation = true,
    },
  },
}
