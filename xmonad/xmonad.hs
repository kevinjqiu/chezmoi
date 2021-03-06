import System.IO
import System.Exit
import XMonad
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook, ewmh)
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook) 
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run (spawnPipe)
import qualified Data.Map as M
import qualified XMonad.StackSet as W

myWorkspaces =
  [
    "1:",  "2:", "3:",
    "4:",  "5:", "6:",
    "7:",  "8:notes", "9:chat",
    "0:vm"
  ]

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Do" --> doFloat
    , className =? "synapse" --> doFloat
    , className =? "Pidgin" --> doF (W.shift "9:chat")
    , className =? "Vmplayer" --> doF (W.shift "0:vm")
    , className =? "Everpad" --> doF (W.shift "8:notes")
    , className =? "Xfce4-notifyd" --> doF W.focusDown
    ])

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig { XMonad.modMask = modMask }) = M.fromList $
    [ ((modMask .|. shiftMask, xK_Return),
       spawn $ XMonad.terminal conf)
    , ((modMask, xK_u),
      spawn "dmenu_run")
    , ((modMask, xK_o),
      spawn "google-chrome")
    , ((modMask, xK_e),
      spawn "nautilus")
    , ((modMask, xK_z),
      spawn "thunderbird")
    , ((modMask, xK_v),
      spawn "vmplayer")
    , ((modMask .|. controlMask, xK_l),
      spawn "/usr/bin/gnome-screensaver-command --lock")
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
         | (i, k) <- zip myWorkspaces ([xK_1 .. xK_9] ++ [xK_0])
         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r}, switch to physical/xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, move client to screen 1, 2 or 3
    [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- myLogHook :: X ()
-- myLogHook = fadeInactiveLogHook fadeAmount
--    where fadeAmount = 0.8

xmobarTitleColor = "#FFB6B0"
xmobarCurrentWorkspaceColor = "#CEFFAC"

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ gnomeConfig {
          manageHook = myManageHook
        , borderWidth = 2
        , normalBorderColor = "#cccccc"
        , focusedBorderColor = "#008800"
        , terminal = "gnome-terminal --hide-menubar"
        , workspaces = myWorkspaces
        , keys = myKeys
        , handleEventHook = fullscreenEventHook
        , logHook = dynamicLogWithPP $ xmobarPP {
              ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
            , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
            , ppSep = "    "
        }
    }
