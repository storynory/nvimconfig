return {
	{
		'saghen/blink.cmp',
		version = '1.*',
		opts = {
			keymap = {
				['<Tab>'] = { 'accept', 'fallback' },
				['<C-n>'] = { 'select_next' },
				['<C-p>'] = { 'select_prev' },
				['<C-Space>'] = { 'show' },
			},

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 300,
					window = { border = 'single' },
				},
			},

			signature = { enabled = true },
		},
	},
}
