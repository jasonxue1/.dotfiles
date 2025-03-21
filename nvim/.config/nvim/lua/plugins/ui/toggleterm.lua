local opts = { buffer = 0 }
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

local opts = { noremap = true, silent = true }
require("toggleterm").setup({
  open_mapping = [[<C-\>]], -- 你可以改成别的快捷键
  direction = "float", -- 默认浮动终端
  shade_terminals = false,
  shell = vim.o.shell,
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
})

function Lazygit_toggle()
  lazygit:toggle()
end

function Float_term_toggle()
  vim.cmd("ToggleTerm direction=float")
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua Lazygit_toggle()<CR>", { desc = "Lazygit" })
vim.api.nvim_set_keymap("n", "<leader>zz", "<cmd>lua Float_term_toggle()<CR>", { desc = "Float ternimal" })
