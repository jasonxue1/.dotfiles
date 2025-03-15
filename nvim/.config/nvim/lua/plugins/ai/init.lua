local later, add = MiniDeps.later, MiniDeps.add

add({
  source = "olimorris/codecompanion.nvim",
  depends = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
})

later(function()
  require("plugins.ai.codecompanion")
end)
