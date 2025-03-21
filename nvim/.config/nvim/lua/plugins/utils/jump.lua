require("mini.jump").setup()
require("mini.jump2d").setup({ view = { dim = true } })
local function jump2d_query()
  MiniJump2d.start(MiniJump2d.builtin_opts.query)
end
vim.keymap.set({ "n", "x", "o" }, "<CR>", jump2d_query, { desc = "Jump2d query" })
