-----------------------------------
-- Area: Behemoths Dominion
--   NM: Ancient Weapon
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/regimes")
-----------------------------------

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 102, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    if GetMobByID(ID.mob.LEGENDARY_WEAPON):isSpawned() == false then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end