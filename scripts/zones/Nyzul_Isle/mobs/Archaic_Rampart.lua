-----------------------------------
-- Area: Nyzul Isle
--  Mob: Archaic Rampart
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN_FRONT, 1)
    if (mob:getID() == 17092629 or mob:getID() == 17092630) then
        -- Ramparts in Nyzul Isle Investigation always have their doors open
        -- This will prevent them from using Choke Chain and Roller Chain
        mob:AnimationSub(1)
    end
end

function onMobDeath(mob, player, isKiller)
end