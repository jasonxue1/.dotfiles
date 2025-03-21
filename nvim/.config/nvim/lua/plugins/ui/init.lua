local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
add({ source = "m4xshen/smartcolumn.nvim" })
add({ source = "Bekaboo/dropbar.nvim" })
add({ source = "akinsho/toggleterm.nvim" })
add({ source = "folke/tokyonight.nvim" })
add({ source = "projekt0n/github-nvim-theme" })
add({
  source = "nvim-treesitter/nvim-treesitter",
  -- run after
  hooks = {
    post_checkout = function()
      vim.cmd("TSUpdate")
    end,
  },
})
add({ source = "HiPhish/rainbow-delimiters.nvim" })
add({ source = "szw/vim-maximizer" })
now(function()
  vim.o.termguicolors = true
  vim.cmd("colorscheme tokyonight-moon")
  require("mini.tabline").setup()
  require("mini.statusline").setup()
  require("mini.starter").setup()
  require("mini.icons").setup()
end)
later(function()
  require("mini.notify").setup()
  vim.keymap.set("n", "<leader>N", MiniNotify.clear, { desc = "Notify clear" })
  require("mini.cursorword").setup()
  require("mini.trailspace").setup()
  require("smartcolumn").setup()
  require("plugins.ui.highlights")
  require("plugins.ui.map")
  require("plugins.ui.dropbar")
  require("plugins.ui.toggleterm")
  require("plugins.ui.clue")
  require("plugins.ui.treesitter")
  require("plugins.ui.indentscope")
  require("plugins.ui.git")
  require("plugins.ui.rainbow")
  require("nvim-lastplace").setup({})
  vim.keymap.set("n", "<leader>m", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })
end)
