vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.html",
	callback = function()
		vim.cmd("0r ~/.config/nvim/templates/skeleton.html")
	end,
})
