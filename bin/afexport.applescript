#!/usr/bin/osascript

-- This is free and unencumbered software released into the public domain.
--
-- Anyone is free to copy, modify, publish, use, compile, sell, or
-- distribute this software, either in source code form or as a compiled
-- binary, for any purpose, commercial or non-commercial, and by any
-- means.
--
-- In jurisdictions that recognize copyright laws, the author or authors
-- of this software dedicate any and all copyright interest in the
-- software to the public domain. We make this dedication for the benefit
-- of the public at large and to the detriment of our heirs and
-- successors. We intend this dedication to be an overt act of
-- relinquishment in perpetuity of all present and future rights to this
-- software under copyright law.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.
--
-- For more information, please refer to <http://unlicense.org/>

to exportSlicesButton on theWindow
	tell application "System Events" to tell theWindow
		tell first splitter group -- right side
			set theButtons to buttons
			repeat with aButton in theButtons
				if title of aButton starts with "Export Slices" then
					return aButton
				end if
			end repeat
			tell first splitter group -- left side
				set theButtons to buttons
				repeat with aButton in theButtons
					if title of aButton starts with "Export Slices" then
						return aButton
					end if
				end repeat
			end tell
		end tell
	end tell
end exportSlicesButton

to exportSlices for anItem by anAppName
	tell application "System Events"
		set anItemPath to POSIX path of (container of anItem as alias)
	end tell
	tell application anAppName
		-- MARK: open window for the current item
		open anItem
		activate
	end tell
	delay 1
	tell application "System Events" to tell application process anAppName
		-- MARK: click export slices button
		try
			click menu item "Export Persona" of second menu of first menu bar
		end try
		set theButton to exportSlicesButton of me on last window
		try
			theButton -- test if the button found
		on error -- if the slices window is not opened
			click menu item "Slices" of menu "Window" of first menu bar
			set theButton to exportSlicesButton of me on last window
			try
				theButton -- test if the button found
			on error -- if the slices window is opened but hidden
				click menu item "Slices" of menu "Window" of first menu bar
				set theButton to exportSlicesButton of me on last window
			end try
		end try
		click theButton
		-- MARK: locate destination to slices be exported
		set theWindows to windows
		repeat with aWindow in theWindows
			tell aWindow
				if name starts with "Select export folder" then
					keystroke "G" using {command down}
					delay 1
					keystroke anItemPath
					keystroke return
					delay 1
					click button "Export"
					exit repeat
				end if
			end tell
		end repeat
		-- MARK: overwrite if the files exist already
		set theWindows to windows
		repeat with aWindow in theWindows
			tell aWindow
				if name is equal to "Export" then
					click button "Export"
					exit repeat
				end if
			end tell
		end repeat
		-- MARK: close window for the current item
		click menu item "Close" of menu "File" of first menu bar
		-- MARK: discard changes
		if name of first window does not start with anAppName then
			click button "Don't save" of first window
		end if
	end tell
	delay 1
end exportSlices

on run arguments
	if (count of arguments) is greater than 0 then
		set posixRoot to first item of arguments
		if first character of posixRoot is not equal to "/" then
			set posixRoot to (do shell script "pwd") & "/" & posixRoot
		end if
		set root to POSIX file posixRoot as alias
		tell application "Finder" to set theItems to items of folder root
		repeat with anItem in theItems
			if name extension of anItem is equal to "afdesign" then
				exportSlices for anItem by "Affinity Designer 2"
			else if name extension of anItem is equal to "afphoto" then
				exportSlices for anItem by "Affinity Photo 2"
			end if
		end repeat
	end if
end run
