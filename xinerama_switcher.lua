-- xinerama_switcher.lua
-- 
-- Goes to the frame in the specified direction. If there is no frame in the
-- given direction (the user is trying to move off the edge of the screen), it
-- switches workspace or screen. I assume that left/right switch between
-- screens, since xinerama displays are usually next to each other. Up/down,
-- on the other hand switch between workspaces. For me, the next workspace is
-- down as if I was reading a webpage.
--
-- The following keybindings may be useful:
--
--defbindings("WIonWS", {
--    kpress(MOD1.."Up", "xinerama_switcher_up(_)"),
--    kpress(MOD1.."Down", "xinerama_switcher_down(_)"),
--    kpress(MOD1.."Right", "xinerama_switcher_right(_)"),
--    kpress(MOD1.."Left", "xinerama_switcher_left(_)"),
--})
--
-- Based on go_desk_or_desk lua by Rene van Bevern <rvb@pro-linux.de>, 2005
--
-- This script is (c) copyright 2005 by martin f. krafft <madduck@madduck.net>
-- and released under the terms of the Artistic Licence.
--
-- Version 2005.08.14.1515
-- 
-- TODO: prevent switching screens when there is none on that side. E.g.
-- moving off the left edge of the left screen should either do nothing or
-- wrap to the right side of the right screen. This likely needs
-- a configuration file which would also solve the problem about assigning
-- left/right to next/prev according to xinerama configuration.
-- When solving this, don't just solve it for dual-head. :)
--

function xinerama_switcher(region, direction)
    local x = ioncore.navi_next(region, direction, { nowrap = true })
    if x == nil then
        if direction == "left" then
            local newscreen = ioncore.goto_prev_screen()
            if obj_is(newscreen, "WRootWin") then
                newscreen = ioncore.goto_next_screen()
            end
            newscreen:current():current():farthest('right'):goto()
        elseif direction == "right" then
            local newscreen = ioncore.goto_next_screen()
            if obj_is(newscreen, "WRootWin") then
                newscreen = ioncore.goto_prev_screen()
            end
            newscreen:current():current():farthest('left'):goto()
        end
    else
        ioncore.goto_next(region, direction)
    end
end

-- helper functions for easier keybindings (see top of the file)

function xinerama_switcher_left(reg)
    xinerama_switcher(reg, 'left')
end

function xinerama_switcher_right(reg)
    xinerama_switcher(reg, 'right')
end
