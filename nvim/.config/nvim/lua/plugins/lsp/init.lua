local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
add({ source = "mfussenegger/nvim-lint" })
add({
  source = "neovim/nvim-lspconfig",
  depends = {
    "hrsh7th/cmp-nvim-lsp",
  },
})
add({ source = "stevearc/conform.nvim" })
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
    "rafamadriz/friendly-snippets",
  },
})
add({ source = "hedyhli/outline.nvim" })
now(function()
  vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
  require("outline").setup()
  require("plugins.lsp.cmp")
  require("plugins.lsp.lsp")
  require("plugins.lsp.lspconfig")
  require("plugins.lsp.conform")
  require("plugins.lsp.snippets")
end)
