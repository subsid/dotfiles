local M = {
	"subsid/anchor.nvim",
	lazy = false,
	dependencies = { "nvim-telescope/telescope.nvim" },
}

M.config = function()
	local anchor = require("anchor")
	anchor.setup({})

	local map = vim.keymap.set
	local opts = { noremap = true, silent = true }

	map("n", "<leader>ja", anchor.add, vim.tbl_extend("force", opts, { desc = "Anchor: add file" }))
	map("n", "<leader>jx", anchor.remove, vim.tbl_extend("force", opts, { desc = "Anchor: remove file" }))
	map("n", "<leader>jo", anchor.toggle_menu, vim.tbl_extend("force", opts, { desc = "Anchor: open list" }))
	map("n", "<leader>jt", anchor.open_telescope, vim.tbl_extend("force", opts, { desc = "Anchor: telescope" }))
	map("n", "<leader>jn", anchor.next, vim.tbl_extend("force", opts, { desc = "Anchor: next" }))
	map("n", "<leader>jp", anchor.prev, vim.tbl_extend("force", opts, { desc = "Anchor: prev" }))

	for i = 1, 9 do
		map("n", i .. "j", function()
			anchor.select(i)
		end, vim.tbl_extend("force", opts, { desc = "Anchor: jump to #" .. i }))
	end
end

return M
