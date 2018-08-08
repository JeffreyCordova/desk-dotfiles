import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Spacing

baseConfig = desktopConfig

main = xmonad baseConfig {
    terminal            = "termite",
    borderWidth         = 2,
    modMask             = mod4Mask,
    normalBorderColor   = "#000000",
    focusedBorderColor  = "#aabbbc",
    layoutHook          = spacing 5 $ Tall 1 (3/100) (1/2)
}
