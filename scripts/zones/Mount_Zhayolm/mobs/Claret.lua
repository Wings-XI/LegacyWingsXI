-----------------------------------
-- Area: Mount Zhayolm
--  ZNM T1: Claret
-- !pos 501 -9 53
-- Spawned with Pectin: !additem 2591
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Claret
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:addMod(tpz.mod.REGEN, math.floor(mob:getMaxHP()*.004))
    mob:addMod(tpz.mod.BINDRES, 40)
    mob:addMod(tpz.mod.MOVE, 25) -- 25% faster than a player
    mob:SetAutoAttackEnabled(false)
    mob:setMobMod(tpz.mobMod.ENCROACH_PLAYER, 1)
    mob:addMod(tpz.mod.REGAIN, 100) -- can be seen TPing with little to no interaction from players
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMod(tpz.mod.UDMGMAGIC, 50)
end

function onMobFight(mob, target)
    if mob:checkDistance(target) < 3 then
        if not target:hasStatusEffect(tpz.effect.POISON) then
            target:addStatusEffect(tpz.effect.POISON, 100, 3, math.random(3, 5) * 3) -- Poison for 3-6 ticks.
        else
            if target:getStatusEffect(tpz.effect.POISON):getPower() < 100 then
                target:delStatusEffect(tpz.effect.POISON)
                target:addStatusEffect(tpz.effect.POISON, 100, 3, math.random(3, 5) * 3) -- Poison for 3-6 ticks.
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
