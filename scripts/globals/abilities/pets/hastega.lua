---------------------------------------------
-- Hastega
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
require("scripts/globals/summon")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local mpCost = 129
    local bonus = getSummoningSkillOverCap(pet) * 3
    if bonus > 90 then
        bonus = 90
    end
    -- Garuda's Hastega is a weird exception and uses 153/1024 instead of 150/1024 like Haste spell
    -- That's why it overwrites some things regular haste won't.
    target:addStatusEffect(tpz.effect.HASTE, 1494, 0, 90+bonus) -- 153/1024 ~14.94%
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return tpz.effect.HASTE
end
