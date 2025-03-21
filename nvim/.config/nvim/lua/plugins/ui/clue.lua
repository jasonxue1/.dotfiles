local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- `g` key
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    { mode = "n", keys = "<leader>f", desc = "+ Find" },
    { mode = "n", keys = "<leader>g", desc = "+ Git" },
    { mode = "n", keys = "<leader>t", desc = "+ LaTeX" },
    { mode = "n", keys = "<leader>e", desc = "+ MiniFiles" },
    { mode = "g", keys = "gp", desc = "+ Preview" },
    { mode = "n", keys = "<leader>z", desc = "+ Ternimal" },
    { mode = "n", keys = "<leader>r", desc = "+ Rename/Restart" },
    { mode = "n", keys = "<leader>n", desc = "+ Window" },
    { mode = "n", keys = "<leader>c", desc = "+ ChatGPT" },
    { mode = "v", keys = "<leader>c", desc = "+ ChatGPT" },
  },
  window = {
    delay = 300,
    config = { anchor = "SW", row = "auto", col = "auto", width = "auto" },
  },
})
