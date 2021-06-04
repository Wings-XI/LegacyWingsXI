-----------------------------------
-- Area: Quicksand Caves
--  Mob: Ancient Vessel
-- Mithra and the Crystal (Zilart 12) Fight
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL and player:getCharVar("ZilartStatus") == 1) then
        player:needToZone(true)
        player:setCharVar("AncientVesselKilled", 1)
    end
end
