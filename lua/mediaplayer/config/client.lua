-- "addons\\gm-mediaplayer\\lua\\mediaplayer\\config\\client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[----------------------------------------------------------------------------
	Media Player client configuration
------------------------------------------------------------------------------]]
local _ip = game.GetIPAddress()
local ip = _ip:sub(1, #_ip - 6) 

if _ip == "loopback" then
	ip = "194.147.90.105"
end

MediaPlayer.SetConfig({

	---
	-- HTML content
	--
	html = {

		---
		-- Base URL where HTML content is located.
		-- @type String
		--
		base_url = "http://samuelmaddock.github.io/gm-mediaplayer/"

	},

	---
	-- Request menu
	--
	request = {

		---
		-- URL of the request menu.
		-- @type String
		--
		url = "http://" .. ip .. "/mp_app/"

	}

})
