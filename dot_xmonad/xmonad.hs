import XMonad
import XMonad.Config.Gnome
import qualified Data.Map as M

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-shell" --> doFloat
    ])

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig { XMonad.modMask = modMask }) = M.fromList $
    [ ((modMask, xK_w), spawn "google-chrome") ]

main = xmonad gnomeConfig
    { manageHook = myManageHook
    , borderWidth = 3
    , normalBorderColor = "#cccccc"
    , focusedBorderColor = "#008800"
    , terminal = "gnome-terminal"
    , keys = myKeys
    }
