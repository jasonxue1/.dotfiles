-- mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = { noremap = true, silent = true }
local keymap = vim.keymap

-- save and source
keymap.set(
  "n",
  "<leader>s",
  ":w<CR>:so %<CR>:echo expand('%:t') .. ' has been saved and sourced.'<CR>",
  { desc = "Source this file" }
)
keymap.set("n", "<leader>w", ":w<CR>:echo expand('%:t') .. ' has been saved.'<CR>", { desc = "Save" })

-- redo
keymap.set("n", "U", "<C-r>")

-- fold
keymap.set("n", "<Tab>", "za")

-- quick move
keymap.set("n", "J", "9j")
keymap.set("n", "K", "9k")

keymap.set("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window managerment
keymap.set("n", "<leader>nv", "<C-w>v", { desc = "Split windows vertically" })
keymap.set("n", "<leader>nh", "<C-w>s", { desc = "Split windows horizontally" })
keymap.set("n", "<leader>ne", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>nx", "<cmd>close<CR>", { desc = "Close current split" })

-- buffer management
keymap.set("n", "<leader>x", ":bd!<CR>", { desc = "Close current buffer" })
keymap.set("n", "L", ":bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "H", ":bp<CR>", { desc = "Go to previous buffer" })

-- Terminal相关
keymap.set("n", "<leader>zh", ":sp | terminal<CR>", { desc = "Down terminal" })
keymap.set("n", "<leader>zv", ":vsp | terminal<CR>", { desc = "Right terminal" })
keymap.set("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], opt)
keymap.set("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], opt)
keymap.set("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], opt)
keymap.set("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
keymap.set("v", "<", "<gv", opt)
keymap.set("v", ">", ">gv", opt)

-- close nvim
keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Close nvim" })
