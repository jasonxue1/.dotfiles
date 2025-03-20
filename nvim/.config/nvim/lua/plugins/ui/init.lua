local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
add({ source = "m4xshen/smartcolumn.nvim" })
add({ source = "Bekaboo/dropbar.nvim" })
add({ source = "akinsho/toggleterm.nvim" })
now(function()
  require("mini.tabline").setup()
  require("mini.statusline").setup()
  require("mini.starter").setup()
end)
later(function()
  require("mini.notify").setup()
  vim.keymap.set("n", "<leader>N", MiniNotify.clear, { desc = "Notify clear" })
  require("mini.cursorword").setup()
  require("mini.trailspace").setup()
  require("mini.map").setup()
  require("smartcolumn").setup()
  require("plugins.ui.highlights")
  require("plugins.ui.dropbar")
  require("plugins.ui.toggleterm")
  require("plugins.ui.keymaps")
end)
