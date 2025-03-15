local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_init = function(client, bufnr)
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
local lsp_attach = function(client, bufnr)
  --
end
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
require("lspconfig").texlab.setup({
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
