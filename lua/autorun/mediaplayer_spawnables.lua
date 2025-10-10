local function AddMediaPlayerModel(classname, printname, model, icon, config)
	list.Set("SpawnableEntities", "mediaplayer_tv_" .. classname, {
		PrintName = printname,
		ClassName = "mediaplayer_tv",
		Category = "Media Player",
		DropToFloor = true,
		IconOverride = icon,
		KeyValues = {
			model = model
		}
	})

	list.Set("MediaPlayerModelConfigs", model, config)
end

AddMediaPlayerModel(
	"huge_billboard",
	"Huge Billboard",
	"models/hunter/plates/plate5x8.mdl",
	"entities/mediaplayer_tv2.png",
	{
		angle = Angle(0, 90, 0),
		offset = Vector(-118.8, 189.8, 2.5),
		width = 380,
		height = 238
	}
)

AddMediaPlayerModel(
	"small_tv",
	"Small TV",
	"models/props_phx/rt_screen.mdl",
	"entities/mediaplayer_tv3.png",
	{
		angle = Angle(-90, 90, 0),
		offset = Vector(6.5, 27.9, 35.3),
		width = 56,
		height = 33
	}
)

AddMediaPlayerModel(
	"console_tv",
	"Console TV",
	"models/props/cs_militia/tv_console.mdl",
	"entities/mediaplayer_tv4.png",
	{
		angle = Angle(-90, 90, 0),
		offset = Vector(21.5,43-17 + 2.1,48-2),
		width = 56,
		height = 40
	}
)

AddMediaPlayerModel(
	"big_console_tv",
	"Big Console TV",
	"models/props/cs_militia/television_console01.mdl",
	"entities/mediaplayer_tv5.png",
	{
		angle  = Angle(-90, 90, 0),
		offset = Vector(13.55, 24, 57),
		width  = 48,
		height = 36
	}
)

if SERVER then
	hook.Add("PlayerSpawnedSENT", "MediaPlayer_SetOwner", function(ply, ent)
		if not ent.IsMediaPlayerEntity then return end
		ent:SetCreator(ply)

		local mediaplayer = ent:GetMediaPlayer()
		mediaplayer:SetOwner(ply)
	end)
end
