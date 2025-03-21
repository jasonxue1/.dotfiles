require("mini.pick").setup({
  vim.keymap.set("n", "<Leader>ff", "<cmd>Pick files<CR>", { desc = "Find files" }),
  vim.keymap.set("n", "<Leader>fb", "<cmd>Pick buffers<CR>", { desc = "Find buffers" }),
  vim.keymap.set("n", "<Leader>fh", "<cmd>Pick help<CR>", { desc = "Find helps" }),
  vim.keymap.set("n", "<Leader>fg", "<cmd>Pick grep_live<CR>", { desc = "Grep" }),
  options = {
    content_from_bottom = false,
  },
  mappings = {
    move_down = "<C-j>",
    move_up = "<C-k>",

    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
    scroll_left = "<C-h>",
    scroll_right = "<C-l>",
  },
})

vim.ui.select = MiniPick.ui_select
