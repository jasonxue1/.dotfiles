require("crates").setup({
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
  completion = {
    cmp = {
      enabled = true,
    },
  },
})

local crates = require("crates")

local function show_features_popup_focus()
  crates.show_features_popup()
  vim.defer_fn(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then -- 是浮动窗口
        vim.api.nvim_set_current_win(win)
        break
      end
    end
  end, 50)
end

vim.keymap.set("n", "<leader>cf", show_features_popup_focus, { desc = "Show crate features + focus" })
vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Toggle crates.nvim" })
vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload crates" })

vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show crate versions" })
vim.keymap.set("n", "<leader>cf", show_features_popup_focus, { desc = "Show crate features" })
vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Show crate dependencies" })

vim.keymap.set("n", "<leader>cu", crates.update_crate, { desc = "Update crate" })
vim.keymap.set("v", "<leader>cu", crates.update_crates, { desc = "Update selected crates" })
vim.keymap.set("n", "<leader>ca", crates.update_all_crates, { desc = "Update all crates" })

vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, { desc = "Upgrade crate" })
vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, { desc = "Upgrade selected crates" })
vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, { desc = "Upgrade all crates" })

vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, { desc = "Expand crate to inline table" })
vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, { desc = "Extract crate into table" })

vim.keymap.set("n", "<leader>cH", crates.open_homepage, { desc = "Open crate homepage" })
vim.keymap.set("n", "<leader>cR", crates.open_repository, { desc = "Open crate repository" })
vim.keymap.set("n", "<leader>cD", crates.open_documentation, { desc = "Open crate documentation" })
vim.keymap.set("n", "<leader>cC", crates.open_crates_io, { desc = "Open crate on crates.io" })
vim.keymap.set("n", "<leader>cL", crates.open_lib_rs, { desc = "Open crate on lib.rs" })
