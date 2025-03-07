-- stylua全剧配置
vim.g.stylua_indent_type = "Spaces"
vim.g.stylua_indent_width = 2

local opt = vim.opt

-- 行号
-- opt.relativenumber = true
opt.number = true

-- tab与缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 禁用自动折行
opt.wrap = false

-- 搜索忽略大小写
opt.ignorecase = true
opt.smartcase = true

-- 高亮当前行
opt.cursorline = true

-- 主题
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- use system clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"

-- 命令行高为2，提供足够的显示空间
vim.o.cmdheight = 2

-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"

-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = true
vim.o.listchars = "space:·"

-- 永远显示 tabline
vim.o.showtabline = 2

-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode = false

-- 保留撤回历史记录
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")

-- 高亮复制内容
vim.api.nvim_create_augroup("VisualCopy", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "VisualCopy",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- fold method
opt.foldmethod = "marker"

-- highlight
vim.cmd("syntax on")
