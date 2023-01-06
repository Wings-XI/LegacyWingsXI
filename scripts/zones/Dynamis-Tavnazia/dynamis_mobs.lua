-----------------------------------
--
-- Dynamis-Tavnazia
--
--[[
    Resources:
    https://enedin.be/dyna/html/zone/tav.htm
    https://enedin.be/dyna/html/zone/frame_tav.htm
    https://www.dynamisbums.com/strategy/tav.html
]]
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_TAVNAZIA

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] = 
{
    -- floor 0
    [16949255] = { id =  16949255 }, -- Nightmare Bugard ( 001 )

    -- floor 1
    [16949257] = { id =  16949257}, -- Nightmare Worm ( 002 )
    [16949269] = { id = 16949269}, -- wave 1 floor 1 vanguard eye qm3
    [16949270] = { id = 16949270}, -- wave 1 floor 1 vanguard eye qm3
    [16949271] = { id = 16949271}, -- wave 1 floor 1 vanguard eye
    [16949272] = { id = 16949272}, -- wave 1 floor 1 vanguard eye
    [16949289] = { id = 16949289}, -- wave 1 floor 1 vanguard eye
    [16949290] = { id = 16949290}, -- wave 1 floor 1 vanguard eye
    [16949291] = { id = 16949291}, -- wave 1 floor 1 vanguard eye
    [16949292] = { id = 16949292}, -- wave 1 floor 1 vanguard eye
    [16949303] = { id = 16949303}, -- wave 2 floor 1 vanguard eye
    [16949304] = { id = 16949304}, -- wave 2 floor 1 vanguard eye
    [16949305] = { id = 16949305}, -- wave 2 floor 1 vanguard eye
    [16949306] = { id = 16949306}, -- wave 2 floor 1 vanguard eye
    [16949322] = { id = 16949322}, -- wave 2 floor 1 vanguard eye
    [16949323] = { id = 16949323}, -- wave 2 floor 1 vanguard eye
    [16949324] = { id = 16949324}, -- wave 2 floor 1 vanguard eye



    -- floor 2
    [16949256] = { id =  16949256}, -- Nightmare Antlion ( 003 )
    [16949325] = { id = 16949325}, -- wave 1 floor 2 vanguard eye qm3
    [16949356] = { id = 16949356}, -- wave 1 floor 2 vanguard eye qm3
    [16949357] = { id = 16949357}, -- wave 1 floor 2 vanguard eye
    [16949358] = { id = 16949358}, -- wave 1 floor 2 vanguard eye
    [16949362] = { id = 16949362}, -- wave 1 floor 2 vanguard eye
    [16949363] = { id = 16949363}, -- wave 1 floor 2 vanguard eye
    [16949364] = { id = 16949364}, -- wave 1 floor 2 vanguard eye
    [16949369] = { id = 16949369}, -- wave 1 floor 2 vanguard eye
    [16949370] = { id = 16949370}, -- wave 1 floor 2 vanguard eye
    [16949371] = { id = 16949371}, -- wave 1 floor 2 vanguard eye
    [16949376] = { id = 16949376}, -- wave 1 floor 2 vanguard eye
    [16949377] = { id = 16949377}, -- wave 1 floor 2 vanguard eye
    [16949378] = { id = 16949378}, -- wave 2 floor 2 vanguard eye
    [16949379] = { id = 16949379}, -- wave 2 floor 2 vanguard eye
    [16949380] = { id = 16949380}, -- wave 2 floor 2 vanguard eye
    [16949381] = { id = 16949381}, -- wave 2 floor 2 vanguard eye
    [16949382] = { id = 16949382}, -- wave 2 floor 2 vanguard eye
    [16949383] = { id = 16949383}, -- wave 2 floor 2 vanguard eye
    [16949384] = { id = 16949384}, -- wave 2 floor 2 vanguard eye
    [16949385] = { id = 16949385}, -- wave 2 floor 2 vanguard eye
    [16949386] = { id = 16949386}, -- wave 2 floor 2 vanguard eye



    -- All children

}

mobList[zone].zoneID = zone

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
-- Floor 0
mobList[zone][16949255].pos = { 23.871, -12.546, 44.276, 141     } -- nightmare bugard
-- Floor 1
mobList[zone][16949257].pos = {  1.000, -23.351, 25.521, 110     } -- nightmare worm
mobList[zone][16949269].pos = { -0098.0, -0027.0,0008.4,195   } -- floor 1 vanguard eye qm3
mobList[zone][16949270].pos = { -0098.0, -0027.0,-0006.4,060   } -- floor 1 vanguard eye qm3
mobList[zone][16949271].pos = { -0078.0, -0021.5,0054.5,056   } -- floor 1 vanguard eye
mobList[zone][16949272].pos = { -0096.0, -0027.0,0041.3,063   } -- floor 1 vanguard eye
mobList[zone][16949289].pos = { -0110.0, -0027.0,0042.0,048   } -- floor 1 vanguard eye
mobList[zone][16949290].pos = { -0079.0, -0022.0,-0050.5,202   } -- floor 1 vanguard eye
mobList[zone][16949291].pos = { -0097.8, -0027.0,-0049.0,189   } -- floor 1 vanguard eye
mobList[zone][16949292].pos = { 0012.0, -0027.0,-0047.5,196   } -- floor 1 vanguard eye
mobList[zone][16949303].pos = { -0098.0, -0027.0,0008.4,195   } -- floor 1 vanguard eye
mobList[zone][16949304].pos = { -0098.0, -0027.0,-0006.4,060   } -- floor 1 vanguard eye
mobList[zone][16949305].pos = { -0078.0, -0021.5,0054.5,195   } -- floor 1 vanguard eye
mobList[zone][16949306].pos = { -0096.0, -0027.0,0041.3,191   } -- floor 1 vanguard eye
mobList[zone][16949322].pos = { -0110.0, -0027.0,0042.0,176   } -- floor 1 vanguard eye
mobList[zone][16949323].pos = { -0079.0, -0022.0,-0050.5,074   } -- floor 1 vanguard eye
mobList[zone][16949324].pos = { -0097.8, -0027.0,-0049.0,061   } -- floor 1 vanguard eye

-- Floor 2
mobList[zone][16949256].pos = { 17    ,     -36,     19,   0     } -- nightmare antlion
mobList[zone][16949325].pos = { 0098.0, -0041.0,0006.0,188   } -- floor 2 vanguard eye qm3
mobList[zone][16949356].pos = { 0098.0, -0041.0,-0006.0,063   } -- floor 2 vanguard eye qm3
mobList[zone][16949357].pos = { 0078.0, -0038.0,0029.0,161   } -- floor 2 vanguard eye
mobList[zone][16949358].pos = { 0080.0, -0036.0,0044.0,126   } -- floor 2 vanguard eye
mobList[zone][16949362].pos = { 0076.0, -0034.0,0069.0,058   } -- floor 2 vanguard eye
mobList[zone][16949363].pos = { 0097.5, -0041.0,0047.5,066   } -- floor 2 vanguard eye
mobList[zone][16949364].pos = { 0114.8, -0041.0,0050.0,075   } -- floor 2 vanguard eye
mobList[zone][16949369].pos = { 0081.0, -0038.0,-0030.5,097   } -- floor 2 vanguard eye
mobList[zone][16949370].pos = { 0080.0, -0036.0,-0045.0,125   } -- floor 2 vanguard eye
mobList[zone][16949371].pos = { 0078.5, -0034.0,-0067.0,189   } -- floor 2 vanguard eye
mobList[zone][16949376].pos = { 0096.0, -0041.0,-0045.7,185   } -- floor 2 vanguard eye
mobList[zone][16949377].pos = { 0113.0, -0041.0,-0047.0,181   } -- floor 2 vanguard eye
mobList[zone][16949378].pos = { 0078.0, -0038.0,0029.0,186   } -- floor 2 vanguard eye
mobList[zone][16949379].pos = { 0080.0, -0036.0,0044.0,194   } -- floor 2 vanguard eye
mobList[zone][16949380].pos = { 0076.0, -0034.0,0069.0,203   } -- floor 2 vanguard eye
mobList[zone][16949381].pos = { 0097.5, -0041.0,0047.5,225   } -- floor 2 vanguard eye
mobList[zone][16949382].pos = { 0114.8, -0041.0,0050.0,253   } -- floor 2 vanguard eye
mobList[zone][16949383].pos = { 0081.0, -0038.0,-0030.5,061   } -- floor 2 vanguard eye
mobList[zone][16949384].pos = { 0080.0, -0036.0,-0045.0,057   } -- floor 2 vanguard eye
mobList[zone][16949385].pos = { 0078.5, -0034.0,-0067.0,053   } -- floor 2 vanguard eye
mobList[zone][16949386].pos = { 0096.0, -0041.0,-0045.7,058   } -- floor 2 vanguard eye




-- -- set statue eye color
-- mobList[zone][SMB+75 ].eyes = dynamis.eyes.BLUE
-- mobList[zone][SMB+76 ].eyes = dynamis.eyes.GREEN
-- mobList[zone][SMB+25 ].eyes = dynamis.eyes.BLUE

-- set time extensions (two others are received in qm3.lua)
mobList[zone][16949255].timeExtension = 15 -- bugard
mobList[zone][16949256].timeExtension = 30 -- antlion

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements    = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty

-- set which waves this monster will spawn on (can be multiple)
-- wave 1: initial mobs
mobList[zone][16949255].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949257].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949256].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949269].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949270].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949271].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949272].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949289].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949290].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949291].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949292].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949303].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949304].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949305].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949306].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949322].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949323].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949324].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949325].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949356].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949357].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949358].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949362].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949363].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949364].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949369].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949370].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949371].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949376].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949377].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949378].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949379].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949380].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949381].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949382].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949383].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949384].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949385].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949386].waves = { nil, nil, 3, nil, nil }


-- Wave 2: floor 1 qm3
--mobList[zone][DMB+51 ].waves = { nil, 2, nil, nil, nil }
-- Wave 3: floor 2 qm3
--mobList[zone][SMB+55 ].waves = { nil, nil, 3, nil, nil }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- mobList[zone][SMB+1  ].specificChildren = { SMB+2, SMB+3, SMB+4 } -- example
-- Floor 1
-- Hornet
-- mobList[zone][DMB+51 ].specificChildren = { true, DMB+54, DMB+55                                                    }
-- Leech
-- Makara
-- Hydra

-- Floor 2
-- Hornet
-- mobList[zone][DMB+51 ].specificChildren = { true, DMB+54, DMB+55                                                    }
-- mobList[zone][SMB+494].randomChildrenCount = 6
-- mobList[zone][SMB+4  ].randomChildrenList = { 6 }
-- Cluster
-- Hydra

-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
randomChildrenList[zone] = 
{
    -- hornets
    [1] =
    {

    },
    -- clusters
    [2] =
    {

    },
    -- leech
    [3] =
    {

    },
    -- makara
    [4] =
    {

    },
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] = 
{

}