return {
	"catgoose/nvim-colorizer.lua",
	opts = {
		filetypes = {
			"css",
			"scss",
			"html",
			"svelte",
			"yaml",
			"yml"
		},
		options = {
			parsers = {
				css = true,
			},
			display = {
				mode = "virtualtext",
				virtualtext = {
					position = "after",
				},
			},
		},
	},
}
