-- 1. Tell your Lua LSP that 'Snacks' is a globally expected module in this file
---@diagnostic disable: undefined-global

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		indent = { enabled = true },
		scope = { enabled = true },
		picker = { enabled = true },
		explorer = { enabled = true }, -- Crucial for the explorer to work
		image = {
			enabled = true,
			doc = {
				enabled = true,
				inline = true,
				float = true,
				max_width = 90,
				max_height = 45,
				conceal = function(lang, type)
					return type == "math"
				end,
			},
			debug = { request = false, convert = false, placement = false },
		},
		notifier = { enabled = true, timeout = 2500 },
		debug = { enabled = true },
		terminal = { enabled = true },
		lazygit = { enabled = true },
	},

	-- 2. Flattened standard lazy.nvim key table
	keys = {
		-- Picker Muscle-Memory
		{ "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find files" },
		{ "<leader>fg", function() Snacks.picker.grep() end,                                    desc = "Grep" },
		{ "<leader>fw", function() Snacks.picker.grep_word() end,                               desc = "Grep word under cursor" },
		{ "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
		{ "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent files" },

		-- Help / Discovery
		{ "<leader>fh", function() Snacks.picker.help() end,                                    desc = "Help tags" },
		{ "<leader>fk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
		{ "<leader>fc", function() Snacks.picker.commands() end,                                desc = "Commands" },

		-- Jump straight into your config folder
		{ "<leader>fe", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Edit Neovim config" },

		{
			"<leader>e",
			function()
				Snacks.picker.explorer({
					jump = { current = true }
				})
			end,
			desc = "File explorer (Current Window)"
		},

		-- Git & Debug Utilities;
		{ "<leader>gg", function() Snacks.lazygit() end,         desc = "Lazygit" },
		{ "<leader>di", function() Snacks.debug.inspect() end,   desc = "Debug: inspect" },
		{ "<leader>dt", function() Snacks.debug.backtrace() end, desc = "Debug: backtrace" },
		{ "<leader>ip", function() Snacks.image.pick() end,      desc = "Image: pick/preview" },
		{ "<leader>ii", function() Snacks.image.toggle() end,    desc = "Image: toggle inline" },
	},

	config = function(_, opts)
		-- 3. Explicitly load global allocation immediately upon plugin setup
		_G.Snacks = require("snacks")
		_G.Snacks.setup(opts)

		-- YAML list enhancement helper
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "yaml", "yml" },
			callback = function()
				vim.opt_local.list = true
				vim.opt_local.listchars:append("tab:»·")
			end,
		})
	end,
}
