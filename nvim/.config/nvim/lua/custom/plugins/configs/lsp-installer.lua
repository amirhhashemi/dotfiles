vim.diagnostic.config {
   virtual_text = false,
   signs = true,
   underline = true,
   update_in_insert = false,
}

local M = {}

M.setup_lsp = function(attach, capabilities)
   local lsp_installer = require "nvim-lsp-installer"

   local servers = {
      "tsserver",
      "cssls",
      "html",
      "jsonls",
      "eslint",
      "prismals",
      "tailwindcss",
      "rust_analyzer",
      "sumneko_lua",
   }

   for _, name in pairs(servers) do
      local server_is_found, server = lsp_installer.get_server(name)
      if server_is_found and not server:is_installed() then
         print("Installing " .. name)
         server:install()
      end
   end

   lsp_installer.settings {
      ui = {},
   }

   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
         settings = {},
      }

      if server.name == "tsserver" then
         local tsserver_opts = require "custom.lsp.tsserver"
         opts = vim.tbl_deep_extend("force", opts, tsserver_opts)
      end

      if server.name == "jsonls" then
         local tsserver_opts = require "custom.lsp.jsonls"
         opts = vim.tbl_deep_extend("force", opts, tsserver_opts)
      end

      if server.name == "sumneko_lua" then
         local sumneko_opts = require "custom.lsp.sumneko"
         opts = vim.tbl_deep_extend("keep", sumneko_opts, opts)
      end

      server:setup(opts)
      vim.cmd [[ do User LspAttachBuffers ]]
   end)
end

return M
