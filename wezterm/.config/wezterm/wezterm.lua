local wezterm = require("wezterm")

return {
  font = wezterm.font("JetBrainsMono NF", { weight = "Medium" }),
  font_size = 11.0,
  freetype_load_flags = "NO_HINTING",
  window_background_opacity = 1.0,
  enable_tab_bar = false,
  bidi_enabled = true,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  bold_brightens_ansi_colors = "No",
  colors = {
    foreground = "#c5c9c5",
    background = "#181616",

    cursor_bg = "#c8c093",
    cursor_fg = "#181616",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = {
      "#0d0c0c",
      "#c4746e",
      "#8a9a7b",
      "#c4b28a",
      "#8ba4b0",
      "#a292a3",
      "#8ea4a2",
      "#c8c093",
    },
    brights = {
      "#a6a69c",
      "#e46876",
      "#87a987",
      "#e6c384",
      "#7fb4ca",
      "#938aa9",
      "#7aa89f",
      "#c5c9c5",
    },
    indexed = { [16] = "#b6927b", [17] = "#b98d7b" },
  },
}
