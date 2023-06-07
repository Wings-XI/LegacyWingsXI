-----------------------------------
-- Area: Walk of Echoes
--  Mob: Cait Sith
-----------------------------------
mixins = {require("scripts/mixins/families/avatar_prime")}
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setModelId(28) -- copied modelid from cait sith pet since db value has bunk animations
end

function onMobEngaged(mob, player)
    mob:messageName(ID.text.CAIT_ENGAGE, mob)
end

function onMobFight(mob, player)
end

function onMobDeath(mob, player, isKiller)
    if player then
        player:messageSpecial(ID.text.CAIT_DEAD)
    end
end
