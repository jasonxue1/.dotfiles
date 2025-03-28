require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    tex = { "tex-fmt" },
    html = { "djlint" },
    json = { "biome" },
    javascript = { "biome" },
    css = { "biome" },
    python = { "ruff_format" },
    rust = { "rustfmt" },
    toml = { "taplo" },
  },
  formatters = {
    biome = {
      append_args = { "--indent-style=space" },
    },
    taplo = {
      cmd = { "taplo format" },
    },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})
