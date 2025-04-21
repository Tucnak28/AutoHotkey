#MaxThreadsPerHotkey 3  ; Allow multiple clicks to be processed simultaneously

; Set your preferred hotkey to trigger the rapid clicking (e.g., F1)
Hotkey, F1, ToggleClick

; Initialize the click state as "off"
clickState := 0

ToggleClick:
    ; Toggle the click state
    clickState := !clickState
    
    ; If click state is "on," start rapid clicking
    if (clickState) {
        While GetKeyState("F1", "P") {
            ; Perform a low-level mouse click
            DllCall("mouse_event", uint, 0x02, int, 0, int, 0, uint, 0, int, 0)  ; Left down
            DllCall("mouse_event", uint, 0x04, int, 0, int, 0, uint, 0, int, 0)  ; Left up
			
			;-------------------------
            ; Sleep, 1
            ; Optional: Introduce a minimal sleep to control the click rate
			;-------------------------
			
        }
    }
	
    else {
        return
    }
return
