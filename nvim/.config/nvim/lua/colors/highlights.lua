local c = require("colors").get()

hl("SpellBad", {
  link = "Error",
})

-- same it bg, so it doesn't appear
hl("EndOfBuffer", { fg = c.black })

-- For floating windows
hl("FloatBorder", { fg = c.blue })
hl("NormalFloat", { bg = c.darker_black })

-- Pmenu
hl("Pmenu", { bg = c.one_bg })
hl("PmenuSbar", { bg = c.one_bg2 })
hl("PmenuSel", { bg = c.pmenu_bg })
hl("PmenuThumb", { bg = c.nord_blue })

-- hl("LineNr", { fg = c.grey })
-- hl("NvimInternalError", { fg = c.red })
-- hl("VertSplit", { fg = c.one_bg2 })

-- cmp
hl("CmpBorder", { fg = c.grey })
hl("CmpDocBorder", { fg = c.grey })
hl("CmpBg", { bg = "NONE" })

-- Git signs
hl("DiffAdd", { fg = c.blue, bg = "NONE" })
hl("DiffChange", { fg = c.grey_fg, bg = "NONE" })
hl("DiffChangeDelete", { fg = c.red, bg = "NONE" })
hl("DiffModified", { fg = c.red, bg = "NONE" })
hl("DiffDelete", { fg = c.red, bg = "NONE" })

-- Telescope
hl("TelescopeBorder", { fg = c.darker_black, bg = c.darker_black })
hl("TelescopePromptBorder", { fg = c.black2, bg = c.black2 })
hl("TelescopePromptNormal", { fg = c.white, bg = c.black2 })
hl("TelescopePromptPrefix", { fg = c.red, bg = c.black2 })
hl("TelescopeNormal", { bg = c.darker_black })
hl("TelescopePreviewTitle", { fg = c.black, bg = c.green })
hl("TelescopePromptTitle", { fg = c.black, bg = c.red })
hl("TelescopeResultsTitle", { fg = c.darker_black, bg = c.darker_black })
hl("TelescopeSelection", { bg = c.black2 })

-- hl("NvimTreeNormal", { bg = "NONE" })
-- hl("NvimTreeNormalNC", { bg = "NONE" })
-- hl("NvimTreeStatusLineNC", { bg = "NONE" })
-- hl("NvimTreeVertSplit", { fg = c.grey, bg = "NONE" })

hl("FidgetTask", { bg = "NONE" })

-- hl("Normal", { bg = "NONE" })
-- hl("NormalFloat", { bg = "NONE" })
-- hl("Folded", { bg = "NONE", fg = "NONE" })
