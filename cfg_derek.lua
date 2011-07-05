
dopath("app")
dopath("xinerama_switcher")
dopath("move_current")
dopath("move_app_here")
dopath("bookmarking")
--dopath("min_tabs")

function goto_specific_by_name(name, regionType)
    local region = ioncore.lookup_region(name, regionType)
    if region then
        region:goto()
    end
end

function toggle_tab_bar(frame)
    local mode = frame:mode()
    if mode == "tiled" then
        frame:set_mode('tiled-alt')
    else
        frame:set_mode('tiled')
    end
end

CTRL="Control+"
META="Mod1+"

defbindings("WMPlex.toplevel", {
    kpress("F2", "ioncore.exec_on(_, 'gnome-terminal')"),
    kpress(CTRL.."F4", "ioncore.exec('xstart')"),
    kpress("F5", "mod_query.query_workspace(_)"),
    kpress("F6", "ioncore.create_ws(_)"),
    kpress("F8", "ioncore.exec_on(_, 'xlock -mode blank')"),
    kpress("F9", "ioncore.exec_on(_, 'downvol')"),
    kpress("F10", "ioncore.exec_on(_, 'upvol')"),
    kpress("F11", "ioncore.exec_on(_, 'togglemute')"),
    kpress("F12", "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"),
    submap(CTRL.."K", {
       kpress("R", "ioncore.restart()"),
       kpress("G", "app.byclass('gvim', 'Gvim')"),
       kpress("T", "toggle_tab_bar(_)"),
       kpress("f", "app.byclass('firefox -P default', 'Firefox')"),
       kpress("O", "app.byclass('vmplayer \"/disk2/WindowsXPSP2/Windows XP Professional.vmx\"', 'Vmplayer')"),
       kpress("1", "bookmark.goto_bookmark('1')"),
       kpress("2", "bookmark.goto_bookmark('2')"),
       kpress("3", "bookmark.goto_bookmark('3')"),
       kpress("4", "bookmark.goto_bookmark('4')"),
       kpress("5", "bookmark.goto_bookmark('5')"),
       kpress("6", "bookmark.goto_bookmark('6')"),
       kpress("plus", "WMPlex.inc_index(_)"),
       kpress("minus", "WMPlex.dec_index(_)"),
    })
})

defbindings("WScreen", {
    kpress(CTRL.."F4", "mine(_)"),
    submap(CTRL.."K", {
        kpress("Return", "WScreen.switch_next(_)"),
    }),
    submap(CTRL.."semicolon", {
        kpress("G", "goto_specific_by_name('Vim',        'WSGroup')"),
        kpress("F", "goto_specific_by_name('Firefox',    'WSGroup')"),
        kpress("1", "goto_specific_by_name('Terminals1', 'WSGroup')"),
        kpress("2", "goto_specific_by_name('Terminals2', 'WSGroup')"),
    }),
})

defbindings("WClientWin", {
    submap(CTRL.."K", {
       kpress("Q", "WClientWin.kill(_)"),
       kpress("semicolon", "WClientWin.quote_next(_)"),
       submap("B", {
           kpress("1", "bookmark.set_bookmark('1', _)"),
           kpress("2", "bookmark.set_bookmark('2', _)"),
           kpress("3", "bookmark.set_bookmark('3', _)"),
           kpress("4", "bookmark.set_bookmark('4', _)"),
           kpress("5", "bookmark.set_bookmark('5', _)"),
           kpress("6", "bookmark.set_bookmark('6', _)"),
       }),
    })
})

defbindings("WGroup", {
    submap(CTRL.."K", {
        kpress_wait("space", "WGroup.set_fullscreen(_, 'toggle')"),
    }),
})

defbindings("WFrame", {
    submap(CTRL.."K", {
        kpress("K", "ioncore.goto_next(_, 'up')"),
        kpress("L", "xinerama_switcher(_, 'right')"),
        kpress("H", "xinerama_switcher(_, 'left')"),
        kpress("J", "ioncore.goto_next(_, 'down')"),
        kpress("N", "WFrame.switch_next(_)"),
        kpress("M", "WFrame.switch_prev(_)"),
    }),
    mdrag(META.."Button1", "WFrame.p_resize(_)"),
})

defbindings("WTiling", {
    submap(CTRL.."K", {
        kpress("V", "WTiling.split_at(_, _sub, 'right', true)"),
        kpress("S", "WTiling.split_at(_, _sub, 'bottom', true)"),
        kpress("X", "WTiling.unsplit_at(_, _sub)"),
        kpress("Up", "move_current.move(_, 'up')"),
        kpress("Down", "move_current.move(_, 'down')"),
        kpress("Left", "move_current.move(_, 'left')"),
        kpress("Right", "move_current.move(_, 'right')"),
        submap("Z", {
            kpress("F", "moveapp.byclass(_, 'Firefox')"),
            kpress("G", "moveapp.byclass(_, 'Gvim')"),
            kpress("1", "bookmark.move_here(_, '1')"),
            kpress("2", "bookmark.move_here(_, '2')"),
            kpress("3", "bookmark.move_here(_, '3')"),
            kpress("4", "bookmark.move_here(_, '4')"),
            kpress("5", "bookmark.move_here(_, '5')"),
            kpress("6", "bookmark.move_here(_, '6')"),
        })
    })
})

defwinprop {
    class = "Pinentry-gtk-2",
    float = true,
}

defwinprop {
    class = "Firefox",
    role = "Manager",
    instance = "Download",
    float = true,
}

defwinprop {
    class = "Firefox",
    instance = "Navigator",
    target = "Firefox",
}

defwinprop {
    class = "Vmplayer",
    instance = "vmplayer",
    target = "Firefox",
}

defwinprop {
    class = "Gvim",
    instance = "gvim",
    target = "Terminals1-Left",
    jumpto = true,
    switchto = true,
}

defwinprop {
    class = "Gnome-terminal",
    instance = "gnome-terminal",
    role = "Terminals2-Left",
    target = "Terminals2-Left",
}

defwinprop {
    class = "Gnome-terminal",
    instance = "gnome-terminal",
    role = "Terminals2-UpperRight",
    target = "Terminals2-UpperRight",
}

defwinprop {
    class = "Gnome-terminal",
    instance = "gnome-terminal",
    role = "Terminals2-LowerRight",
    target = "Terminals2-LowerRight",
}

defwinprop {
    class = "Gnome-terminal",
    instance = "gnome-terminal",
    role = "Terminals1-Left",
    target = "Terminals1-Left",
}

defwinprop {
    class = "Gnome-terminal",
    instance = "gnome-terminal",
    role = "Terminals1-UpperRight",
    target = "Terminals1-UpperRight",
}

defwinprop {
    class = "Gnome-terminal",
    instance = "gnome-terminal",
    role = "Terminals1-LowerRight",
    target = "Terminals1-LowerRight",
}

defwinprop {
    name = "Desktop Alert - [WinXPSP2]",
    class = "Microsoft Office Outlook",
    instance = "Microsoft Office Outlook.VMwareUnityWindow",
    float = true,
}

defwinprop {
    name = "T2L",
    target = "Terminals2-Left",
}

defwinprop {
    name = "T2UR",
    target = "Terminals2-UpperRight",
}

defwinprop {
    name = "T2LR",
    target = "Terminals2-LowerRight",
}

defwinprop {
    name = "T1L",
    target = "Terminals1-Left",
}

defwinprop {
    name = "T1LR",
    target = "Terminals1-LowerRight",
}

defwinprop {
    name = "T1UR",
    target = "Terminals1-UpperRight",
}

