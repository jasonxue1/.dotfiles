require("mini.git").setup()
vim.keymap.set({ "n", "x" }, "<leader>ga", MiniGit.show_at_cursor, { desc = "Git show at cursor" })
vim.keymap.set({ "n", "v" }, "<leader>gh", MiniGit.show_range_history, { desc = "Git show range history" })
vim.keymap.set({ "n", "v" }, "<leader>gd", MiniGit.show_diff_source, { desc = "Git show diff source" })

require("mini.diff").setup()
vim.keymap.set("n", "<leader>go", MiniDiff.toggle_overlay, { desc = "Git toggle overlay" })
