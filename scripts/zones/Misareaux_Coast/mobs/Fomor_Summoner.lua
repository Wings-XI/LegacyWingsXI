-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Fomor Summoner
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local petID = mob:getID() + 1
    DespawnMob(petID)
end