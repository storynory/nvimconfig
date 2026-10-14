-- Leaders MUST be set first
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.nvim_dir_plugin = 1

vim.g.have_nerd_font = true

-- Load Lazy BEFORE anything else
require("config.lazy")


vim.opt.clipboard = ""

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })

-- Load your config AFTER Lazy initialises plugin paths
require("config.options")
require("config.autocmds")
require("config.keymaps") -- optional
require("config.lsp")
require("config.snips")
