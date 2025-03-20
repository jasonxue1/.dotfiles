-- mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }
local keymap = vim.keymap

keymap.set("n", "gp", "<Nop>", opt)
-- save and source
keymap.set(
  "n",
  "<leader>s",
  "<cmd>w<CR>:so %<CR>:echo expand('%:t') .. ' has been saved and sourced.'<CR>",
  { desc = "Source this file" }
)
keymap.set("n", "<leader>w", "<cmd>w<CR>:echo expand('%:t') .. ' has been saved.'<CR>", { desc = "Save" })

-- redo
keymap.set("n", "U", "<C-r>")

-- fold
keymap.set("n", "<Tab>", "za")

-- quick move
keymap.set("n", "J", "9j")
keymap.set("n", "K", "9k")

keymap.set("n", "<leader>h", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window managerment
keymap.set("n", "<leader>nv", "<C-w>v", { desc = "Split windows vertically" })
keymap.set("n", "<leader>nh", "<C-w>s", { desc = "Split windows horizontally" })
keymap.set("n", "<leader>ne", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>nx", "<cmd>close<CR>", { desc = "Close current split" })

-- buffer management
keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close current buffer" })
keymap.set("n", "L", "<cmd>bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "H", "<cmd>bp<CR>", { desc = "Go to previous buffer" })

-- visual模式下缩进代码
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- close nvim
keymap.set("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit nvim" })
-- keymap.set("n", "q", ":q<CR>", opt)
