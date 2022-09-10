---------------------------------------------------
-- Nightmare
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
    local accuracy = -5

    if summoner ~= nil then
        summoningskill = summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
        accuracy = math.floor((getSummoningSkillOverCap(pet)/2)-5) -- No real source for this, please confirm.
    end

    if target:isUndead() and target:getFamily() ~= 52 and target:getFamily() ~= 121 then -- non-ghost undead
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return effect
    end

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return effect
    end

    local resist = applyPlayerResistance(pet, -1, target, dINT, accuracy, tpz.magic.ele.DARK)
    local duration = math.ceil(60 + math.floor(31*math.random()) * resist * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target)) -- wiki: duration variable from 30 to 90. can be thought of random 60-90 with possible half resist making it range 30-90

    if resist >= 0.5 then
        target:delStatusEffectSilent(effect)
        target:delStatusEffectSilent(tpz.effect.LULLABY)
        target:delStatusEffectSilent(tpz.effect.BIO)

        local dotdmg = math.floor((summoningskill + 29) / 40) -- Where does this come from!? Seems to be as effective as Bio 2 at higher levels.
        
        ------------------------------------------------------------------------
        ------ Temporarily commenting this out to have it looked at later ------
        ------------------------------------------------------------------------
        -- if not (target:hasImmunity(1) or hasSleepEffects(target)) and target:addStatusEffect(effect, 1, 0, duration, tpz.effect.BIO, 0, 1) then -- subid = tpz.effect.BIO for DoT detection on wakup check in lua_baseentity.cpp
            -- target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration)

        if not (target:hasImmunity(1) or hasSleepEffects(target)) then
            target:addStatusEffect(effect, 1, 0, duration) -- Temporarily working as Sleep 1
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
