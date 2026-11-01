local M = {}

require('blink.cmp').get_lsp_capabilities()


vim.lsp.config("harper_ls",
	{

		filetypes = { "markdown" },
		settings = {
			["harper-ls"] = {
				linters = {
					-- 	SentenceCapitalization = false,
					SpellCheck = false,
					PossessiveNoun = true,
					NoOxfordComma = true,
					BoringWords = true,
					UseGenitive = true,

				}
			}
		}

	}


)


-- disable semanticTokens
M.on_init = function(client, _)
	if vim.fn.has "nvim-0.11" ~= 1 then
		if client.supports_method "textDocument/semanticTokens" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	else
		if client:supports_method "textDocument/semanticTokens" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end
end

-- Add keymaps for LSP buffers
function M.on_attach(_, bufnr)
	local map = function(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
	end

	map("n", "gd", vim.lsp.buf.definition)
	map("n", "gD", vim.lsp.buf.declaration)
	map("n", "gi", vim.lsp.buf.implementation)
	map("n", "gr", vim.lsp.buf.references)
	map("n", "K", vim.lsp.buf.hover)

	map("n", "<leader>rn", vim.lsp.buf.rename)
	map("n", "<leader>ca", vim.lsp.buf.code_action)

	map("n", "[d", vim.diagnostic.goto_prev)
	map("n", "]d", vim.diagnostic.goto_next)
	map("n", "<leader>fd", vim.diagnostic.open_float)
end

return M
