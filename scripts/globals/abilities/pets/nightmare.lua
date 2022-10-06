---------------------------------------------------
-- Nightmare - Player's Avatar
-- AoE Sleep
-- Sleep that is not broken from DoT effects (any dmg source that doesn't break bind). 
-- + I.e. if a mob has helix, nightmare will still sleep the target
-- When this sleep is applied, it is accompanied by a Bio effect. That Bio effect doesn't break _any_ types of sleep
-- + I.e. if you nightmare a mob, then layer sleep II, the mob will stay asleep
-- The Bio does that by explicitly dealing lua dmg with the `wakeUp` flag set to false.
--  
-- There's a hard max of 9 for the subpower of this sleep effect
-- This is so there's zero chance to accidentially flag this sleep as the NM version:
-- + A more powerful version of Nightmare is used by the NM version of Diabolos. More information is provided in mobskills/nightmare.lua
-- 
-- Note that the sleep effect is not the thing doing damage. When nightmare is applied, you also get a Bio effect
-- if you erase the bio effect, the Sleep (with a subeffect of Bio) still behaves exactly the same as before
-- The AMOUNT of damage done to the target is irrelevant to the behavior of nightmare sleep, only the source of the damage.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill, summoner)
    local mpCost = 42
    local summoningskill = 100
    local dINT = pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local effect = tpz.effect.SLEEP_I
    local subeffect = tpz.effect.BIO
    local accuracy = -5

    if summoner ~= nil then
        summoningskill = summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
        accuracy = accuracy + math.floor((getSummoningSkillOverCap(pet)/2)) -- No real source for this, please confirm.
    end
    
    -- don't reach 10, as this (being >= 10) signals it's from diabolos NM and makes wakeUp much more difficult
    -- see abilities/pets/nightmare.lua and the header above for more information
    local dotdmg = math.min(math.floor((summoningskill + 29) / 40), 9) -- Where does this come from!? Seems to be as effective as Bio 2 at higher levels.

    if target:isUndead() and target:getFamily() ~= 52 and target:getFamily() ~= 121 then -- non-ghost undead
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return effect
    end

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return effect
    end

    local resist = applyPlayerResistance(pet, -1, target, dINT, accuracy, tpz.magic.ele.DARK)
    local duration = math.random(60,90) * resist * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target) -- wiki: duration variable from 30 to 90. can be thought of random 60-90 with possible half resist making it range 30-90

    if resist >= 0.5 and not target:hasImmunity(1) then
        target:delStatusEffectSilent(effect)
        target:delStatusEffectSilent(tpz.effect.LULLABY)
        
        -- sleep with subid = tpz.effect.BIO for DoT detection on wakup check in lua_baseentity.cpp 
        -- WINGSTODO Fix upstream
        if not hasSleepEffects(target) and target:addStatusEffect(effect, 15, 3, duration, subeffect, dotdmg, 1) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end
    
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return effect
end
