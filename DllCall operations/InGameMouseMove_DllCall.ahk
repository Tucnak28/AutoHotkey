#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
!p::suspend
F12::reload
#MaxThreadsPerHotkey 2
*Home::
;---------------------------------------------------------------------------
SendMouse_LeftClick() { ; send fast right mouse clicks
;---------------------------------------------------------------------------
    DllCall("mouse_event", "UInt", 0x08) ; left button down
    DllCall("mouse_event", "UInt", 0x10) ; left button up
	}


