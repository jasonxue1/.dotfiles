local M = {}

M.is_lsp_attached = function()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  return next(clients) ~= nil
end

M.is_mac = function()
  local uname = vim.uv.os_uname()
  return uname.sysname == "Darwin"
end
