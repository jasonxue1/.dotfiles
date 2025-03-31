local lspconfig = require("lspconfig")
local keymap = vim.keymap
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
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
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts) -- mapping to restart lsp if necessary
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
  virtual_text = false,
  virtual_lines = true,
})
