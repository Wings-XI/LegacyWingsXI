-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Ouryu summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
mixins = {require("scripts/mixins/families/wyrm_wakeup")}
-----------------------------------

local offsets = {4, 5, 6, 7}

function onMobSpawn(mob)
    mob:SetMobSkillAttack(0)            
    mob:AnimationSub(0)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar("savageDmgMultipliers", 1)
    mob:setLocalVar("twoHour", 0)

    -- mods put fight in line with retail difficulty
    mob:addMod(tpz.mod.SLEEPRES, 100)
    mob:addMod(tpz.mod.LULLABYRES, 100)
    mob:addMod(tpz.mod.EARTHRES, 1000)
    mob:addMod(tpz.mod.BLINDRESTRAIT, 25)
    mob:addMod(tpz.mod.PARALYZERESTRAIT, 25)
    mob:addMod(tpz.mod.STUNRES, 100)
    mob:addMod(tpz.mod.MDEF, 100)
    mob:setMod(tpz.mod.UDMGRANGE, -50)
    mob:setMod(tpz.mod.MATT, -100)
    SpawnMob(16896166)
    SpawnMob(16896167)
end

--Ouryu cuts remote and magic damage by 50% and has the ability to fly.

function onMobFight(mob, target)
    -- use 2hr
    if (mob:AnimationSub() == 2 and mob:getLocalVar("twoHour") == 0 and mob:getHPP() < 75) then
        mob:useMobAbility(694)
        mob:setLocalVar("twoHour", 1)
    end

    if (mob:hasStatusEffect(tpz.effect.INVINCIBLE) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        
        -- first flight
        if (mob:AnimationSub() == 0 and not hasSleepEffects(mob) and mob:getBattleTime() - changeTime > 60) then   
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- land
        elseif (mob:AnimationSub() == 1 and mob:getBattleTime() - changeTime > 120) then
            mob:useMobAbility(1302)                
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- fly
        elseif (mob:AnimationSub() == 2 and not hasSleepEffects(mob) and mob:getBattleTime() - changeTime > 120) then   
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end

    local delay = mob:getLocalVar("delay")
    if (delay > 120) then -- Summon Ziryu every 60s, this is a guess until we get a capture
        mob:setLocalVar("delay", 0)

        local mobId = mob:getID()
        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)

            if not pet:isSpawned() then
                    pet:spawn(60)
                    local pos = mob:getPos()
                    pet:setPos(pos.x + math.random(2, 6), pos.y, pos.z + math.random(2, 6))
                    pet:updateEnmity(mob:getTarget()) 
                break
            end
        end

    else
        mob:setLocalVar("delay", delay+1)
    end
end

-- Prevents any stuck logic due to wipes
function onMobDisengage(mob)
    mob:setLocalVar("changeTime", 0) 
end

function onMobDeath(mob, player, isKiller)
end
