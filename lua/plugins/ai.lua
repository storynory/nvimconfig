return {
	{
		"robitx/gp.nvim",
		config = function()
			require("gp").setup({
				-- Standard setups require these placeholders to silence internal runtime checks
				openai_api_key = "not_needed_locally",

				providers = {
					openai = {
						endpoint = "http://hughs-macbook-air.local",
						secret = "not_needed_locally",
					},
				},

				-- Define your custom local M2 agent profile
				agents = {
					{
						name = "LocalQwen",
						chat = true,
						command = true,
						model = { model = "qwen", temperature = 0.7 },
						system_prompt =
						"You are a helpful frontend web developer specializing in Svelte and HTML.",
					},
				},
			})
		end,
	}
}
