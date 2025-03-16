local add, later = MiniDeps.add, MiniDeps.later
add({ source = "mfussenegger/nvim-lint" })
add({
  source = "neovim/nvim-lspconfig",
  depends = {
    "hrsh7th/cmp-nvim-lsp",
  },
})
add({ source = "stevearc/conform.nvim" })
add({ source = "rafamadriz/friendly-snippets" })
add({
  source = "hrsh7th/nvim-cmp",
  depends = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "abeldekat/cmp-mini-snippets",
    "nvim-lua/plenary.nvim",
    "hrsh7th/cmp-nvim-lua",
    "petertriho/cmp-git",
    "kdheepak/cmp-latex-symbols",
    "folke/lazydev.nvim",
  },
})
add({ source = "hedyhli/outline.nvim" })
later(function()
  vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
  require("outline").setup()
  require("plugins.lsp.cmp")
  require("plugins.lsp.lsp")
  require("plugins.lsp.lspconfig")
  require("plugins.lsp.conform")
  require("plugins.lsp.snippets")
end)

-- mason {{{
later(function()
  add({
    source = "williamboman/mason.nvim",
    depends = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
  })
  require("mason").setup()
end)
-- }}}
