require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    tex = { "tex-fmt" },
    html = { "djlint" },
    json = { "biome" },
    javascript = { "biome" },
    css = { "biome" },
    python = { "ruff_format" },
  },
  formatters = {
    biome = {
      append_args = { "--indent-style=space" },
    },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})
