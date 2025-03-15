local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local lspconfig = require("lspconfig")
local keymap = vim.keymap
later(function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- keybinds {{{
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf, silent = true }

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'references' })<CR>", opts) -- show definition, references

      opts.desc = "Show LSP declaration"
      keymap.set("n", "gD", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'declaration' })<CR>", opts) -- show definition, references

      opts.desc = "Show LSP definition"
      keymap.set("n", "gd", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'definition' })<CR>", opts) -- show definition, references

      opts.desc = "Show LSP implementation"
      keymap.set("n", "gi", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'implementation' })<CR>", opts) -- show definition, references

      opts.desc = "Show LSP type definition"
      keymap.set("n", "gt", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'type_definition' })<CR>", opts) -- show definition, references

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      -- opts.desc = "Show buffer diagnostics"
      -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "<leader>d", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts) -- mapping to restart lsp if necessary

      -- }}}
    end,
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = "󰠠 ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
    virtual_text = true,
  })

  local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

  ---@diagnostic disable-next-line: unused-local
  local on_init = function(client, bufnr)
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end
  local lsp_attach = function(client, bufnr) end
  -- lua {{{
  lspconfig.lua_ls.setup({
    capabilities = lsp_capabilities,
    on_init = on_init,
    on_attach = lsp_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim",
            "MiniDeps",
            "MiniPick",
            "MiniExtra",
            "MiniFiles",
            "MiniMap",
            "MiniNotify",
          },
        },
        hint = {
          enable = true,
          arrayIndex = "Enable",
          await = true,
          paramName = "All",
          paramType = true,
          semicolon = "All",
          setType = true,
        },
        workspace = {},
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
  -- }}}
  -- latex {{{
  require("lspconfig").ltex.setup({
    capabilities = lsp_capabilities,
    on_init = on_init,
    on_attach = lsp_attach,
  })
  -- }}}
  -- python {{{
  lspconfig.ruff.setup({})
  lspconfig["basedpyright"].setup({
    capabilities = lsp_capabilities,
    on_init = on_init,
    on_attach = lsp_attach,
    settings = {
      basedpyright = {
        typeCheckingMode = "basic",
        analysis = {
          diagnosticMode = "openFilesOnly",
          strictGenericNarrowing = true,
          inlayHints = {
            variableTypes = true,
            callArgumentNames = true,
            functionReturnTypes = true,
            genericTypes = true,
          },
        },
      },
    },
  })
  -- }}}
  -- html {{{

  lspconfig.html.setup({
    capabilities = lsp_capabilities,
    on_init = on_init,
    on_attach = lsp_attach,
  })
  lspconfig.cssls.setup({
    capabilities = lsp_capabilities,
    on_init = on_init,
    on_attach = lsp_attach,
  })
  lspconfig["ts_ls"].setup({
    capabilities = lsp_capabilities,
    on_init = on_init,
    on_attach = lsp_attach,
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
          languages = { "vue" },
        },
      },
    },
    -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    settings = {
      typescript = {
        tsserver = {
          useSyntaxServer = true,
        },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  })
  -- }}}
end)
