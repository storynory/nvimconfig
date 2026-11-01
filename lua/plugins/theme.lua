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


	{ "rose-pine/neovim", name = "rose-pine", priority = 1000 },
	--  latte  frappe  macchiato mocha

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Ensure it loads first
		config = function()
			--	vim.cmd.colorscheme("catppuccin")
		end,
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

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = "wave", -- options: "wave", "dragon", "lotus", "paper"
			transparent = false,
		},
		config = function(_, opts)
			-- This sets up the configuration options provided in 'opts' above
			require("kanagawa").setup(opts)

			-- This actively loads the colorscheme into Neovim
			vim.cmd("colorscheme kanagawa")
		end,
	}

}
