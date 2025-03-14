local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now

add({
  source = "olimorris/codecompanion.nvim",
  depends = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
})

later(function()
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "openai",
      },
      inline = {
        adapter = "openai",
      },
    },
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = "OPENAI_API_KEY",
          },
          schema = {
            model = {
              default = "o1-mini",
            },
          },
        })
      end,
    },
  })
  vim.keymap.set({ "n", "v" }, "<C-b>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
  vim.keymap.set(
    { "n", "v" },
    "<LocalLeader>a",
    "<cmd>CodeCompanionChat Toggle<cr>",
    { noremap = true, silent = true, desc = "CodeCompanionChat" }
  )
  vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd([[cab cc CodeCompanion]])
end)
