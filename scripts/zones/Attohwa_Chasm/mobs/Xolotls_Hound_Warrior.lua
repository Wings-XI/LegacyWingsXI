-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Hound Warrior
-- Note: Pet for Xolotl
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
-----------------------------------

function onMobRoam(mob)
    local totd = VanadielTOTD()
    
    if totd ~= 1 and totd ~= 7 then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
end