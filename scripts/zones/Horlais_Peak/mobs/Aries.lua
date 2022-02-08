-----------------------------------
-- Area: Horlais Peak
--  Mob: Aries
-- BCNM: Today's Horoscope
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/mobs")
require("scripts/globals/status")
local ID = require("scripts/zones/Horlais_Peak/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 35)
    mob:setMobMod(tpz.mobMod.MAGIC_DELAY, 5)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 75)
    mob:setMobMod(tpz.mobMod.BUFF_CHANCE, 50)
    mob:setMobMod(tpz.mobMod.HEAL_CHANCE, 0)
    mob:setMod(tpz.mod.STR, -15)
    mob:setMod(tpz.mod.ATT, 215) -- Damage should be ~120-140 on a 75 RDM with 326 DEF
end

function onMobFight(mob, target)
    local Sleepy = mob:getLocalVar("SleepyTime")
    local WakeyTime = mob:getLocalVar("Wakey")

    if Sleepy == 1 then
        SleepyHead(mob)
        mob:setLocalVar("SleepyTime", 2)
    end

    if Sleepy == 2 or mob:hasStatusEffect(tpz.effect.SLEEP_I) or mob:hasStatusEffect(tpz.effect.SLEEP_II) or mob:hasStatusEffect(tpz.effect.LULLABY) then
        mob:setMod(tpz.mod.REGEN, math.random(50,150))
        mob:setMod(tpz.mod.REGAIN, 500)
    end

    if mob:checkDistance(target) > 20 and mob:getLocalVar("SleepyTime") == 0 and mob:getBattleTime() > WakeyTime then
        mob:setLocalVar("SleepyTime", 1)
    end

    mob:addListener("EFFECT_LOSE", "SLEEP_EFFECT_LOSE", function(mob, effect) 
        if effect:getType() == tpz.effect.SLEEP_I or effect:getType() == tpz.effect.SLEEP_II or effect:getType() == tpz.effect.LULLABY then
            mob:setLocalVar("SleepyTime", 0)
            mob:setLocalVar("Wakey", mob:getBattleTime() + 5)
            mob:setMod(tpz.mod.REGEN, 0)
            mob:setMod(tpz.mod.REGAIN, 0)
        end
    end) 
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 269 then
        mob:setLocalVar("SleepyTime", 1)
    end
end

function onMonsterMagicPrepare(mob, target)
    if mob:hasStatusEffect(tpz.effect.STONESKIN) then
        return 356
    end
end

function onMobDeath(mob, player, isKiller)
end

function SleepyHead(mob)
    mob:showText(mob, ID.text.DEEP_SLEEP)
    mob:addStatusEffect(tpz.effect.SLEEP_II, 1, 0, 300)
end