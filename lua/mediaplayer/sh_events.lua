-- "addons\\gm-mediaplayer\\lua\\mediaplayer\\sh_events.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MP.EVENTS = {
	MEDIA_CHANGED = "mediaChanged",
	QUEUE_CHANGED = "mp.events.queueChanged",
	PLAYER_STATE_CHANGED = "mp.events.playerStateChanged"
}

if CLIENT then

	table.Merge( MP.EVENTS, {
		VOLUME_CHANGED = "mp.events.volumeChanged"
	} )

end
