local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>p", MiniMap.toggle, { desc = "MiniMap" })
vim.keymap.set("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], opts)
vim.keymap.set("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], opts)
vim.keymap.set("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], opts)
vim.keymap.set("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], opts)
