return {
  {
    "nvim-mini/mini.icons",
    opts = function(_, opts)
      opts.extension = opts.extension or {}
      opts.extension["component.ts"] = { glyph = "󰚲", hl = "MiniIconsBlue" }
      opts.extension["service.ts"] = { glyph = "󰚲", hl = "MiniIconsYellow" }
    end,
  },
}
