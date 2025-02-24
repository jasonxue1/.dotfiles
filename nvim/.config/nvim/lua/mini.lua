-- mini.deps {{{
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
require("lsp")

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- }}}
-- mini.files {{{
now(function()
  require("mini.files").setup()
  local function minifiles_open_current()
    if vim.fn.filereadable(vim.fn.bufname("%")) > 0 then
      MiniFiles.open(vim.api.nvim_buf_get_name(0))
    else
      MiniFiles.open(Minifiles.get_latest_path())
    end
  end
  vim.keymap.set("n", "<leader>ee", ":lua MiniFiles.open()<CR>", { desc = "MiniFiles open" })
  vim.keymap.set("n", "<leader>ef", minifiles_open_current, { desc = "MiniFiles open current" })
  local show_dotfiles = true

  local filter_show = function(fs_entry)
    return true
  end

  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
  end

  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak left-hand side of mapping to your liking
      vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
    end,
  })
  local set_mark = function(id, path, desc)
    MiniFiles.set_bookmark(id, path, { desc = desc })
  end
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesExplorerOpen",
    callback = function()
      set_mark("c", vim.fn.stdpath("config"), "Config") -- path
      set_mark("w", vim.fn.getcwd, "Working directory") -- callable
      set_mark("~", "~", "Home directory")
    end,
  })
end)
-- }}}
-- colorschemes {{{
now(function()
  add({
    source = "folke/tokyonight.nvim",
  })
  vim.o.termguicolors = true
  vim.cmd("colorscheme tokyonight-moon")
end)
-- }}}
-- mini.clue {{{
later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    triggers = {
      -- Leader triggers
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },

      -- Built-in completion
      { mode = "i", keys = "<C-x>" },

      -- `g` key
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },

      -- Marks
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },

      -- Registers
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },

      -- Window commands
      { mode = "n", keys = "<C-w>" },

      -- `z` key
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
      { mode = "n", keys = "<leader>f", desc = "+ Find" },
      { mode = "n", keys = "<leader>g", desc = "+ Git" },
      { mode = "n", keys = "<leader>t", desc = "+ LaTeX" },
      { mode = "n", keys = "<leader>e", desc = "+ MiniFiles" },
    },
    window = {
      delay = 300,
      config = { anchor = "SW", row = "auto", col = "auto", width = "auto" },
    },
  })
end)
-- }}}
-- mini.pick {{{
later(function()
  require("mini.pick").setup({
    vim.keymap.set("n", "<Leader>ff", ":Pick files<CR>", { desc = "Find files" }),
    vim.keymap.set("n", "<Leader>fb", ":Pick buffers<CR>", { desc = "Find buffers" }),
    vim.keymap.set("n", "<Leader>fh", ":Pick help<CR>", { desc = "Find helps" }),
    vim.keymap.set("n", "<Leader>fg", ":Pick grep_live<CR>", { desc = "Grep" }),
    options = {
      content_from_bottom = true,
    },
    mappings = {
      move_down = "<C-j>",
      move_up = "<C-k>",

      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
      scroll_left = "<C-h>",
      scroll_right = "<C-l>",
    },
  })

  vim.ui.select = MiniPick.ui_select
end)
-- }}}
-- mini.pairs {{{
now(function()
  require("mini.pairs").setup()
end)
-- }}}
-- Treesitter {{{
later(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    -- run after
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = { enable = true },
  })
end)
-- }}}
-- mini.tabline {{{
now(function()
  require("mini.tabline").setup()
end)
-- }}}
-- mini.statusline {{{
now(function()
  require("mini.statusline").setup()
end)
-- }}}
-- mini.indentscope {{{
now(function()
  require("mini.indentscope").setup({
    draw = {
      animation = require("mini.indentscope").gen_animation.none(),
    },
  })
end)
-- }}}
-- mini.icons {{{
later(function()
  require("mini.icons").setup()
end)
-- }}}
-- mini.highlights {{{
later(function()
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE', 'DONE'
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      done = { pattern = "%f[%w]()DONE()%f[%W]", group = "MiniHipatternsNote" },
      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)
-- }}}
-- git {{{
later(function()
  require("mini.git").setup()
  vim.keymap.set({ "n", "x" }, "<leader>ga", MiniGit.show_at_cursor, { desc = "Git show at cursor" })
  vim.keymap.set({ "n", "v" }, "<leader>gh", MiniGit.show_range_history, { desc = "Git show range history" })
  vim.keymap.set({ "n", "v" }, "<leader>gd", MiniGit.show_diff_source, { desc = "Git show diff source" })

  require("mini.diff").setup()
  vim.keymap.set("n", "<leader>go", MiniDiff.toggle_overlay, { desc = "Git toggle overlay" })
  add({
    source = "kdheepak/lazygit.nvim",
  })
  vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
  vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
  vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
  vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
  vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

  vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
  vim.g.lazygit_config_file_path = "" -- custom config file path
  -- OR
  vim.g.lazygit_config_file_path = {} -- table of custom config file paths

  vim.g.lazygit_on_exit_callback = nil -- optional function callback when exiting lazygit (useful for example to refresh some UI elements after lazy git has made some changes)
  vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Lazygit" })
end)
-- }}}
-- mini.sessions {{{
now(function()
  require("mini.sessions").setup({})
end)
-- }}}
-- mini.starter {{{
now(function()
  require("mini.starter").setup()
end)
-- }}}
-- mini.notify {{{
later(function()
  require("mini.notify").setup()
  vim.keymap.set("n", "<leader>N", MiniNotify.clear, { desc = "Notify clear" })
end)
-- }}}
-- mini.jump {{{
later(function()
  require("mini.jump").setup()
  require("mini.jump2d").setup({ view = { dim = true } })
  local function jump2d_query()
    MiniJump2d.start(MiniJump2d.builtin_opts.query)
  end
  vim.keymap.set({ "n", "x", "o" }, "<CR>", jump2d_query, { desc = "Jump2d query" })
end)
-- }}}
-- markview {{{
later(function()
  add({
    source = "OXY2DEV/markview.nvim",
  })
  require("markview").setup({
    preview = {
      icon_provider = "mini",
    },
  })
end)
-- }}}
-- vimtex {{{
later(function()
  add({
    source = "lervag/vimtex",
  })
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
  vim.keymap.set("n", "<leader>tc", ":VimtexCompile<CR>", { desc = "Compile LaTeX" })
  vim.keymap.set("n", "<leader>tv", ":VimtexView<CR>", { desc = "View LaTeX" })
end)
-- }}}
--  rainbow {{{
later(function()
  add({
    source = "HiPhish/rainbow-delimiters.nvim",
  })
  -- This module contains a number of default definitions
  local rainbow_delimiters = require("rainbow-delimiters")

  ---@type rainbow_delimiters.config
  vim.g.rainbow_delimiters = {
    strategy = {
      [""] = rainbow_delimiters.strategy["global"],
      vim = rainbow_delimiters.strategy["local"],
    },
    query = {
      [""] = "rainbow-delimiters",
      lua = "rainbow-blocks",
    },
    priority = {
      [""] = 110,
      lua = 210,
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  }
end)
-- }}}
-- mini.cursorword{{{
later(function()
  require("mini.cursorword").setup()
end)
-- }}}
-- mini.trailspace{{{
later(function()
  require("mini.trailspace").setup()
end)
-- }}}
-- mini.align {{{
later(function()
  require("mini.align").setup()
end)
-- }}}
-- mini.ai {{{
later(function()
  require("mini.ai").setup()
end)
-- }}}
-- mini.surround {{{
later(function()
  require("mini.surround").setup()
end)
-- }}}
-- nvim-lastplace {{{
now(function()
  add({
    source = "ethanholz/nvim-lastplace",
  })
  require("nvim-lastplace").setup()
end)
-- }}}
-- tmux {{{
later(function()
  add({
    source = "christoomey/vim-tmux-navigator",
  })
end)
-- }}}
-- vim-maximizer {{{
later(function()
  add({
    source = "szw/vim-maximizer",
  })
  require("nvim-lastplace").setup({
    vim.keymap.set("n", "<leader>m", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" }),
  })
end)
-- }}}
