local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- mason {{{
later(function()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  })
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {},
  })
end)
-- }}}
-- nvim-lint {{{
-- }}}
-- lsp {{{
later(function()
  add({
    source = "VonHeikemen/lsp-zero.nvim",
    depends = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    branch = "v3.x",
  })
  local lsp_zero = require("lsp-zero")

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings to learn the available actions
    lsp_zero.default_keymaps({
      buffer = bufnr,
      preserve_mappings = false,
    })
  end)
end)
-- }}}
-- guard {{{
later(function()
  add({
    source = "nvimdev/guard.nvim",
    depends = {
      "nvimdev/guard-collection",
    },
  })
  local ft = require("guard.filetype")

  -- Assuming you have guard-collection
  -- Put this in your ftplugin/lang.lua to lazy load guard
  ft("lua"):fmt("stylua"):lint()
  -- change this anywhere in your config (or not), these are the defaults
  vim.g.guard_config = {
    -- format on write to buffer
    fmt_on_save = true,
    -- use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = true,
    -- whether or not to save the buffer after formatting
    save_on_fmt = true,
    -- automatic linting
    auto_lint = true,
    -- how frequently can linters be called
    lint_interval = 500,
  }
end)
-- }}}
-- cmp {{{
later(function()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
    },
  })
  -- Set up nvim-cmp.
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

        -- For `mini.snippets` users:
        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        -- insert({ body = args.body }) -- Insert at cursor
        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        -- require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = "buffer" },
    }),
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]
  --

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
    }, {
      { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = true },
  })
end)
-- }}}
