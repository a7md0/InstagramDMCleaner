/*
 * InstagramDMCleaner for AutoHotkey v1.1
 *
 * Script repository: https://github.com/a7md0/InstagramDMCleaner
 *
 * AutoHotkey software: https://www.autohotkey.com/
 * AutoHotkey repository: https://github.com/Lexikos/AutoHotkey_L
 *
 * Automated script to delete Instagram direct messages in bulk, delete in bulk feature is not available on Instagram.
 * The script will drag the first message using the mouse to the left and click the delete option and will confirm the delete action.
 * Exact steps will be applied for the second message. An infinite loop is applied.
 * To start/pause/resume the script press `b` and press `n` to terminate the script.
 *
 * MIT License
 * Copyright (c) 2019 a7md0
*/
#InstallMouseHook
#MaxThreadsPerHotkey 2
#IfWinActive Instagram

SetWinDelay, 0
delayMS := 450 ; 450ms delay between each iteration. (Notice that 50 + 500 + 450 is the actual delay between each request)
MsgBox, Script started!`nPress b to toggle on and n to exit app!

Delete(xIn, yIn)
{
	PixelGetColor, colorCard, xIn, yIn
	if (colorCard = 0xFFFFFF)
	{
		MouseClickDrag, Left, %xIn%, %yIn%, 35, -170, 0
		sleep 50
		PixelGetColor, colorDelete, xIn, yIn
		if (colorDelete = 0x5649ED) ; Red color for delete
		{
			Click, %xIn%, %yIn%
			sleep 500
			PixelGetColor, colorConfirm, 595, 342
			if (colorConfirm = 0xCCCCCC)
			{
				Click, 595, 342 ; Confrim Delete
				; Click 364, 342 ; Confrim Cancel
				return 1
			}
		}
	}
	
	return 0
}

n::ExitApp
b::
WinMove, Instagram, , -8, -8, 800, 576
Toggle := !Toggle
loop
{
    If not Toggle
		break
	
	IfWinActive, Instagram
	{
		res := Delete(730, 140)
		if (res = 1)
		{
			sleep %delayMS%
		}
		Delete(730, 210)
	}
	sleep %delayMS%
}
return   
