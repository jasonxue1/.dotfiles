require("swenv").setup({
  post_set_venv = function()
    local client = vim.lsp.get_clients({ name = "basedpyright" })[1]
    if not client then
      return
    end
    local venv = require("swenv.api").get_current_venv()
    if not venv then
      return
    end
    local venv_python = venv.path .. "/bin/python"
    if client.settings then
      client.settings = vim.tbl_deep_extend("force", client.settings, { python = { pythonPath = venv_python } })
    else
      client.config.settings =
        vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = venv_python } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    require("swenv.api").auto_venv()
  end,
})
