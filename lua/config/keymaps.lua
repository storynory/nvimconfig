-- Add keymaps here as you grow your config
local map = vim.keymap.set
map("n", "<leader>q", ":q!<CR>", { desc = "quit no save" })
map("n", "<leader>w", ":w<CR>", { desc = "save" })
map("n", "<leader>bd", ":bd<CR>", { desc = "quit buffer" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil file explorer" })

vim.keymap.set("n", "<Leader><space>", function()
	require("snacks.picker").files() -- Or Snacks.picker.smart()
end, { desc = "Smart File Finder" })

-- Copy relative path to system clipboard
map('n', '<leader>cf', '<cmd>let @+ = expand("%")<CR>', { desc = "Copy relative path" })
-- Copy absolute path to system clipboard
map('n', '<leader>cF', '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy absolute path" })


-- easy mac commands
map({ "n", "i" }, "<D-s>", function()
	vim.cmd("w")
end, { desc = "Save file" })
map("i", "<D-f>", "<Esc>/", { desc = "Find (search) insert mode" })
map("n", "<D-f>", "<Esc>/", { desc = "Find (search) insert mode" })

map("v", "<D-c>", '"+y', { noremap = true, silent = true }, { desc = "copy to mac clipboard normal mode" })
map("i", "<D-c>", '"+y', { noremap = true, silent = true }, { desc = "copy to mac clip board insert mode" })
map("n", "<leader>noh", "<cmd>no<CR>", { desc = "Clear search highlight" })

map("n", "<leader>rr", function()
	vim.cmd("luafile ~/.config/nvim/lua/config/reload.lua")
end, { desc = "Reload nvim config" })

-- moving in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })




-- Prompt to wrap any visual selection in custom HTML tags
map("v", "gS", function()
	-- Ask the user for the tag name (e.g. p, div, nav)
	vim.ui.input({ prompt = "Tag name: " }, function(tag)
		if not tag or tag == "" then return end
		-- Standard vim escape sequences to execute the change
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		vim.api.nvim_feedkeys(esc, "x", false)

		-- Format wrap based on tags
		local open_tag = string.format("<%s>", tag)
		local close_tag = string.format("</%s>", tag)

		-- Insert wrap tags around your last visual selection registers
		vim.cmd(string.format("normal! `>a%s", close_tag))
		vim.cmd(string.format("normal! `<i%s", open_tag))
	end)
end, { desc = "AWrap selection in HTML tag" })

-- errors
map("n", "<leader>d", function()
	vim.diagnostic.setqflist({ open = true })
end, { desc = "Show all errors" })

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
end, { desc = "Copy all errors" })
