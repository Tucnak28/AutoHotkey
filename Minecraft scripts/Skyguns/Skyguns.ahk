#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
*pause::suspend
*F12::reload
;Python
  ^f:: send ě
  ^f up:: send š
return

;Gapple
  ^v::
  send 1
  Click, right
  send š
  sleep 50
  return

;spawn
  ^g::
  send t
  sleep 50
  send /spawn
  send {enter}
  return

;Putty
  ^y::
  send č
  Loop
  {
    Click, right
    sleep 40
    Click, right
    sleep 50
    Click
    sleep 20
    if not GetKeyState("y","P")
      break
  }
  send š
  KeyWait, y
  return

;Hunter Rifle
  ^MButton::
  Click, right
  sleep 50
  send ý
  sleep 50
  Click
  return

;2x Hunter rifle Back Trickshot
  ^x::
  LoopCount := 10
  Rotation := 1200
  TurningTime := 100
  Move := Rotation/LoopCount
  SleepTime := TurningTime/LoopCount
  loop, %LoopCount%
  {
    DllCall("mouse_event", "UInt", 0x01, "UInt", Move, "UInt", 0)
    sleep %Sleeptime%
  }
  send ž
  sleep 50
  send, {Space down}
  sleep 25
  send, {Space up}
  sleep 25
  Click, right
  sleep 25
  send ý
  sleep 25
  return  

;2x Hunting rifle reload
  ^b::
  send ž
  Click right
  sleep 4200
  send ý
  Click right
  return
