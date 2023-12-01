local wezterm = require 'wezterm'

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
    local names = {name, 'FiraCode Nerd Font', 'Fira Code', 'Cascadia Code', 'Noto Sans CJK SC', 'Monospace'}
    return wezterm.font_with_fallback(names, params)
end

return {
    -- Appearance

    hide_tab_bar_if_only_one_tab = true,

    -- Font

    warn_about_missing_glyphs = false,
    font_size = 11.0,
    -- allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    font = font_with_fallback("CaskaydiaCove Nerd Font"),

    -- Global

    -- bold_brightens_ansi_colors = true,

    color_scheme = "Dracula (Official)",

    tab_bar_at_bottom = true,
    window_background_opacity = 0.98,
    -- text_background_opacity = 1.0,
    
    -- window_close_confirmation = "NeverPrompt",
    -- exit_behavior = "Close",
}
