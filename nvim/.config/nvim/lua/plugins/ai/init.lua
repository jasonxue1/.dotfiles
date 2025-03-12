local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
later(function()
  add({
    source = "jackMort/ChatGPT.nvim",
    depends = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      -- "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
  })
  require("chatgpt").setup({
    -- this config assumes you have OPENAI_API_KEY environment variable set
    openai_params = {
      -- NOTE: model can be a function returning the model name
      -- this is useful if you want to change the model on the fly
      -- using commands
      -- Example:
      -- model = function()
      --     if some_condition() then
      --         return "gpt-4-1106-preview"
      --     else
      --         return "gpt-3.5-turbo"
      --     end
      -- end,
      model = "gpt-4o",
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 4095,
      temperature = 0.2,
      top_p = 0.1,
      n = 1,
    },
  })

  -- 单一模式映射（仅普通模式）
  vim.keymap.set("n", "<leader>cc", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })

  -- 需要在普通和可视模式下生效的映射
  vim.keymap.set({ "n", "v" }, "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
  vim.keymap.set({ "n", "v" }, "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
  vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
  vim.keymap.set({ "n", "v" }, "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
  vim.keymap.set({ "n", "v" }, "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
  vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
  vim.keymap.set({ "n", "v" }, "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
  vim.keymap.set({ "n", "v" }, "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
  vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
  vim.keymap.set({ "n", "v" }, "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
  vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
  vim.keymap.set(
    { "n", "v" },
    "<leader>cl",
    "<cmd>ChatGPTRun code_readability_analysis<CR>",
    { desc = "Code Readability Analysis" }
  )
end)
