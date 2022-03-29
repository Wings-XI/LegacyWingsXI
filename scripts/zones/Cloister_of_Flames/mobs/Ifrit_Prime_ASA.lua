-----------------------------------
-- Area: Cloister of Flames
--  Mob: Ifrit Prime
-- Involved in Mission: ASA-4 Sugar Coated Directive
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    -- ASA-4: Avatar is Unkillable Until Its Used Astral Flow At Least 5 times At Specified Intervals
    mob:setLocalVar("astralflows", 0)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
    local astralFlows = mob:getLocalVar("astralflows")
    -- ASA-4: Astral Flow Behavior - Guaranteed to Use At Least 5 times before killable, at specified intervals.
    if mob:getCurrentAction() == tpz.act.ATTACK then
        if astralFlows == 0 and mob:getHPP() <= 80 then
            print("Astral flow")
            mob:useMobAbility(848)
            mob:setLocalVar("astralflows", astralFlows + 1)
        elseif astralFlows == 1 and mob:getHPP() <= 60 then
            mob:useMobAbility(848)
            mob:setLocalVar("astralflows", astralFlows + 1)
        elseif astralFlows == 2 and mob:getHPP() <= 40 then
            mob:useMobAbility(848)
            mob:setLocalVar("astralflows", astralFlows + 1)
        elseif astralFlows == 3 and mob:getHPP() <= 20 then
            mob:useMobAbility(848)
            mob:setLocalVar("astralflows", astralFlows + 1)
        elseif astralFlows == 4 and mob:getHPP() <= 1 then
            mob:setLocalVar("astralflows", astralFlows + 1)
            mob:useMobAbility(848)
        end
    end

    if astralFlows >= 5 and utils.canUseAbility(mob) == true then
        mob:setUnkillable(false)
    end
end

function onMobDeath(mob, player, isKiller)
    local players = player:getBattlefield():getPlayers()
    for _, member in pairs(players) do
        member:setCharVar("ASA_Ifrit", 2)
    end
end
