return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "day", -- options: "night", "storm", "day", "moon"
			transparent = true,
		},
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = "wave", -- options: "wave", "dragon", "lotus", "paper"
			transparent = false,
		},
	},

	{ "rose-pine/neovim", name = "rose-pine", priority = 1000 },
	--  latte  frappe  macchiato mocha

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Ensure it loads first
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
