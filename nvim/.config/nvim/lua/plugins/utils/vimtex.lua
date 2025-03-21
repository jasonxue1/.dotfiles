-- VimTeX configuration goes here, e.g.

-- This is necessary for VimTeX to load properly. The "indent" is optional.
-- Note: Most plugin managers will do this automatically!
vim.cmd("filetype plugin indent on")

-- This enables Vim's and Neovim's syntax-related features. Without this, some
-- VimTeX features will not work (see ":help vimtex-requirements" for more info).
-- Note: Most plugin managers will do this automatically!
vim.cmd("syntax enable")

-- Viewer options: One may configure the viewer either by specifying a built-in
-- viewer method:
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_quickfix_mode = 0 --禁用警告

-- 多文件支持
vim.api.nvim_create_augroup("VimTeX", { clear = true })
vim.api.nvim_create_autocmd("BufReadPre", {
  group = "VimTeX",
  pattern = "*/main.tex",
  callback = function()
    vim.b.vimtex_main = "*/main.tex"
  end,
})

-- Or with a generic interface:
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
-- strongly recommended, you probably don't need to configure anything. If you
-- want another compiler backend, you can change it as follows. The list of
-- supported backends and further explanation is provided in the documentation,
-- see ":help vimtex-compiler".
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
  options = { "-xelatex", "-pdf", "-synctex=1", "-interaction=nonstopmode" },
}

-- Set the latexmk engines
vim.g.vimtex_compiler_latexmk_engines = {
  ["_"] = "-xelatex",
}

-- key mappings
vim.keymap.set("n", "<leader>tc", "<cmd>VimtexCompile<CR>", { desc = "Compile LaTeX" })
vim.keymap.set("n", "<leader>tv", "<cmd>VimtexView<CR>", { desc = "View LaTeX" })
