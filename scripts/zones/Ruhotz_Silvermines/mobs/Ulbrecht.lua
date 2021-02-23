-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Ulbrecht
-----------------------------------
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
require("scripts/globals/instance")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

-- Try to give him some decent AI
function onMonsterMagicPrepare(mob, target)

    local rnd = math.random()
    local hpp = mob:getHPP()
    -- Survival
    -- If under 30% then 50% chance to cure top priority
    if hpp < 30 and rnd < 0.5 then
        mob:setLocalVar("lastSpellID" 4)
        return 4 -- Cure IV
    end

    -- Buffs
    -- If does not have protect then 90% chance to rebuff
    if not mob:hasStatusEffect(tpz.effect.PROTECT) and rnd < 0.9 then
        return 45
    end
    -- If does not have shell then 20% chance to rebuff
    if not mob:hasStatusEffect(tpz.effect.SHELL) and rnd < 0.25 then
        return 50
    end
    -- If does not have regen then 50% chance to rebuff
    if not mob:hasStatusEffect(tpz.effect.REGEN) and rnd < 0.5 then
        return 110
    end
    
    -- Enfeeble spells (sleep or dispel) 10% chance to cast either
    if rnd < 0.1 then
        return 253 -- sleep
    elseif rnd < 0.2 then
        return 260 -- dispel
    end

    local effects = mob:getStatusEffects()
    local storm = 0
    for _,effect in ipairs(effects) do
        local effectType = effect:getType()
        if (effectType >= tpz.effect.FIRESTORM and effectType <= tpz.effect.VOIDSTORM then
            storm = effectType
            break
        end
    end

    if storm == 0 then
        return determineStorm(hpp, rnd)
    end
    
    -- Offensive spells
    local lastSpellID = mob:getLocalVar("lastSpellID")
    local switch = { -- cast T3 spell, then next time 50/20/30 cast T3/T1/Storm
        [178] = function()	-- FIRESTORM

            if lastSpellID == 146 then -- fire iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.5 then
                    return 144 -- fire i
                end
            end

            return 146 -- fire iii (if not last spell or 60%)
        end,
        [179] = function()	-- HAILSTORM

            if lastSpellID == 151 then -- blizzard iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.5 then
                    return 149 -- blizzard i
                end
            end

            return 151-- blizzard iii (if not last spell or 60%)
        end,
        [180] = function()	-- WINDSTORM

            if lastSpellID == 156 then -- aero iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.5 then
                    return 154 -- aero i
                end
            end

            return 156 -- aero iii (if not last spell or 60%)
        end,
        [181] = function()	-- SANDSTORM
            
            if lastSpellID == 161 then -- stone iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.5 then
                    return 159 -- stone i
                end
            end

            return 161 -- stone iii (if not last spell or 60%)
        end,
        [182] = function()	-- THUNDERSTORM
            
            if lastSpellID == 166 then -- thunder iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.5 then
                    return 164 -- thunder i
                end
            end

            return 166 -- thunder iii (if not last spell or 60%)
        end,
        [183] = function()	-- RAINSTORM
            
            if lastSpellID == 171 then -- water iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.5 then
                    return 169 -- water i
                end
            end

            return 171 -- water iii (if not last spell or 60%)
        end,
        [184] = function()	-- AURORASTORM
            
            if lastSpellID == 4 and rnd < 0.3 then -- 30% chance for new storm if we have already cast cure iv
                return determineStorm(hpp, rnd)
            end

            return 4 -- cure iv
        end,
        [185] = function()	-- VOIDSTORM
            if rnd < 0.9 and (lastSpellID == 245 or lastSpellID == 247) then -- 90% chance to switch storm after use of drain/aspir
                return determineStorm(hpp, rnd)
            end
            if rnd < 0.8 then
                return 245 -- drain 80%
            else
                return 247 -- aspir 20%
            end
        end
    }

    local spellFunc = switch[storm];

    if spellFunc then
        local spellID = spellFunc()
        mob:setLocalVar("lastSpellID", spellID)
        return spellID
    end
    
    return 253 -- sleep (this should never be returned but just in case)
end

function determineStorm(hpp, rnd)
    -- If under 50% hp then 50% chance to buff auroras (will suggest cures)
    if hpp < 50 and rnd < 0.5 then
        return 119
    end

    local stormID = 113 + math.random(0,7)
    if stormID == 120 or stormID == 119 and hpp > 90 then -- dont buff auroras unless missing some HP
        return 99 -- sandstorm 
    else
        return stormID
    end
end

function onMobSpawn(mob)
    mob:setUnkillable(true)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)

    mob:addListener("WEAPONSKILL_STATE_ENTER", "ULBRECHT_WEAPONSKILL", function(mob, skillID)
        local chance = math.random(0,99)

        if skillID < 19 then -- weapon skill
            if chance < 33 then -- 33% chance
                mob:messageText(mob, ID.text.PAINFUL_LESSON)
            end
        else -- ability
            if skillID ~= 2303 and chance < 25 then -- if not dark arts and 25% chance
                mob:messageText(mob, ID.text.ANSWER_THIS)
            end
        end
    end)

    mob:addListener("MAGIC_START", "ULBRECHT_MAGIC_START", function(mob, skillID)
        local chance = math.random(0,99)
        if chance < 50 then
            mob:messageText(mob, ID.text.TRUE_TEACHING)
        end
    end)

    mob:addListener("JOB_SPECIAL_BEG_", "ULBRECHT_TABULA_RASA", function(mob, skillID)
        mob.messageText(mob, ID.text.MOST_IMPRESSIVE)
    end)
end

function onMobFight(mob, player)
    
    local instance = mob:getInstance()
    if (mob:getHPP() <= 20 and instance:completed() == false) then
        mob:messageText(mob, ID.text.STUDENT_BECOME_MASTER)
        instance:complete()
    end
end

function onMobEngaged(mob, target)
    if mob:getLocalVar("dialog") == 0 then
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:messageText(mob, ID.text.MADE_YOUR_PEACE)
        mob:setLocalVar("dialog", 1)

        mob:useMobAbility(2303) -- use dark arts
    end
end