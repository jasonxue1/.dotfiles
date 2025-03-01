local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- mason {{{
later(function()
  add({
    source = "williamboman/mason.nvim",
    depends = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "antosha417/nvim-lsp-file-operations",
    },
  })
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      -- "ast_grep",
      "lua_ls",
    },
  })
end)
-- }}}
-- nvim-lint {{{
later(function()
  add({
    source = "mfussenegger/nvim-lint",
  })
  require("lint").linters_by_ft = {
    -- lua = { "ast_grep" },
  }
end)
-- }}}
-- -- lsp {{{
-- later(function()
--   add({
--     source = "VonHeikemen/lsp-zero.nvim",
--     depends = {
--       "neovim/nvim-lspconfig",
--       "hrsh7th/nvim-cmp",
--       "hrsh7th/cmp-nvim-lsp",
--     },
--     branch = "v3.x",
--   })
--   local lsp_zero = require("lsp-zero")
--
--   lsp_zero.on_attach(function(client, bufnr)
--     -- see :help lsp-zero-keybindings to learn the available actions
--     lsp_zero.default_keymaps({
--       buffer = bufnr,
--       preserve_mappings = false,
--     })
--   end)
--
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
-- end)
-- -- }}}
-- lsp {{{
later(function()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "rmagatti/goto-preview",
      "williamboman/mason-lspconfig.nvim",
    },
  })
  require("lsp.config")
end)
-- }}}
-- conform {{{
later(function()
  add({
    source = "stevearc/conform.nvim",
  })
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      json = { "jq" },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })
end)
-- }}}
-- snippets {{{
later(function()
  add({
    source = "rafamadriz/friendly-snippets",
  })
  local gen_loader = require("mini.snippets").gen_loader
  require("mini.snippets").setup({
    snippets = {
      -- Load custom file with global snippets first (adjust for Windows)
      gen_loader.from_file("~/.config/nvim/snippets/global.json"),

      -- Load snippets based on current language by reading files from
      -- "snippets/" subdirectories from 'runtimepath' directories.
      gen_loader.from_lang(),
    },
  })
end)
-- }}}
-- mini.completion {{{
later(function()
  require("mini.completion").setup()
  local imap_expr = function(lhs, rhs)
    vim.keymap.set("i", lhs, rhs, { expr = true })
  end
  imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
  imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
  imap_expr("<C-j>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
  imap_expr("<C-k>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

  local keycode = vim.keycode or function(x)
    return vim.api.nvim_replace_termcodes(x, true, true, true)
  end
  local keys = {
    ["cr"] = keycode("<CR>"),
    ["ctrl-y"] = keycode("<C-y>"),
    ["ctrl-y_cr"] = keycode("<C-y><CR>"),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      -- If popup is visible, confirm selected item or add new line otherwise
      local item_selected = vim.fn.complete_info()["selected"] ~= -1
      return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
    else
      -- If popup is not visible, use plain `<CR>`. You might want to customize
      -- according to other plugins. For example, to use 'mini.pairs', replace
      -- next line with `return require('mini.pairs').cr()`
      return keys["cr"]
    end
  end

  vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
end)
-- }}}
