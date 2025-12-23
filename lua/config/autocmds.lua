--vim.api.nvim_create_autocmd("VimEnter", {
--	callback = function()
--		if vim.fn.argc() == 0 then
--			require("telescope.builtin").find_files()
--		end
--	end,
--})

vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
		prefix = "●",
	},
})

-- Emergency save when file is readonly
vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function()
		if vim.bo.readonly then
			vim.cmd('w !sudo tee % > /dev/null')
			vim.cmd('e!')
		end
	end,
})

-- Reveal file in Finder (macOS)
vim.api.nvim_create_user_command("Rfinder", function()
	local path = vim.api.nvim_buf_get_name(0)
	if path ~= "" then
		os.execute('open -R "' .. path .. '"')
	end
end, {})

-- Remove trailing whitespace before save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.md", "*.txt" },
	callback = function()
		local save = vim.fn.winsaveview()
		vim.cmd [[%s/\s\+$//e]]
		vim.fn.winrestview(save)
	end,
})

-- remove doulble + spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.md",
	callback = function()
		local view = vim.fn.winsaveview()
		local buf = vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

		local in_code_block = false

		for i, line in ipairs(lines) do
			-- Toggle fenced code block state
			if line:match("^%s*```") then
				in_code_block = not in_code_block
			end

			if not in_code_block then
				-- Collapse 2+ spaces to 1, but never touch indentation
				lines[i] = line:gsub("([^%s])%s%s+", "%1 ")
			end
		end

		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.fn.winrestview(view)
	end,
})


-- Zen writing settings for prose files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "md" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_gb"
		--vim.cmd('colorscheme kanagawa-wave')


		vim.opt_local.textwidth = 0
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true

		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,

})
-- For markdown and text files, use display-line motions
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "md" },
	callback = function()
		-- Enable wrapping
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true

		local map = vim.keymap.set
		local opts = { buffer = true, silent = true, noremap = true }

		-- Move down/up by *display* lines (soft wrap aware)
		map("n", "j", "gj", opts)
		map("n", "k", "gk", opts)

		-- Keep h/l normal (they behave fine with soft wrap), but if you want:
		-- map("n", "h", "g^", opts)
		-- map("n", "l", "g$", opts)
	end,
})
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*.md',
	callback = function()
		vim.b.completion = false
	end,
})

vim.api.nvim_create_user_command("LspList", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("No LSPs attached to this buffer.")
		return
	end

	for _, c in ipairs(clients) do
		print("• " .. c.name)
	end
end, {})

-- telescope look
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#313244", bold = true })
