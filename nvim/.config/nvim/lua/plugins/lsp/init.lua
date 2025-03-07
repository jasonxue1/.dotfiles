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
      "ltex",
      "basedpyright",
      "ruff",
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
-- lsp {{{
later(function()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "rmagatti/goto-preview",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  })
  require("plugins.lsp.config")
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
      tex = { "tex-fmt" },
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
-- cmp {{{
later(function()
  add({
    source = "hrsh7th/nvim-cmp",
    depends = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "abeldekat/cmp-mini-snippets",
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-nvim-lua",
      "petertriho/cmp-git",
      "kdheepak/cmp-latex-symbols",
    },
  })

  -- Set up nvim-cmp.
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- For `mini.snippets` users:
        MiniSnippets = require("mini.snippets")
        local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        insert({ body = args.body }) -- Insert at cursor
        cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      ["<Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,

      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,

      ["<c-j>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,

      ["<c-k>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    }),

    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 4 },
      { name = "mini_snippets", priority = 3 },
      { name = "path", priority = 100 },
      { name = "buffer", keyword_length = 2, priority = 2 },
      { name = "nvim_lua", priority = 1 },
      { name = "latex_symbols", option = { strategy = 0 } },
    }),

    experimental = {
      native_menu = false,
      ghost_test = true,
    },
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "git" },
      { name = "buffer" },
    }),
  })
  require("cmp_git").setup()

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end)
-- }}}

-- -- mini.completion {{{
-- later(function()
--   require("mini.completion").setup()
--   local imap_expr = function(lhs, rhs)
--     vim.keymap.set("i", lhs, rhs, { expr = true })
--   end
--   imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
--   imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
--   imap_expr("<C-j>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
--   imap_expr("<C-k>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
--
--   local keycode = vim.keycode or function(x)
--     return vim.api.nvim_replace_termcodes(x, true, true, true)
--   end
--   local keys = {
--     ["cr"] = keycode("<CR>"),
--     ["ctrl-y"] = keycode("<C-y>"),
--     ["ctrl-y_cr"] = keycode("<C-y><CR>"),
--   }
--
--   _G.cr_action = function()
--     if vim.fn.pumvisible() ~= 0 then
--       -- If popup is visible, confirm selected item or add new line otherwise
--       local item_selected = vim.fn.complete_info()["selected"] ~= -1
--       return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
--     else
--       -- If popup is not visible, use plain `<CR>`. You might want to customize
--       -- according to other plugins. For example, to use 'mini.pairs', replace
--       -- next line with `return require('mini.pairs').cr()`
--       return keys["cr"]
--     end
--   end
--
--   vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
-- end)
-- -- }}}
