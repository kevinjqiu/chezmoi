import System.IO
import System.Exit
import XMonad
import XMonad.Config.Gnome
import qualified Data.Map as M
import qualified XMonad.StackSet as W

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-shell" --> doFloat
    ])

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig { XMonad.modMask = modMask }) = M.fromList $
    [ ((modMask .|. shiftMask, xK_Return),
       spawn $ XMonad.terminal conf)
    , ((modMask, xK_p),
       spawn "Unity-2d-shell")
    , ((modMask, xK_o),
      spawn "google-chrome")
    -- Standard xmonad key bindings
    , ((modMask .|. shiftMask, xK_c),
      kill)
    , ((modMask, xK_space),
      sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space),
      setLayout $ XMonad.layoutHook conf)
    , ((modMask, xK_n),
      refresh)
    , ((modMask, xK_Tab),
      windows W.focusDown)
    , ((modMask, xK_j),
      windows W.focusDown)
    , ((modMask, xK_k),
      windows W.focusUp)
    , ((modMask, xK_m),
      windows W.focusMaster)
    , ((modMask, xK_Return),
      windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j),
      windows W.swapDown)
    , ((modMask .|. shiftMask, xK_k),
      windows W.swapUp)
    , ((modMask, xK_h),
      sendMessage Shrink)
    , ((modMask, xK_l),
      sendMessage Expand)
    , ((modMask, xK_t),
      withFocused $ windows . W.sink)
    , ((modMask, xK_comma),
      sendMessage (IncMasterN 1))
    , ((modMask, xK_period),
      sendMessage (IncMasterN (-1)))
    -- Quit
    , ((modMask .|. shiftMask, xK_q),
      io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modMask, xK_q),
      restart "xmonad" True)
    ]
    ++
    -- mod-[1..9], switch to workspace N
    -- mod-shift-[1..9], move client to workspace N
    [ ((m .|. modMask, k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main = xmonad gnomeConfig
    { manageHook = myManageHook
    , borderWidth = 3
    , normalBorderColor = "#cccccc"
    , focusedBorderColor = "#008800"
    , terminal = "gnome-terminal"
    , keys = myKeys
    }
