local opts = { buffer = 0 }
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

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

function Horizontal_term_toggle()
  vim.cmd("ToggleTerm direction=horizontal")
end

function Vertical_term_toggle()
  vim.cmd("ToggleTerm direction=vertical")
end

function Vertical_term_toggle()
  vim.cmd("ToggleTerm direction=vertical")
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua Lazygit_toggle()<CR>", { desc = "Lazygit" })
vim.api.nvim_set_keymap("n", "<leader>zh", "<cmd>lua Horizontal_term_toggle()<CR>", { desc = "Down ternimal" })
vim.api.nvim_set_keymap("n", "<leader>zv", "<cmd>lua Vertical_term_toggle()<CR>", { desc = "Right ternimal" })
