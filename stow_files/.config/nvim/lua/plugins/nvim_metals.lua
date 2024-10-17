-- M = {
--   "scalameta/nvim-metals",
--   dependencies = { "nvim-lua/plenary.nvim" },
-- }

-- M.config = function()
--   local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
--   local metals_config = require("metals").bare_config()
--   metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
--   metals_config.init_options.statusBarProvider = "on"

--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "scala", "sbt" },
--     callback = function()
--       require("metals").initialize_or_attach(metals_config)
--     end,
--     group = nvim_metals_group,
--   })

-- end

M = {}
return M
