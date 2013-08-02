--
-- Ion statusbar module configuration file
-- 

dopath("statusbar_fname")

-- Create a statusbar
mod_statusbar.create {
    -- First screen, bottom left corner
    screen=0,
    pos='bl',
    -- Set this to true if you want a full-width statusbar
    fullsize=true,
    -- Swallow systray windows
    systray=true,

    -- Template. Tokens %string are replaced with the value of the 
    -- corresponding meter. Currently supported meters are:
    --   date          date
    --   load          load average (1min, 5min, 15min)
    --   load_Nmin     N minute load average (N=1, 5, 15)
    --   mail_new      mail count (mbox format file $MAIL)
    --   mail_unread   mail count
    --   mail_total    mail count
    --   mail_*_new    mail count (from an alternate mail folder, see below)
    --   mail_*_unread mail count
    --   mail_*_total  mail count
    --
    -- Space preceded by % adds stretchable space for alignment of variable
    -- meter value widths. > before meter name aligns right using this 
    -- stretchable space , < left, and | centers.
    -- Meter values may be zero-padded to a width preceding the meter name.
    -- These alignment and padding specifiers and the meter name may be
    -- enclosed in braces {}.
    --
    -- %filler causes things on the marker's sides to be aligned left and
    -- right, respectively, and %systray is a placeholder for system tray
    -- windows and icons.
    --
    template="[ %date ] [ uptime: %uptime load: %load ] cpu:[ user:%cpustat_user sys:%cpustat_system idle:%cpustat_idle ] mem:[ u:%meminfo_mem_used f:%meminfo_mem_free c:%meminfo_mem_cached ] swap:[ u:%meminfo_swap_used f:%meminfo_swap_free ] %filler %systray_dock",
    --template="[ %date || load:% %>load || mail:% %>mail_new/%>mail_total ] %filler%systray",
    --template="[ %date || load: %05load_1min || mail: %02mail_new/%02mail_total ] %filler%systray",
}


-- Launch ion-statusd. This must be done after creating any statusbars
-- for necessary statusd modules to be parsed from the templates.
mod_statusbar.launch_statusd{
    -- Date meter
    date={
        -- ISO-8601 date format with additional abbreviated day name
        date_format='%a %m/%d %H:%M',
        -- Finnish etc. date format
        --date_format='%a %d.%m.%Y %H:%M',
        -- Locale date format (usually shows seconds, which would require
        -- updating rather often and can be distracting)
        --date_format='%c',
        
        -- Additional date formats. 
        --[[ 
        formats={ 
            time = '%H:%M', -- %date_time
        }
        --]]
    },      

    -- Load meter
    load={
        --update_interval=10*1000,
        --important_threshold=1.5,
        --critical_threshold=4.0,
    },

    -- Weather
    weather={
        update_interval=5*60*1000,
        station=CYKF,
    },

    --df={
    --    fslist = { "/", "/disk2" },
    --    separator = " ",
    --    template = "(%mpoint) %availp free",
    --},

    cpustat={
        update_interval = 5000,
    },

    meminfo={
        update_interval = 10 * 1000,
    },

    uptime={
    },

    volume={
    },
}

