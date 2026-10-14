local languages = {
	"html",
	"svelte",
	"javascript",
	"css",
	"typescript",
	"tsx",
	"json",
	"markdown",
	"markdown_inline",
	"lua",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.setup({})

			treesitter.install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")

			local mappings = {
				af = "@function.outer",
				["if"] = "@function.inner",
				ac = "@conditional.outer",
				ic = "@conditional.inner",
				at = "@tag.outer",
				it = "@tag.inner",
			}

			for key, query in pairs(mappings) do
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(query, "textobjects")
				end)
			end
		end,
	},
}
