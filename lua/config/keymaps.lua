-- General Neovim keymaps
-- Leader key: Space

local map = vim.keymap.set

-- Files and buffers
-- ----------------------------------------

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit without saving" })
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Find files with Snacks
map("n", "<leader><space>", function()
	require("snacks.picker").files()
end, { desc = "Find files" })


-- Copy file paths
-- ----------------------------------------

map("n", "<leader>cf", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative file path" })

map("n", "<leader>cF", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy absolute file path" })


-- Window navigation
-- ----------------------------------------

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })


-- Search and configuration
-- ----------------------------------------

map("n", "<leader>h", "<cmd>nohlsearch<CR>", {
	desc = "Clear search highlighting",
})

map("n", "<leader>rr", function()
	vim.cmd("luafile ~/.config/nvim/lua/config/reload.lua")
end, { desc = "Reload Neovim config" })


-- Wrap visual selection in HTML tags
-- ----------------------------------------

map("v", "gS", function()
	vim.ui.input({ prompt = "Tag name: " }, function(tag)
		if not tag or tag == "" then return end

		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		vim.api.nvim_feedkeys(esc, "x", false)

		local open_tag = string.format("<%s>", tag)
		local close_tag = string.format("</%s>", tag)

		vim.cmd(string.format("normal! `>a%s", close_tag))
		vim.cmd(string.format("normal! `<i%s", open_tag))
	end)
end, { desc = "Wrap selection in HTML tag" })


-- Diagnostics
-- ----------------------------------------

-- Show all diagnostics in the quickfix list
map("n", "<leader>d", function()
	vim.diagnostic.setqflist({ open = true })
end, { desc = "Show diagnostics" })

-- Copy diagnostics to clipboard
map("n", "<leader>D", function()
	local errors = vim.diagnostic.get(nil)
	local lines = {}

	for _, d in ipairs(errors) do
		local filename = vim.api.nvim_buf_get_name(d.bufnr)
		table.insert(lines, string.format(
			"%s:%d: %s",
			filename,
			d.lnum + 1,
			d.message
		))
	end

	vim.fn.setreg("+", table.concat(lines, "\n"))
	vim.notify("Copied " .. #errors .. " diagnostics")
end, { desc = "Copy diagnostics" })
