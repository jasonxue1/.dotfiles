local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- mini.tabline {{{
now(function()
  require("mini.tabline").setup()
end)
-- }}}
-- mini.statusline {{{
now(function()
  require("mini.statusline").setup()
end)
-- }}}
-- mini.highlights {{{
later(function()
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE', 'DONE'
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      done = { pattern = "%f[%w]()DONE()%f[%W]", group = "MiniHipatternsNote" },
      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)
-- }}}
-- mini.starter {{{
now(function()
  require("mini.starter").setup()
end)
-- }}}
-- mini.notify {{{
later(function()
  require("mini.notify").setup()
  vim.keymap.set("n", "<leader>N", MiniNotify.clear, { desc = "Notify clear" })
end)
-- }}}
-- mini.cursorword{{{
later(function()
  require("mini.cursorword").setup()
end)
-- }}}
-- mini.trailspace{{{
later(function()
  require("mini.trailspace").setup()
end)
-- }}}
-- mini.map {{{
later(function()
  require("mini.map").setup()
  vim.keymap.set("n", "<leader>p", MiniMap.toggle, { desc = "MiniMap" })
end)
-- }}}
-- smartcolumn {{{
later(function()
  add({
    source = "m4xshen/smartcolumn.nvim",
  })
  require("smartcolumn").setup()
end)
-- }}}
