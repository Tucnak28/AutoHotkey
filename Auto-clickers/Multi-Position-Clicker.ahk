#NoEnv
#SingleInstance Force
SetBatchLines -1

; -- globals --
Delay := 500           ; delay between full cycles (ms)
InterDelay := 50       ; delay between individual clicks (ms)
Positions := []        ; array of {hWnd:, title:, x:, y:} objects
Running := false
CurrentIndex := 1
ClickMode := "cycle"  ; "all" or "cycle"

; -- GUI layout --
Gui +Resize +AlwaysOnTop
Gui Font, s10
Gui Add, ListView, vLV w360 h200, Window|X|Y
Gui Add, Button, x+10 yp wp h24 gBtn_Add,    Add
Gui Add, Button, x+6  yp+30 wp h24 gBtn_Remove, Remove
Gui Add, Text,    yp+70,    Cycle Delay (ms):
Gui Add, Edit,    vED_Delay w50 yp+68, %Delay%
Gui Add, Button,  x+60 yp+66 wp h24 gBtn_SetDelay, Set
Gui Add, Button,  xm+10 yp+100 wp h28 gBtn_Start, Start
Gui Add, Button,  x+100 yp+100 wp h28 gBtn_Stop,  Stop
Gui Add, Checkbox, xm+10 yp+40 vCB_Mode gToggleMode, Click all per cycle
Gui Show,, Multi‑Window ControlClicker
return

; -- Add new entry: capture window and client-relative coords --
Btn_Add:
    Gui Hide
    MsgBox, 64, Capture Position, Move your mouse over the target window, then press Enter.
    Input, _, L1 T10
    MouseGetPos, , , winID
    CoordMode, Mouse, Client
    MouseGetPos, cx, cy, winID
    CoordMode, Mouse, Screen
    WinGetTitle, wTitle, ahk_id %winID%
    Positions.Push({hWnd:winID, title:wTitle, x:cx, y:cy})
    LV_Add("", wTitle, cx, cy)
    Gui Show
return

; -- Remove selected entry --
Btn_Remove:
    sel := LV_GetNext(0, "Focused")
    if sel {
        LV_Delete(sel)
        Positions.RemoveAt(sel)
    }
return

; -- Update cycle delay --
Btn_SetDelay:
    Gui, Submit, NoHide
    if (ED_Delay is integer and ED_Delay > 0)
        Delay := ED_Delay
    else
        MsgBox, 48, Error, Please enter a positive integer for the cycle delay.
return

; -- Toggle click mode --
ToggleMode:
    Gui, Submit, NoHide
    ClickMode := CB_Mode ? "all" : "cycle"
return

; -- Start clicking loop --
Btn_Start:
    if (Running) {
        MsgBox, 48, Already Running, Clicking is already in progress.
        return
    }
    if (!Positions.Length()) {
        MsgBox, 48, Error, No entries to click. Add at least one.
        return
    }
    Running := true
    GuiControl,, Btn_Start, Disabled
    GuiControl,, Btn_Stop,
    SetTimer, DoCycle, % Delay
return

; -- Stop clicking --
Btn_Stop:
    if (!Running)
        return
    Running := false
    GuiControl,, Btn_Start,
    GuiControl,, Btn_Stop, Disabled
    SetTimer, DoCycle, Off
return

; -- Perform one full cycle using PostMessage clicks --
DoCycle:
    if (ClickMode = "all") {
        for index, _pos in Positions {
            hWnd := _pos.hWnd
            x := _pos.x
            y := _pos.y
            lParam := (y << 16) | (x & 0xFFFF)
            PostMessage, 0x201, 0x0001, %lParam%, , ahk_id %hWnd%
            Sleep, 5
            PostMessage, 0x202, 0x0000, %lParam%, , ahk_id %hWnd%
            Sleep, InterDelay
        }
    } else {
        if (Positions.Length() = 0)
            return
        if (CurrentIndex > Positions.Length())
            CurrentIndex := 1
        _pos := Positions[CurrentIndex]
        hWnd := _pos.hWnd
        x := _pos.x
        y := _pos.y
        lParam := (y << 16) | (x & 0xFFFF)
        PostMessage, 0x201, 0x0001, %lParam%, , ahk_id %hWnd%
        Sleep, 5
        PostMessage, 0x202, 0x0000, %lParam%, , ahk_id %hWnd%
        CurrentIndex++
    }
return

; -- Hotkeys for quick start/stop --
F8::Gosub, Btn_Start
F9::Gosub, Btn_Stop
^!s::Gosub, Btn_Stop