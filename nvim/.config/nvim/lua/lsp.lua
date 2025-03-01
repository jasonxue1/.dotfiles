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

  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
-- }}}
-- blink {{{
later(function()
  -- use a release tag to download pre-built binaries
  MiniDeps.add({
    source = "saghen/blink.cmp",
    depends = {
      "rafamadriz/friendly-snippets",
    },
  })
  require("blink.cmp").setup({
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<cr>"] = { "accept", "fallback" },

      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-e>"] = { "snippet_forward", "fallback" },
      ["<C-u>"] = { "snippet_backward", "fallback" },

      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    },
    completion = {
      keyword = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before _and_ after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        range = "full",
      },
      list = {
        -- Maximum number of items to display
        max_items = 200,

        selection = {
          -- When `true`, will automatically select the first item in the completion list
          preselect = false,
          -- preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end,

          -- When `true`, inserts the completion item automatically when selecting it
          -- You may want to bind a key to the `cancel` command (default <C-e>) when using this option,
          -- which will both undo the selection and hide the completion menu
          auto_insert = true,
          -- auto_insert = function(ctx) return vim.bo.filetype ~= 'markdown' end
        },

        cycle = {
          -- When `true`, calling `select_next` at the _bottom_ of the completion list
          -- will select the _first_ completion item.
          from_bottom = true,
          -- When `true`, calling `select_prev` at the _top_ of the completion list
          -- will select the _last_ completion item.
          from_top = true,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },
    enabled = function()
      return not vim.tbl_contains({
        "markdown",
      }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
    end,
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    snippets = { preset = "mini_snippets" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        buffer = { score_offset = 3 },
        lsp = { score_offset = 2 },
        path = { score_offset = 1 },
        snippets = { score_offset = 0 },
      },
    },

    -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  })
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
