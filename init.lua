-- Leaders MUST be set first
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Load Lazy BEFORE anything else
require("config.lazy")



-- Load your config AFTER Lazy initialises plugin paths
require("config.options")
require("config.autocmds")
require("config.keymaps") -- optional
require("config.lsp")
