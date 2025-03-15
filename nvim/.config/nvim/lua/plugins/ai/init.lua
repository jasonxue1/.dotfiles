local add = MiniDeps.add

add({
  source = "olimorris/codecompanion.nvim",
  depends = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
})

require("plugins.ai.codecompanion")
