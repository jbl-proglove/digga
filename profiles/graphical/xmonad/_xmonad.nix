{ autostart, screenshots, pkgs, stoggle }:
let inherit (pkgs) alsaUtils;
in
''
  -- Function for fullscreen toggle
  fullToggle :: X ()
  fullToggle = do
    spawn "${stoggle}"
    sendMessage $ Toggle "Full"
    -- sendMessage $ ToggleStruts
    -- sendMessage $ JumpToLayout "Full"
    -- toggleScreenSpacingEnabled
    -- toggleWindowSpacingEnabled
    -- sendMessage $ SetStruts [] [minBound .. maxBound]

  setVolume :: String -> X ()
  setVolume options = do
    spawn ("${alsaUtils}/bin/amixer -q set Master " ++ options)

  myAutostart :: X ()
  myAutostart = do
  --    spawn "${autostart}"
    spawn "feh --bg-fill --no-fehbg /etc/wallpapers/wallpaper-wallhaven-moon.jpg"
    setWMName "LG3D"
    spawn "autorandr --change"
    -- sendMessage $ SetStruts [] [minBound .. maxBound]
    setDefaultCursor xC_left_ptr

  -- Set custom keybinds below following the structure:
  -- ( ( ModifierKey, KeyPress ), Action )
  myKeys :: [ ( ( KeyMask, KeySym ), X () ) ]
  myKeys =
    -- toggle fullscreen, along with power state
    [ ( ( myModKey                              , xK_f                    )
      , fullToggle
      )
    -- resize windows in master pane
    , ( ( myModKey                              , xK_Left                 )
      , sendMessage MirrorExpand
      )
    , ( ( myModKey                              , xK_Right                )
      , sendMessage MirrorShrink
      )
    , ( ( myModKey                              , xK_Up                   )
      , sendMessage MirrorExpand
      )
    , ( ( myModKey                              , xK_Down                 )
      , sendMessage MirrorShrink
      )
    -- toggle systray
    , ( ( myModKey .|. shiftMask                , xK_f                    )
      , sendMessage ToggleStruts
      )
    -- rofi pass
    , ( ( myModKey                              , xK_r                    )
      , spawn "gopass ls --flat | rofi -dmenu -p gopass | xargs --no-run-if-empty gopass show -o | head -n 1 | xdotool type --clearmodifiers --file -"
      )
    -- rofi app launcher
    , ( ( myModKey                              , xK_p                    )
      , spawn "rofi -show run"
      )
    -- lower volume
    , ( ( 0                                     , xF86XK_AudioLowerVolume )
      , setVolume "2%- unmute"
      )
    -- raise volume
    , ( ( 0                                     , xF86XK_AudioRaiseVolume )
      , setVolume "2%+ unmute"
      )
    -- mute volume
    , ( ( 0                                     , xF86XK_AudioMute        )
      , setVolume "toggle"
      )
    -- start qutebrowser
    , ( ( myModKey                              , xK_b                    )
      , spawn "qute"
      )
    -- screen lock
    , ( ( myModKey                              , xK_l                    )
      , spawn "slock"
      )
    -- select monitor setup that was detected - TODO replace with menu
    , ( ( myModKey                              , xK_d                    )
      , spawn "autorandr -l laptop"
      )
    -- select monitor setup laptop - TODO replace with menu
    , ( ( myModKey .|. shiftMask                , xK_d                    )
      , spawn "autorandr -c"
      )
    -- Tree Select/
    -- tree select actions menu
    --, ("C-t a", treeselectAction tsDefaultConfig)
    -- tree select workspaces menu
    , ( ( myModKey                             , xK_t                    )
      , TS.treeselectWorkspace tsDefaultConfig myWorkspaces S.greedyView
      )
    -- tree select choose workspace to send window
    --, ("C-t g", TS.treeselectWorkspace tsDefaultConfig myWorkspaces W.shift)
    -- screenshot
    , ( ( myModKey                              , xK_Print                )
      , spawn "maim -u \
        \ | png2ff | xz -9 - \
        \ > ~/${screenshots}/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
      )
    -- screenshot focused window
    , ( ( myModKey .|. shiftMask                , xK_Print                )

      , spawn "maim -u -i$(xdotool getactivewindow) \
        \ | png2ff \
        \ | xz -9 - \
        \ > ~/${screenshots}/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
      )
    -- screenshot selection to clipboard
    , ( ( myModKey .|. controlMask              , xK_Print                )

      , spawn "maim -s -u \
        \ | xclip -selection clipboard -t image/png"
      )
    -- screenshot selection file
    , ( ( myModKey .|. controlMask .|. shiftMask, xK_Print                )

      , spawn "maim -s -u \
        \ | png2ff \
        \ | xz -9 - \
        \ > ~/${screenshots}/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
      )
    -- screenshot selection to imgur and paste url in clipboard
    , ( ( myModKey .|. shiftMask                , xK_i                    )

      , spawn "maim -s -u /tmp/img.png; \
        \ imgurbash2 /tmp/img.png; \
        \ rm /tmp/img.png"
      )
    -- dmenu frontend for network manager
    , ( ( myModKey                              , xK_n                    )
      , spawn "networkmanager_dmenu -fn 'monospace'"
      )
    ]
''
