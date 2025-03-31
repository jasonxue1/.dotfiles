local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
add({ source = "OXY2DEV/markview.nvim" })
add({ source = "lervag/vimtex" })
add({ source = "ethanholz/nvim-lastplace" })
add({ source = "christoomey/vim-tmux-navigator" })
add({ source = "dstein64/vim-startuptime" })
add({ source = "LunarVim/bigfile.nvim" })
add({ source = "saecki/crates.nvim" })
add({ source = "AckslD/swenv.nvim" })
add({ source = "nvzone/typr", depends = { "nvzone/volt" } })
add({ source = "hat0uma/csvview.nvim" })
now(function()
  require("plugins.utils.files")
  require("plugins.utils.pairs")
  require("mini.sessions").setup({})
  require("nvim-lastplace").setup()
end)
later(function()
  require("plugins.utils.pick")
  require("plugins.utils.jump")
  require("plugins.utils.markview")
  require("plugins.utils.vimtex")
  require("mini.align").setup()
  require("mini.ai").setup()
  require("mini.surround").setup()
  vim.keymap.set({ "n", "x" }, "s", "<Nop>")
  require("mini.extra").setup()
  require("mini.move").setup({
    mappings = {
      left = "<M-H>",
      right = "<M-L>",
      down = "<M-J>",
      up = "<M-K>",

      line_left = "<M-H>",
      line_right = "<M-L>",
      line_down = "<M-J>",
      line_up = "<M-K>",
    },
  })
  require("plugins.utils.crates")
  require("plugins.utils.swenv")
  require("typr").setup({
    stats_filepath = vim.fn.expand("~/.config/nvim/typrstats"),
  })
  require("csvview").setup({
    view = {
      display_mode = "border",
      min_culumn_width = 3,
    },
  })
end)
