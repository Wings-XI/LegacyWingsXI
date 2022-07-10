---------------------------------------------------
-- Nightmare
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill, summoner)
    local mpCost = 42
    if target:isUndead() and target:getFamily() ~= 52 and target:getFamily() ~= 121 then -- non-ghost undead
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return tpz.effect.SLEEP_I
    end

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return tpz.effect.SLEEP_I
    end

    local dINT = pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)

    local effect = tpz.effect.SLEEP_I
    local resist = applyPlayerResistance(pet,-1,target, dINT, -5, tpz.magic.ele.DARK)

    local duration = math.ceil(60 + math.floor(31*math.random()) * resist * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target)) -- wiki: duration variable from 30 to 90. can be thought of random 60-90 with possible half resist making it range 30-90
    if resist >= 0.5 then
        target:delStatusEffectSilent(effect)
        target:delStatusEffectSilent(tpz.effect.LULLABY)
        target:delStatusEffectSilent(tpz.effect.BIO)
        local summoningskill = 100
        local dotdmg = math.floor((summoningskill + 29) / 40)
        if summoner ~= nil then
            summoningskill = summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
        end
        if not (target:hasImmunity(1) or hasSleepEffects(target)) and target:addStatusEffect(effect, 1, 0, duration * resist, 25, 25, 1) then -- subid/subpower for poison detection on wakup function
            target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 15, 2)
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
