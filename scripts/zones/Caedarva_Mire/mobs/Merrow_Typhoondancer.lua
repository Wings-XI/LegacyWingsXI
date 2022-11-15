-----------------------------------
-- Area: Caedarva Mire
--  Mob: Merrow Typhoondancer
-- Author: Spaceballs
-- Note: Minion of Experimental Lamia
-----------------------------------
mixins =
    {
        require("scripts/mixins/job_special"),
        require("scripts/mixins/weapon_break")
    }

local ID = require("scripts/zones/Caedarva_Mire/IDs")
 -- Check it uses 2hr

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobDeath(mob, player, isKiller)
    local mother = GetMobByID(ID.mob.EXPERIMENTAL_LAMIA)
    local dance = mother:getLocalVar("dances")  
    mother:setLocalVar("dances", dance + 1)
end
