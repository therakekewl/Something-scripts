; F8 = key to hold
; F9 = toggle on/off
; F6 = emergency stop

isEnabled := false
loop_active := false

F9::
{
    global isEnabled, loop_active
    isEnabled := !isEnabled

    if (isEnabled)
    {
        ToolTip("PTT Auto-Hold: ON")
        loop_active := true
        SetTimer(PressF8Loop, 100)
    }
    else
    {
        ToolTip("PTT Auto-Hold: OFF")
        loop_active := false
        SetTimer(PressF8Loop, 0)
        Send "{F8 up}"
    }

    SetTimer(() => ToolTip(), -2000)
}

PressF8Loop()
{
    global isEnabled, loop_active

    if (loop_active && isEnabled)
    {
        Send "{F8 down}"
        Sleep 10000
        Send "{F8 up}"
        Sleep 500
    }
}

F6::
{
    global isEnabled, loop_active
    isEnabled := false
    loop_active := false
    SetTimer(PressF8Loop, 0)
    Send "{F8 up}"
    ToolTip("PTT Auto-Hold: STOPPED")
    SetTimer(() => ToolTip(), -2000)
}
