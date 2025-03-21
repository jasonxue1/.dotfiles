require("mini.files").setup({
  windows = {
    preview = true,
    width_preview = 50,
  },
})
local function minifiles_open_current()
  if vim.fn.filereadable(vim.fn.bufname("%")) > 0 then
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  else
    MiniFiles.open(MiniFiles.get_latest_path())
  end
end
vim.keymap.set("n", "<leader>ee", MiniFiles.open, { desc = "MiniFiles open" })
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
