vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

require("lazydev").setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
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
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

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
    { name = "lazydev", group_index = 0 },
    { name = "nvim_lsp", priority = 4 },
    { name = "mini_snippets", priority = 3 },
    { name = "path", priority = 100 },
    { name = "buffer", keyword_length = 2, priority = 2 },
    { name = "nvim_lua", priority = 1 },
    { name = "latex_symbols", option = { strategy = 0 } },
    { name = "crates", priority = 1 },
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
