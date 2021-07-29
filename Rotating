#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
!o::exitapp
F12::reload
x::
	LoopCount := 1
	Rotation := 300
	Move := Rotation/LoopCount
	SleepTime := LoopCount
	loop, %LoopCount%
	{
		DllCall("mouse_event", "UInt", 0x01, "UInt", Move, "UInt", 0)
	}
return
