-- "addons\\gm-mediaplayer\\lua\\mediaplayer\\services\\youtube\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include "shared.lua"

local urllib = url

local htmlBaseUrl = MediaPlayer.GetConfigValue('html.base_url')

DEFINE_BASECLASS( "mp_service_browser" )

-- https://developers.google.com/youtube/player_parameters
-- TODO: add closed caption option according to cvar
SERVICE.VideoUrlFormat = "https://www.youtube.com/embed/%s?t=%s&autoplay=1&muted=1&controls=0&showinfo=0&modestbranding=1&rel=0&iv_load_policy=3"

local base = "var vid = document.getElementsByTagName('video')[0]; if(vid) "

local JS_SetVolume = base .. "vid.volume = %s; "
local JS_Seek = base .. "var tobechanged = Number(%s); if(tobechanged < vid.duration){var diffTime = Math.abs(vid.currentTime - tobechanged); if(diffTime > 4){vid.currentTime = tobechanged;}}"
local JS_Play = base .. "vid.play();"
local JS_Pause = base .. "vid.pause();"

local function YTSetVolume( self )
	-- if not self.playerId then return end
	local js = JS_SetVolume:format( MediaPlayer.Volume() )
	if self.Browser then
		self.Browser:RunJavascript(js)
	end
end

local function YTSeek( self, seekTime )
	-- if not self.playerId then return end
	local js = JS_Seek:format( seekTime )
	if self.Browser then
		self.Browser:RunJavascript(js)
	end
end

function SERVICE:SetVolume( volume )
	local js = JS_SetVolume:format( MediaPlayer.Volume() )
	self.Browser:RunJavascript(js)
end

local inject_script
local script = function(self, browser, on_success)
	if not inject_script then
		http.Fetch("https://github.com/zerodytrash/Simple-YouTube-Age-Restriction-Bypass/releases/download/v2.3.5/Simple-YouTube-Age-Restriction-Bypass.user.js", function(body, _, _, code)
			if not body or code ~= 200 then on_success(true) return end

			inject_script = body

			if on_success then
				on_success()
			end
		end)
	else
		if on_success then
			on_success()
		end
	end
end

function SERVICE:OnBrowserReady( browser )

	BaseClass.OnBrowserReady( self, browser )

	script(self, browser, function(errored)
		-- Resume paused player
		if not IsValid(browser) then
			return
		end

		if self._YTPaused then
			self.Browser:RunJavascript( JS_Play )

			browser:RunJavascript(inject_script)

			if not errored then
				if timer.Exists("YT.ByPass") then
					timer.Remove("YT.ByPass")
				end

				timer.Create("YT.ByPass", .05, 79, function()
					if IsValid(browser) then
						browser:RunJavascript(inject_script)
					end
				end)
			end

			self._YTPaused = nil
			return
		end

		local curTime = self:CurrentTime()

		local videoId = self:GetYouTubeVideoId()
		local url = string.format(self.VideoUrlFormat, videoId, self:IsTimed() and curTime > 3 and math.Round(curTime) or 0)

		browser:OpenURL(url)
		browser:RunJavascript(inject_script)

		if not errored then
			if timer.Exists("YT.ByPass") then
				timer.Remove("YT.ByPass")
			end

			timer.Create("YT.ByPass", .05, 79, function()
				if IsValid(browser) then
					browser:RunJavascript(inject_script)
				end
			end)
		end
	end)
end

function SERVICE:Pause()
	BaseClass.Pause( self )

	if IsValid(self.Browser) then
		self.Browser:RunJavascript(JS_Pause)
		self._YTPaused = true
	end
end

function SERVICE:Sync()
	local seekTime = self:CurrentTime()
	if self:IsPlaying() and self:IsTimed() and seekTime > 0 then
		YTSeek( self, seekTime )
	end
end

function SERVICE:IsMouseInputEnabled()
	return IsValid( self.Browser )
end
