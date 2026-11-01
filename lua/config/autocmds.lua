-- autocommands.lua
-- Automatic behaviour for writing and editing


-- Clipboard: OSC 52 (terminal clipboard)
-- ----------------------------------------

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}


-- Diagnostics
-- ----------------------------------------

vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
		prefix = "●",
	},
})


-- Prose: Markdown and plain text
-- ----------------------------------------

local prose = vim.api.nvim_create_augroup("ProseSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = prose,
	pattern = { "markdown", "text" },
	callback = function(args)
		-- British English spelling
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_gb"

		if vim.bo.filetype == "markdown" then
			vim.cmd.colorscheme("kanagawa-wave")
		end

		-- Soft wrapping without changing file contents
		vim.opt_local.textwidth = 0
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true

		-- Hide line numbers when writing prose
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false

		-- Move by displayed lines rather than logical lines
		vim.keymap.set("n", "j", "gj", {
			buffer = args.buf,
			silent = true,
			desc = "Move down a displayed line",
		})

		vim.keymap.set("n", "k", "gk", {
			buffer = args.buf,
			silent = true,
			desc = "Move up a displayed line",
		})
	end,
})


-- Clean trailing whitespace on save
-- ----------------------------------------
-- Only Markdown and text files.
-- Preserve two trailing spaces used for Markdown line breaks.


vim.api.nvim_create_autocmd("BufWritePre", {
	group = prose,
	pattern = { "*.md", "*.txt" },
	callback = function(args)
		local view = vim.fn.winsaveview()
		local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
		local changed = false

		for i, line in ipairs(lines) do
			-- Remove trailing whitespace except Markdown hard breaks
			if not (vim.bo[args.buf].filetype == "markdown" and line:match("  $")) then
				local cleaned = line:gsub("%s+$", "")
				if cleaned ~= line then
					lines[i] = cleaned
					changed = true
				end
			end
		end

		if changed then
			vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
		end

		vim.fn.winrestview(view)
	end,
})


-- Utilities
-- ----------------------------------------

-- Show active language servers
vim.api.nvim_create_user_command("LspList", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	if #clients == 0 then
		print("No LSPs attached to this buffer.")
		return
	end

	for _, client in ipairs(clients) do
		print("• " .. client.name)
	end
end, {})


-- Reveal current file in macOS Finder
if vim.fn.has("macunix") == 1 then
	vim.api.nvim_create_user_command("Rfinder", function()
		local path = vim.api.nvim_buf_get_name(0)

		if path ~= "" then
			vim.fn.jobstart({ "open", "-R", path }, { detach = true })
		end
	end, {})
end
