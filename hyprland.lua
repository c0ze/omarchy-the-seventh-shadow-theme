-- The Seventh Shadow: the border colors that colors.toml would generate, plus one thing a palette cannot say:
-- the active window's vein-to-gold gradient turns slowly round the frame (one turn in 10 s, the slowest Hyprland allows).
-- Written by hand, so it replaces the generated hyprland.lua; keep the two colors in step with colors.toml.
local active_border_color = { colors = { "rgba(6fd3f0ee)", "rgba(b08d57ee)" }, angle = 45 }
local inactive_border_color = "rgba(3a4046aa)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
})

hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })
