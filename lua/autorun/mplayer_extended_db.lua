-- "addons\\gm-mediaplayer\\lua\\autorun\\mplayer_extended_db.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function SetFacePosition(ent, anc, nrm, pos, ang)
  if(not (ent and ent:IsValid())) then return end
  local norm, epos = Vector(nrm), ent:GetPos()
  local vobb = ent:OBBCenter(); norm:Normalize()
  local cang = (ang and Angle(ang) or Angle(0,0,0))
  local vpos = (pos and Vector(pos) or Vector())
  local righ = (vpos - anc):Cross(norm)
  local rang = norm:Cross(righ):AngleEx(norm)
  local tang = ent:AlignAngles(ent:LocalToWorldAngles(cang), rang)
  tang:Normalize(); tang:RotateAroundAxis(norm, 180); ent:SetAngles(tang)
  -- Apply the angle as long as it is ready and point to position
  vobb.x, vobb.y, vobb.z = -vobb.x, -vobb.y, -vobb.z -- Reverse OBB
  local drbb = ent:OBBMaxs(); drbb:Sub(ent:OBBMins()) -- Diagonal vector
  local drdt = ent:WorldToLocal(norm + epos) -- Make the normal vector local
  local marg = math.abs(drbb:Dot(drdt) / 2) -- Grab half of entity width
  vobb:Rotate(tang); vobb:Add(norm * marg) -- Convert to world-space
  local tpos = Vector(vobb); tpos:Add(pos) -- Use OBB offset
  ent:SetPos(tpos) -- Apply the calculated position on the screen
end

local function AddMediaPlayerModel( name, model, config)
  if util.IsValidModel( model ) then
    list.Set( "SpawnableEntities", model, {
      PrintName      = name,
      Information    = name,
      Spawnable      = true,
      AdminSpawnable = true,
      DropToFloor    = true,
      Editable       = true,
      Type           = "anim",
      Contact        = "physicsdude@anywhere.com",
      IconOverride   = "materials/spawnicons/"..model:sub(1, -5)..".png",
      Author         = "Physics Dude",
      KeyValues      = { model = model },
      ClassName      = "mediaplayer_tv",
      Base           = "mediaplayer_base",
      Category       = "Media Player",
      Instructions   = "Right click on the TV to see available Media Player options."
                         .." Alternatively, press E on the TV to turn it on."
    } )

    -- Make a difference between regular models and extended models
    config.extended = true

    list.Set( "MediaPlayerModelConfigs", model, config )
  end
end

-- TV-esque models from Garry's Mod "Bulder" props
AddMediaPlayerModel(
  "Plate TV (05x075)",
  "models/hunter/plates/plate05x075.mdl",
  {
    angle  = Angle(0, 90, 0), -- Screen offset angle according to the base prop
    offset = Vector(-12.11, 23.98, 1.75), -- Forward/Back | Left/Right | Up/Down
    width  = 36.09, -- Screen width size for aspect ratio
    height = 24.22, -- Screen height size for aspect ratio
    aface  = Angle(-90,0,0) -- Model custom angle for facing the player when spawned
  }
)
          
AddMediaPlayerModel(
  "Plate TV (075x1)",
  "models/hunter/plates/plate075x1.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-23.98, 23.97, 1.75),
    width  = 47.95,
    height = 36.09,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (1x2)",
  "models/hunter/plates/plate1x2.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-23.98, 47.7, 1.75),
    width  = 95.4,
    height = 47.95,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (2x3)",
  "models/hunter/plates/plate2x3.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-47.7, 71.42, 1.8),
    width  = 142.85,
    height = 95.4,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (2x4)",
  "models/hunter/plates/plate2x4.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-47.7, 95.15, 1.8),
    width  = 190.3,
    height = 95.4,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (3x4)",
  "models/hunter/plates/plate3x4.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-71.43, 95.15, 1.75),
    width  = 190.3,
    height = 142.85,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (3x5)",
  "models/hunter/plates/plate3x5.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-71.43, 118.87, 1.8),
    width  = 237.75,
    height = 142.85,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (4x7)",
  "models/hunter/plates/plate4x7.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-95.15, 166.32, 1.8),
    width  = 332.65,
    height = 190.3,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate TV (4x8)",
  "models/hunter/plates/plate4x8.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-95.15, 190.05, 1.8),
    width  = 380.1,
    height = 190.3,
    aface  = Angle(-90,0,0)
  }
)
--[[
-- default mediaplayer dont overwrite!!!
AddMediaPlayerModel(
  "Plate TV (5x8)",
  "models/hunter/plates/plate5x8.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-118.8, 189.8, 2.5),
    width  = 380,
    height = 238
  }
)
]]--
AddMediaPlayerModel(
  "Plate TV (8x16)",
  "models/hunter/plates/plate8x16.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-190.05, 379.85, 2.5),
    width  = 759.7,
    height = 380.1,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate XL (16x24)",
  "models/hunter/plates/plate16x24.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-379.85, 569.65, 3),
    width  = 1139.3,
    height = 769.7,
    aface  = Angle(-90,0,0)
  }
)

AddMediaPlayerModel(
  "Plate XL (24x32)",
  "models/hunter/plates/plate24x32.mdl",
  {
    angle  = Angle(0, 90, 0),
    offset = Vector(-569.95, 759.45, 3),
    aface  = Angle(-90,0,0),
    width  = 1518.9,
    height = 1139.3,
    aface  = Angle(-90,0,0)
  }
)

--[[TV-esque models from Garry's Mod and Mounted Source Games]]--
AddMediaPlayerModel(
  "(Gmod) TV Standard",
  "models/props_c17/tv_monitor01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(7.28-1.75, 11.21-1.75, 8.28-2.25),
    width  = 15,
    height = 11
  }
)

AddMediaPlayerModel( --some other source game
  "(Gmod) TV Large",
  "models/props_debris/tv_monitor01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(10.76-0.3, 17.60-4, 12.87-4),
    width  = 22,
    height = 17
  }
)

AddMediaPlayerModel(
  "(Gmod) Citizen Radio",
  "models/props_lab/citizenradio.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(9.41-0.9, 14.28-8.25, 17.36-1.75),
    width  = 17.5,
    height = 4
  }
)

AddMediaPlayerModel(
  "(Gmod) Mini TV",
  "models/props_lab/monitor01b.mdl",
  {
    angle  = Angle(-89, 90, 0),
    offset = Vector(6.86-0.6,7.45-2,6.8-1.85),
    width  = 9,
    height = 9
  }
)

AddMediaPlayerModel(
  "(Gmod) PC Monitor TV",
  "models/props_interiors/computer_monitor.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(3.3,13-2.5,27-2.2),
    width  = 21,
    height = 16
  }
)

AddMediaPlayerModel( --other
  "(Gmod) Microwave",
  "models/props/cs_office/microwave.mdl",
  {
    angle  = Angle(0, 180, 90),
    offset = Vector(16-2.4,-11+0.5,17-3),
    width  = 18,
    height = 11
  }
)

AddMediaPlayerModel( --other
  "(GMod) TV Console",
  "models/props/cs_militia/tv_console.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(21.5,43-17,48-4),
    width  = 52,
    height = 36
  }
)

AddMediaPlayerModel( --other
  "(GMod) Big TV Console",
  "models/props/cs_militia/television_console01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(13.55,25.15,57),
    width  = 50,
    height = 36
  }
)

AddMediaPlayerModel( --gmod
  "(GMod) PC Monitor",
  "models/props_office/computer_monitor_01.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(3.4,14.11-2.5,25.50-2.5),
    width  = 23,
    height = 17
  }
)

AddMediaPlayerModel( --gmod
  "(GMod) Portal Radio",
  "models/props/radio_reference.mdl",
  {
    angle  = Angle(-90, 90, 0),
    offset = Vector(3.6,2,5),
    width  = 4,
    height = 3
  }
)

if SERVER then
  -- Place mediaplayer toward player. This also fixes base mediaplayer behavior. Requested by Cyan.
  hook.Remove( "PlayerSpawnedSENT", "MediaPlayer.Extended.Setup" ) -- Remove hook and set a new one
  hook.Add( "PlayerSpawnedSENT", "MediaPlayer.Extended.Setup", function(ply, ent)
    if(not ent) then return end -- Skip missing entities from triggering spawns
    if(not ent:IsValid()) then return end -- Skip also invalid entities
    if(not ent.IsMediaPlayerEntity) then return end -- Not MP complaint
    local mod = ent:GetModel() -- Model is the list index hash
    local cnf = list.GetForEdit("MediaPlayerModelConfigs")[mod]

    -- Model does not persist in the list. Nothing to do
    if(not cnf) then return end

    -- Do nothing for other models and setup only ours
    if(not cnf.extended) then return end

    -- Fix for media player owner not getting set on alternate model spawn
    ent:SetCreator(ply)

    local mp = ent:GetMediaPlayer()
    if(mp) then mp:SetOwner(ply) end

    if(ply.AdvDupe2) then -- Do not rotate when pasting dupe
      if(ply.AdvDupe2.Pasting or ply.AdvDupe2.Downloading) then return end
    end

    -- Make sure we ignore the player and spawned entity for trace
    local dt = util.GetPlayerTrace(ply) -- Create trace data filtered
    dt.filter = {ply, ent} -- Otherwise we hit the player being spawned

    -- Run the trace with this filter and find real spawn position
    local tr = util.TraceLine(dt) -- Does not belong on the spawn entity

    if(not tr) then return end -- Trace does not exist
    if(not tr.Hit) then return end -- Trace did not hit anything

    SetFacePosition(ent, ply:EyePos(), tr.HitNormal, tr.HitPos, cnf.aface)
  end)
end