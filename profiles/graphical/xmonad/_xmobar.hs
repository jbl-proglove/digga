Config { position = Top
        , font     = "xft:FuraCode Nerd Font:size=14:bold:antialias=true"
--        , fgColor = "#6d6e7a"
        , fgColor = "#2e3440"
--        , bgColor = "#282a36"
        , bgColor = "#d8dee9"
        , lowerOnStart = False
--        , bgColor = "#dadbd7"
--        , border = BottomB
        , borderColor = "#dadbd7",
--        , borderWidth = 2,
        , alpha = 200  -- 0 transparent, 255 opaque
        , sepChar = "%"
        , alignSep = "}{"
        , allDesktops = True
--        , template = "  <fc=#ff0000></fc>  | %StdinReader% } %time% { %battery% |  %cpu% |  %memory% |   %disku% | 直 %wlp2s0wi%  %enp0s31f6% |  %alsa:HDA Intel PCH:Master% ﱘ %alsa:AudioQuest DragonFly Cobalt v1.:PCM% |  %kbd%  <fc=#fffa4c>%date%</fc>         "
        , template = " <fc=#eeeeee></fc><fc=#ff2233></fc><fc=#7ebae4></fc> %StdinReader% } %time% { %battery% <fc=#7ebae4>|</fc> <fc=#ecbe7b> %cpu%</fc> <fc=#7ebae4>|</fc> <fc=#ff6c6b> %memory%</fc> <fc=#7ebae4>|</fc> <fc=#51afef> %disku%</fc> <fc=#7ebae4>|</fc> <fc=#98be65>直 %wlp2s0wi%  %enp0s31f6%</fc> | <fc=#c678dd>%default:Master%</fc> <fc=#7ebae4>|</fc> <fc=#c678dd> %kbd%</fc>    <fc=#46d9ff>%date%</fc> "
        , commands = [ Run StdinReader
                      -- Date formatting
                    , Run Date "%_H:%M<fc=#aaaaaa> %S</fc>" "time" 10 -- every 1s
                    , Run Date "%a %_d.%b" "date" 100 -- every 10s
                    -- CPU core temperature
                    , Run CoreTemp [ "--template" , "<core0>/<core1>°C"
                                    , "--Low"      , "70"
                                    , "--High"     , "80"
                                    , "--low"      , "#33BB33"
                                    , "--normal"   , "#AA8800"
                                    , "--high"     , "#FF0000"
                                    ] 50 -- every 5s

                    -- Gather and format CPU usage information.
                    -- If it's above 50%, we consider it high usage and make it red.
                    , Run Cpu [ "-t", "<total>%"
                                , "-H","50"
                                , "--high","red"
                    ] 10

                    , Run Kbd [("de", "DE"), ("us", "US")]

                    -- als mixer: %alsa:default:Master%
--                    , Run Volume "default" "Master" [ ] 50
                    , Run Volume "default" "Master" [ "--template", "<status> <volume>%"
                                                      , "--"
                                                      , "-O", ""
                                                      , "-o", "婢"
                                                    ] 50
                    , Run Volume "AudioQuest DragonFly Cobalt v1." "PCM" [ "--template", "<volume>% <status>"
                                                                          , "-O", "ﱙ"
                                                                          , "-o", "ﱘ"
                                                                          ] 100

                    -- network activity monitor (dynamic interface resolution)
                    , Run DynNetwork [ "--template" , "<tx><rx>"
                                      , "--Low"      , "1000000" -- units: B/s
                                      , "--High"     , "5000000" -- units: B/s
                                      , "--low"      , "green"
                                      , "--normal"   , "orange"
                                      , "--high"     , "red"
                                      , "--minwidth" , "5"
                                    ] 10

                    , Run Network "enp0s31f6" [ "--template" , "<tx> <rx>"
                                      , "--suffix" , "True"
                                      , "--minwidth", "6"
                                    ] 10

                    -- network activity monitor (dynamic interface resolution)
                    , Run Wireless "wlp2s0" [ "--template", "<quality>%" ] 10

                    , Run DiskU [
                            ("/", "<free>")
                        ]
                        [
                            "-L" , "20"
                          , "-H" , "50"
                          , "-m", "1"
                          , "-p", "3"
                        ] 20

                      -- Gather and format memory usage information
                    , Run Memory [
                        "-t","<usedratio>%"
                      ] 10

                    -- Battery information. This is likely to require some customization
                    -- based upon your specific hardware. Or, for a desktop you may want
                    -- to just remove this section entirely.
                    , Run Battery [ "-t", "<fc=#b3afc2><acstatus> <left>%</fc>"
                                    , "--"
                                    , "-O", "<fc=#98e036></fc>"
                                    , "-o", "<fc=#ff645a></fc>"
                                    , "-i", "<fc=#5fdaff></fc>"
                                    , "-h", "green"
                                    , "-l", "red"
                                  ] 10
                  ]
        }

