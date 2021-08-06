-----------------------------------
-- Area: Sealions Den
--  Mob: Mammet-22 Zeta
-----------------------------------
local ID = require("scripts/zones/Sealions_Den/IDs")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRES, 95)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 50)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 50)
    mob:setLocalVar("onDeath", 0)
end

function changeForm(mob)
    local newform = math.random(0, 2)
    if (mob:AnimationSub() == newform) then
        newform = 3
    end
    
    if (newform == 0) then -- Hand Form, ~3s delay
        mob:SetMagicCastingEnabled(false)
        mob:setDelay(2400)
        mob:setDamage(80)
    elseif (newform == 1) then -- Sword Form, ~2s delay, melee hits for ~50-100 vs WHM/BLM w/o buffs, 40 DMG seems to work.
        mob:SetMagicCastingEnabled(false)
        mob:setDelay(1500)
        mob:setDamage(80)
    elseif (newform == 2) then -- Polearm Form, ~3-3.5s delay, melee hits for ~100-150.  Takes about 70-80 DMG to make this happen.
        mob:SetMagicCastingEnabled(false)
        mob:setDelay(3250)
        mob:setDamage(150)
    elseif (newform == 3) then -- Staff Form, ~4s delay, ~10 seconds between spell ends and next cast
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
        mob:SetMagicCastingEnabled(true)
        mob:setDelay(3700)
        mob:setDamage(80)
    end
    mob:AnimationSub(newform)
    mob:setLocalVar('changeTime', mob:getBattleTime())
end

function onMobFight(mob, target)
    local form = mob:AnimationSub()
    -- Mammets seem to be able to change to any given form, per YouTube videos
    -- Added a random chance to change forms every 3 seconds if 60 seconds have passed, just to make things less formulaic.
        -- May be able to change forms more often.  Witnessed one at ~50 seconds, most were 60-80.
        -- Believe it or not, these changes may be too slow @ 50% chance.  Probability is a pain.
    -- L40 means their "weapons" are 40 DMG by default.
    if ((mob:getBattleTime() > mob:getLocalVar('changeTime') + 60 or mob:getLocalVar('changeTime') == 0) and math.random(0, 1) == 1
        and not mob:hasStatusEffect(tpz.effect.FOOD)) then
        changeForm(mob)
    end
end

function onMobDeath(mob, player, isKiller)
    -- find mob offset for given battlefield instance
    local inst = mob:getBattlefield():getArea()
    local instOffset = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (inst - 1))
    local onDeath = mob:getLocalVar("onDeath")
    if mob:getLocalVar("onDeath") == 1 then
        return
    end
    -- if all five mammets in this instance are dead, start event
    local allMammetsDead = true
    for i = instOffset + 0, instOffset + 4 do
        if not GetMobByID(i):isDead() then
            allMammetsDead = false
            break
        end
    end
    if allMammetsDead then
        for _, player in ipairs(mob:getBattlefield():getPlayers()) do
            player:startEvent(11)
        end
    end
    mob:setLocalVar("onDeath", 1)
end

function onEventFinish(player, csid, option)
    if csid == 11 then
        local battlefield = player:getBattlefield()
        local inst = battlefield:getArea()
        -- players are healed in between fights, but their TP is set to 0
        player:addTitle(tpz.title.BRANDED_BY_LIGHTNING)
        player:setHP(player:getMaxHP())
        player:setMP(player:getMaxMP())
        player:setTP(0)
        player:setLocalVar("[OTBF]cs", 1)
        battlefield:setLocalVar("event1", 1)
    end
end
