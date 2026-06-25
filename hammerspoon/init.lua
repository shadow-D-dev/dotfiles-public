----------------------------------------------------------------------
--                              SETUP
----------------------------------------------------------------------

local hs = hs

local audio = require("hs.audiodevice")
local spotify = require("hs.spotify")

local hyper = { "cmd", "alt", "ctrl", "shift" }

----------------------------------------------------------------------
--                           HYPER KEYMAP
----------------------------------------------------------------------
--
-- Apps
-- A : Zen
-- B : Helium
-- C : ChatGPT
-- D : Discord
-- K : Kitty + tmux
-- M : Spotify
-- O : OBS
-- S : Safari
-- V : Google Chrome
--
-- Spotify
-- P : Play / Pause
-- Q : Previous Track
-- W : Next Track
-- R : Spotify Volume -
-- T : Spotify Volume +
--
-- Wallpaper
-- T (currently shared) : Random Wallpaper
-- Shift + E            : Black Wallpaper
--
-- Misc
-- 2 : Screenshot
-- X : Toggle Margins
-- Shift + R : Reload Hammerspoon
--
----------------------------------------------------------------------

----------------------------------------------------------------------
--                        SYSTEM SHORTCUTS
----------------------------------------------------------------------

-- Screenshot
hs.hotkey.bind(hyper, "1", function()
	hs.execute("screencapture -i ~/Desktop/screenshot_$(date +%Y%m%d_%H%M%S).png")
	hs.alert.show("Screenshot taken!")
end)

-- Reload Hammerspoon
hs.hotkey.bind(hyper, "z", function()
	hs.reload()
	hs.alert.show("Hammerspoon config reloaded")
end)

----------------------------------------------------------------------
--                      APPLICATION LAUNCHERS
----------------------------------------------------------------------

-- ChatGPT
hs.hotkey.bind(hyper, "c", function()
	hs.application.launchOrFocus("/Applications/ChatGPT.app/")
end)

-- Google Chrome
hs.hotkey.bind(hyper, "v", function()
	hs.application.launchOrFocus("/Applications/Google Chrome.app/")
end)

-- Discord
hs.hotkey.bind(hyper, "d", function()
	hs.application.launchOrFocus("/Applications/Discord.app/")
end)

-- Helium
hs.hotkey.bind(hyper, "b", function()
	hs.application.launchOrFocus("/Applications/Helium.app")
end)

-- Kitty
hs.hotkey.bind(hyper, "k", function()
	hs.application.launchOrFocus("/Applications/kitty.app/")

	hs.timer.doAfter(1.0, function()
		local kitty = hs.appfinder.appFromName("kitty")

		if kitty then
			kitty:activate()

			hs.eventtap.keyStrokes("tmux")
			hs.eventtap.keyStroke({}, "return")

			hs.timer.doAfter(2.0, function()
				hs.eventtap.keyStroke({ "ctrl" }, "f")

				hs.timer.doAfter(0.1, function()
					hs.eventtap.keyStroke({ "ctrl" }, "r")
				end)
			end)
		else
			hs.alert.show("Kitty not found")
		end
	end)
end)

-- OBS
hs.hotkey.bind(hyper, "o", function()
	hs.application.launchOrFocus("/Applications/OBS.app/")
end)

-- Safari
hs.hotkey.bind(hyper, "s", function()
	hs.application.launchOrFocus("/Applications/Safari.app/")
end)

-- Spotify
hs.hotkey.bind(hyper, "m", function()
	hs.application.launchOrFocus("/Applications/Spotify.app/")
end)

-- Zen
hs.hotkey.bind(hyper, "a", function()
	hs.application.launchOrFocus("/Applications/Zen.app/")
end)

----------------------------------------------------------------------
--                       WALLPAPER HELPERS
----------------------------------------------------------------------

local wallpaperFolder = "/Users/shadow./Documents/Wallpaper/random"

local function setRandomWallpaper()
	local files = {}

	for file in hs.fs.dir(wallpaperFolder) do
		if file:match("%.jpe?g$") or file:match("%.png$") then
			table.insert(files, file)
		end
	end

	if #files == 0 then
		hs.alert.show("No wallpapers found!")
		return
	end

	local randomFile = files[math.random(#files)]
	local fullPath = wallpaperFolder .. "/" .. randomFile

	local script = string.format('tell application "System Events" to set picture of every desktop to "%s"', fullPath)

	local ok, msg = hs.osascript.applescript(script)

	if ok then
		hs.alert.show("Wallpaper changed!")
	else
		hs.alert.show("Failed: " .. tostring(msg))
	end
end

local function setBlackWallpaper()
	local script = [[
		tell application "System Events"
			set picture of every desktop to "/System/Library/Desktop Pictures/Solid Colors/Black.png"
		end tell
	]]

	local ok, msg = hs.osascript.applescript(script)

	if ok then
		hs.alert.show("Black wallpaper set!")
	else
		hs.alert.show("Failed: " .. tostring(msg))
	end
end

----------------------------------------------------------------------
--                       WALLPAPER HOTKEYS
----------------------------------------------------------------------

-- Random Wallpaper
hs.hotkey.bind(hyper, "u", function()
	setRandomWallpaper()
end)

-- Black Wallpaper
hs.hotkey.bind(hyper, "i", function()
	setBlackWallpaper()
end)
----------------------------------------------------------------------
--                        SPOTIFY HELPERS
----------------------------------------------------------------------

local lastTrack = ""

local function showCurrentTrack()
	hs.timer.doAfter(0.5, function()
		local track = spotify.getCurrentTrack()
		local artist = spotify.getCurrentArtist()

		if track and artist then
			local current = artist .. " – " .. track
			lastTrack = current
			hs.alert.show(current)
		end
	end)
end

local function spotifyVolume(delta)
	local ok, result = hs.osascript.applescript(string.format(
		[[
		tell application "Spotify"
			set newVolume to sound volume + (%d)

			if newVolume > 100 then
				set newVolume to 100
			end if

			if newVolume < 0 then
				set newVolume to 0
			end if

			set sound volume to newVolume
			return newVolume
		end tell
	]],
		delta
	))

	if ok then
		hs.alert.show("Spotify Volume: " .. result .. "%%")
	end
end

----------------------------------------------------------------------
--                        SPOTIFY HOTKEYS
----------------------------------------------------------------------

-- Play / Pause
hs.hotkey.bind(hyper, "p", function()
	if spotify.isRunning() then
		spotify.playpause()

		hs.timer.doAfter(0.25, function()
			if spotify.isPlaying() then
				hs.alert.show("▶ Playing")
			else
				hs.alert.show("⏸ Paused")
			end
		end)
	else
		hs.alert.show("Spotify not running")
	end
end)

-- Previous Track
hs.hotkey.bind(hyper, "q", function()
	if spotify.isRunning() then
		spotify.previous()
		showCurrentTrack()
	else
		hs.alert.show("Spotify not running")
	end
end)

-- Next Track
hs.hotkey.bind(hyper, "w", function()
	if spotify.isRunning() then
		spotify.next()
		showCurrentTrack()
	else
		hs.alert.show("Spotify not running")
	end
end)

-- Spotify Volume Down
hs.hotkey.bind(hyper, "r", function()
	if spotify.isRunning() then
		spotifyVolume(-5)
	else
		hs.alert.show("Spotify not running")
	end
end)

-- Spotify Volume Up
hs.hotkey.bind(hyper, "t", function()
	if spotify.isRunning() then
		spotifyVolume(5)
	else
		hs.alert.show("Spotify not running")
	end
end)

----------------------------------------------------------------------
--                      SPOTIFY NOTIFIER
----------------------------------------------------------------------

hs.timer.doEvery(2, function()
	if spotify.isRunning() then
		local track = spotify.getCurrentTrack()
		local artist = spotify.getCurrentArtist()

		if track and artist then
			local current = artist .. " – " .. track

			if current ~= lastTrack then
				lastTrack = current
				hs.alert.show(current)
			end
		end
	end
end)

----------------------------------------------------------------------
--                         YABAI HELPERS
----------------------------------------------------------------------

hs.hotkey.bind(hyper, "x", function()
	hs.execute(os.getenv("HOME") .. "/.config/custom-scripts/toggle_margins.sh")
	hs.alert.show("Toggled margins")
end)

----------------------------------------------------------------------
--                          AUDIO KEYS
----------------------------------------------------------------------

-- F1 : System Volume Up
hs.hotkey.bind({}, "F1", function()
	audio.defaultOutputDevice():setVolume(math.min(100, audio.defaultOutputDevice():volume() + 5))
end)

-- F2 : System Volume Down
hs.hotkey.bind({}, "F2", function()
	audio.defaultOutputDevice():setVolume(math.max(0, audio.defaultOutputDevice():volume() - 5))
end)
