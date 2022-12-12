-----------------------------------
-- Area: Caedarva Mire
--  Mob: Merrow Typhoondancer
-- Author: Spaceballs
-- Note: Minion of Experimental Lamia
-----------------------------------
mixins ={require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Caedarva_Mire/IDs")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobDeath(mob, player, isKiller)
    local mother = GetMobByID(ID.mob.EXPERIMENTAL_LAMIA)
    local dance = mother:getLocalVar("dances")  
    mother:setLocalVar("dances", dance + 1)
end

function onMobFight(mob, target)
    local mother = GetMobByID(ID.mob.EXPERIMENTAL_LAMIA)
    -- adjust target if mother has enough hate?
end

function onMobRoam(mob)
    local mother = GetMobByID(ID.mob.EXPERIMENTAL_LAMIA)
    if mother:isSpawned() and mother:getCurrentAction() == tpz.act.ATTACK then
        mob:updateEnmity(mother:getTarget())
    end
end