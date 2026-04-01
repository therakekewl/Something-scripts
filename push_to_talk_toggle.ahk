; Push-to-Talk Auto-Hold Script
; F8 = Key to hold (push to talk)
; F9 = Toggle on/off
; F6 = Emergency stop

isEnabled := false
loop_active := false

; F9 - Toggle the script on/off
F9::
{
    global isEnabled, loop_active
    isEnabled := !isEnabled
    
    if (isEnabled)
    {
        ToolTip, PTT Auto-Hold: ON
        loop_active := true
        PressF8Loop()
    }
    else
    {
        ToolTip, PTT Auto-Hold: OFF
        loop_active := false
        KeyUp("F8")  ; Release F8 if it's being held
    }
    
    SetTimer(() => ToolTip(), 2000)  ; Hide tooltip after 2 seconds
    return
}

PressF8Loop()
{
    global isEnabled, loop_active
    
    while (loop_active && isEnabled)
    {
        KeyDown("F8")     ; Hold down F8
        Sleep(10000)      ; Hold for 10 seconds
        KeyUp("F8")       ; Release F8
        Sleep(500)        ; Wait 500ms before next cycle
    }
}

; F6 - Emergency stop
F6::
{
    global isEnabled, loop_active
    isEnabled := false
    loop_active := false
    KeyUp("F8")
    ToolTip, PTT Auto-Hold: STOPPED
    SetTimer(() => ToolTip(), 2000)
    return
}