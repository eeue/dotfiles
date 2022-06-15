import           XMonad
import           XMonad.Actions.NoBorders
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.StatusBar
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Layout.BinarySpacePartition
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing
import qualified XMonad.StackSet                    as W
import           XMonad.Util.EZConfig
import           XMonad.Util.Loggers
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce
import           XMonad.Util.Ungrab

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig


myConfig =
  def
    { modMask = mod4Mask, -- Rebind Mod to the Super key
      layoutHook  = spacingWithEdge 10 $ noBorders $ lessBorders OnlyFloat $ myLayout, -- Use custom layouts
      manageHook  = myManageHook, -- Match on certain windows
      startupHook = myStartupHook
    }
    `additionalKeysP` [ ("M-<Return>", spawn       "alacritty"),
                        ("M-p",        spawn "rofi -show drun"),
			("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"    ),
			("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"    ),
			("<XF86AudioMute>",        spawn "pactl set-sink-mute   @DEFAULT_SINK@  toggle"),
			("M-<Tab>",   windows  W.focusDown ),
			("M-S-<Tab>", windows  W.swapDown  ),
			("<Print>", unGrab *> spawn "screenshot")

                      ]

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat,
      className =? "Steam" --> doFloat,
      isDialog --> doFloat
    ]


myLayout = emptyBSP ||| tiled ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1 -- Default number of windows in the master pane
    ratio = 1 / 2 -- Default proportion of screen occupied by master pane
    delta = 3 / 100 -- Percent of screen to increment by when resizing panes


myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep =  " > ",
      ppCurrent = xmobarColor "#61AFEF" "" . wrap "[" "]",
      ppHidden = xmobarColor "#ABB2BF" "",
      ppHiddenNoWindows = xmobarColor "#6b7089" "",
      ppOrder = \(ws : l : t : ex) -> [ws] ++ map (xmobarColor "#E06C75" "") ex ++ [xmobarColor "#ABB2BF" "" t],
      ppExtras = []
    }
  where
    formatFocused = wrap (white "[") (white "]") . blue . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    -- \| Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, white :: String -> String
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    lowWhite = xmobarColor "#bbbbbb" ""

myStartupHook :: X ()
myStartupHook = do
spawnOnce "nitrogen --restore &"

