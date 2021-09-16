-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JOL
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_SCALE, 60)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    if (mob:getID() > ID.mob.JAILER_OF_LOVE) then
        local JoL = GetMobByID(ID.mob.JAILER_OF_LOVE)
        local xzomitsKilled = JoL:getLocalVar("JoL_Qn_xzomit_Killed")
        JoL:setLocalVar("JoL_Qn_xzomit_Killed", xzomitsKilled + 1)
    end
end
