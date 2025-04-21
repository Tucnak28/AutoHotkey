#Persistent
#SingleInstance Force

; Initialize counter
counter := 0

; Create the non-windowed GUI
Gui, +AlwaysOnTop -Caption +ToolWindow
Gui, Color, 0x000000  ; Set the background color to black
Gui, Font, s12 cFFFFFF, Verdana  ; Set the font size and color

Gui, Add, Text, vCounterText w200, Counter: %counter%

; Position the GUI in the upper left corner
GuiX := 10  ; 10 pixels from the left edge
GuiY := 10  ; 10 pixels from the top edge

; Position and show the GUI
Gui, Show, x%GuiX% y%GuiY% NoActivate

; Hotkey for Ctrl + B to increment counter
b::
    counter++
    GuiControl,, CounterText, Counter: %counter%
    Click ; Simulate a mouse click
return

; Hotkey for Ctrl + P to reset counter
^p::
    counter := 0
    GuiControl,, CounterText, Counter: %counter%
return

; Ensure the script exits cleanly
GuiClose:
GuiEscape:
    ExitApp
