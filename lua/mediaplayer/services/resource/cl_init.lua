-- "addons\\gm-mediaplayer\\lua\\mediaplayer\\services\\resource\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include "shared.lua"

DEFINE_BASECLASS( "mp_service_browser" )

function SERVICE:OnBrowserReady( browser )
	BaseClass.OnBrowserReady( self, browser )

	local html = self:GetHTML()
	html = self.WrapHTML( html )

	self.Browser:SetHTML( html )
end

function SERVICE:GetHTML()
	return "<h1>SERVICE.GetHTML not yet implemented</h1>"
end
