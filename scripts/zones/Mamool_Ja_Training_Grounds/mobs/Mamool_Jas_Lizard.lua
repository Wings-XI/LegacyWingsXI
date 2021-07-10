-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Lizard
-----------------------------------
-- TODO mixins = {require("scripts/mixins/pet_instanced")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("masterID", mob:getID() -1)
end

function onMobDeath(mob, player, isKiller)
end
