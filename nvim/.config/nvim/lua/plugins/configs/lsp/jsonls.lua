return {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    -- client.server_capabilities.documentFormattingProvider = false
    -- client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
}
