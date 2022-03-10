local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	if server.name == "jsonls" then
		local jsonls_opts = require("lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("keep", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("keep", sumneko_opts, opts)
	end

	if server.name == "tsserver" then
		local tsserver_opts = require("lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("keep", tsserver_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	server:setup(opts)
end)
