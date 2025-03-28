local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    done = { pattern = "%f[%w]()DONE()%f[%W]", group = "MiniHipatternsNote" },
    ok = { pattern = "%f[%w]()OK()%f[%W]", group = "MiniHipatternsNote" },
    warning = { pattern = "%f[%w]()WARNING()%f[%W]", group = "MiniHipatternsHack" },
    error = { pattern = "%f[%w]()ERROR()%f[%W]", group = "MiniHipatternsFixme" },
    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
