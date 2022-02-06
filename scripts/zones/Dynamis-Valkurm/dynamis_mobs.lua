-----------------------------------
--
-- Dynamis-Valkurm
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_VALKURM
local DMB = 16936961 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 16937208 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] = 
{
    -- [12345678] = { id =  DMB+0 }, -- example
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_VALKURM

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
-- mobList[zone][SMB+1  ].pos = { 81.7644, 0.0000, -71.8662, 0   } -- example

-- instead of standing still, i will patrol across these given points (triplets of x,y,z)
-- todo: this is not yet functional, this will most likely use dynamis.mobOnRoamAction
-- mobList[zone][SMB+1].path = { 11, 22, 33, 66, 77, 88, }

-- set statue eye color
-- mobList[zone][SMB+1  ].eyes = dynamis.eyes.RED -- example

-- set time extensions
-- mobList[zone][SMB+1  ].timeExtension = 30 -- example

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
-- mobList[zone].waveDefeatRequirements[2] = { DMB+10, DMB+20, DMB+30, DMB+40 } -- example of 4 bosses
-- mobList[zone].waveDefeatRequirements[3] = { SMB+1 } -- example of mega boss for respawns

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
-- mobList[zone][SMB+1  ].waves = {  1 ,nil,nil } -- example

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- mobList[zone][SMB+1  ].specificChildren = { SMB+2, SMB+3, SMB+4 } -- example

-- set how many random children i will spawn when i engage
-- mobList[zone][SMB+1  ].randomChildrenCount = 3 -- example

-- set my random children list i will pick from
-- mobList[zone][SMB+1  ].randomChildrenList = 1 -- example

-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
randomChildrenList[zone] = 
{
    [1] =
    {
        -- 12345678, -- example
        -- 23456789, -- example
    }
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] = 
{
    
}