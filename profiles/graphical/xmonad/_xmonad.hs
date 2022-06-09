import           Control.Monad
import           Data.Monoid
import           Data.Tree
import           Data.Ratio                          ((%))
import qualified Data.Map                            as M

import           XMonad

import qualified XMonad.Actions.TreeSelect           as TS

import           XMonad.Core                         (Layout, Query,
                                            ScreenDetail, ScreenId,
                                            WorkspaceId, X)

import qualified XMonad.StackSet                     as S (StackSet, greedyView,
                                                            shift)

import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName

import           Graphics.X11.ExtraTypes.XF86        (xF86XK_AudioLowerVolume,
                                                      xF86XK_AudioMute,
                                                      xF86XK_AudioRaiseVolume)
import           Graphics.X11.Types                  (KeyMask, KeySym, Window)

import           XMonad.Layout.ResizableTile         (ResizableTall(..), MirrorResize (MirrorShrink, MirrorExpand))
import           XMonad.Layout.BinarySpacePartition (emptyBSP)
import           XMonad.Layout.Grid
import           XMonad.Layout.Named
import           XMonad.Layout.IM
-- import           XMonad.Layout.MultiToggle
-- import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import           XMonad.Layout.Spacing
import           XMonad.Layout.NoBorders             (smartBorders, noBorders)
import           XMonad.Layout.PerWorkspace          (onWorkspace)
import           XMonad.Layout.Reflect               (reflectHoriz)
-- import           XMonad                              hiding ( (|||) )  -- don't use the normal ||| operator
-- import           XMonad.Layout.LayoutCombinators     -- use the one from LayoutCombinators instead
-- import           XMonad.Layout.LayoutCombinators     hiding ( (|||) ) -- use the one from LayoutCombinators instead

import           XMonad.Util.EZConfig                (additionalKeys)
import           XMonad.Util.Cursor
import           XMonad.Util.Run

------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------
-- It's nice to assign values to stuff that you will use more than once
-- in the config. Setting values for things like font, terminal and editor
-- means you only have to change the value here to make changes globally.
myFont :: String
myFont = "xft:FuraCode Nerd Font:size=14:regular:antialias=true"


------ workspaces

-- TreeSelect workspaces
myWorkspaces :: Forest String
myWorkspaces = [ Node "dev"
                  [ Node "terminal" []
                  , Node "docs" []
                  , Node "files" []
                  , Node "programming" [
                      Node "python" []
                    , Node "shell" []
                    ]
                  ]
              , Node "web"
                  [ Node "browser" []
                  , Node "chat" []
                  , Node "email" []
                  , Node "rss" []
                  , Node "web conference" []
                  ]
              , Node "graphics"
                  [ Node "gimp" []
                  , Node "image viewer" []
                  ]
              , Node "music"
                  [ Node "audio editor" []
                  , Node "music player" []
                  ]
              , Node "teams" []
              ]

-- Configuration options for treeSelect
tsDefaultConfig :: TS.TSConfig a
tsDefaultConfig = TS.TSConfig { TS.ts_hidechildren = True
                              , TS.ts_background   = 0xdd292d3e
                              , TS.ts_font         = myFont
                              , TS.ts_node         = (0xffd0d0d0, 0xff202331)
                              , TS.ts_nodealt      = (0xffd0d0d0, 0xff292d3e)
                              , TS.ts_highlight    = (0xffffffff, 0xff755999)
                              , TS.ts_extra        = 0xffd0d0d0
                              , TS.ts_node_width   = 200
                              , TS.ts_node_height  = 20
                              , TS.ts_originX      = 0
                              , TS.ts_originY      = 0
                              , TS.ts_indent       = 80
                              , TS.ts_navigate     = myTreeNavigation
                              }

-- Keybindings for treeSelect menus. Use h-j-k-l to navigate.
-- Use 'o' and 'i' to move forward/back in the workspace history.
-- Single KEY's are for top-level nodes. SUPER+KEY are for the
-- second-level nodes. SUPER+ALT+KEY are third-level nodes.
myTreeNavigation = M.fromList
    [ ((0, xK_Escape),   TS.cancel)
    , ((0, xK_Return),   TS.select)
    , ((0, xK_space),    TS.select)
    , ((0, xK_Up),       TS.movePrev)
    , ((0, xK_Down),     TS.moveNext)
    , ((0, xK_Left),     TS.moveParent)
    , ((0, xK_Right),    TS.moveChild)
    , ((0, xK_k),        TS.movePrev)
    , ((0, xK_j),        TS.moveNext)
    , ((0, xK_h),        TS.moveParent)
    , ((0, xK_l),        TS.moveChild)
    , ((0, xK_o),        TS.moveHistBack)
    , ((0, xK_i),        TS.moveHistForward)
    , ((0, xK_d),        TS.moveTo ["com"])
    , ((0, xK_w),        TS.moveTo ["im"])
    , ((0, xK_g),        TS.moveTo ["web"])
    , ((0, xK_m),        TS.moveTo ["aws"])
    , ((0, xK_v),        TS.moveTo ["sys"])
    , ((mod4Mask, xK_b), TS.moveTo ["web", "browser"])
    , ((mod4Mask, xK_c), TS.moveTo ["web", "teams"])
    , ((mod4Mask, xK_m), TS.moveTo ["web", "email"])
    , ((mod4Mask, xK_r), TS.moveTo ["web", "office"])
    , ((mod4Mask, xK_w), TS.moveTo ["web", "web conference"])
    , ((mod4Mask, xK_d), TS.moveTo ["dev", "docs"])
    , ((mod4Mask, xK_p), TS.moveTo ["dev", "programming"])
    , ((mod4Mask, xK_t), TS.moveTo ["dev", "terminal"])
    , ((mod4Mask, xK_g), TS.moveTo ["graphics", "gimp"])
--    , ((mod4Mask .|. altMask, xK_h), TS.moveTo ["dev", "programming", "haskell"])
--    , ((mod4Mask .|. altMask, xK_p), TS.moveTo ["dev", "programming", "python"])
--    , ((mod4Mask .|. altMask, xK_s), TS.moveTo ["dev", "programming", "shell"])
    ]



main = do
  xmobar <- spawnPipe "xmobar /etc/xmobar/xmobarrc"
  xmonad $ docks $ myConfig xmobar

myConfig logHandle = defaultConfig {
    terminal    = "alacritty"
  , modMask     = myModKey
  , startupHook = myAutostart
  , logHook     = myLogHook logHandle
  , layoutHook  = myLayout
  , normalBorderColor = "#2e3440"
  , focusedBorderColor = "#ddaacc"
--   , layoutHook  = mySpacing $ smartBorders $ avoidStruts . mkToggle ( NBFULL ?? EOT) $ ResizableTall ||| Mirror ResizableTall
--  , layoutHook  = mySpacing $ avoidStruts $ layoutHook defaultConfig
  , workspaces         = TS.toWorkspaces myWorkspaces
  , manageHook  = myManageHook
                  <+> manageHook defaultConfig
                  <+> manageDocks
}
  `additionalKeys` myKeys

myLogHook logHandle = dynamicLogWithPP $ xmobarPP {
  ppOutput = hPutStrLn logHandle
}

{-|
The layout hook consists of several parts:
1. smartBorders
2. avoidStruts
3. multiToggle for fullscreen
4. workspace-specific layouts
5. a default layout
myLayout = mySpacing $ smartBorders $ avoidStruts
  . mkToggle ( NBFULL ?? EOT )
  . onWorkspace "7:im" ( half ||| Mirror half ||| tiled ||| reflectHoriz tiled )
  $ tiled ||| reflectHoriz tiled ||| half ||| Mirror half
    where
      tiled     = ResizableTall nmaster delta ratiot []
      half      = ResizableTall nmaster delta ratioh []
      nmaster   = 1
      ratiot    = 309/500
      ratioh    = 1/2
      delta     = 1/9
-}

myLayout = toggleLayouts (noBorders Full) others
  where
    others = avoidStruts $ mySpacing $ ResizableTall 1 (1.5/100) (3/5) [] ||| emptyBSP


mySpacing = spacingRaw False (Border 4 4 4 4) True (Border 4 4 4 4) True
-- mySpacing = smartSpacing 4

-- Move Programs by X11 Class to specific workspaces on opening
-- TODO rework
myManageHook :: Query
  ( Endo
    ( S.StackSet WorkspaceId (Layout Window) Window ScreenId ScreenDetail )
  )
myManageHook = composeAll
  [ className =? "st-256color" --> viewShift "1:main"
  , className =? "qutebrowser" --> viewShift "browser"
  , className =? "Gimp"        --> viewShift "2:art"
  , className =? "krita"       --> viewShift "2:art"
  , className =? "qBittorrent" --> viewShift "3:torrent"
  , className =? "PCSX2"       --> viewShift "5:game"
  , className =? "RPCS3"       --> viewShift "5:game"
  , className =? "mpv"         --> viewShift "6:media"
  , className =? "Zathura"     --> viewShift "4:pdf"
  , className =? "Signal"      --> doShift "7:im"
  , className =? "Steam"       --> doFloat
  , className =? "Wine"        --> doFloat
  ]
    where viewShift = doF . liftM2 (.) S.greedyView S.shift

-- TODO is this the "right" way?
-- Set ModKey to the Windows Key
myModKey :: KeyMask
myModKey = mod4Mask
