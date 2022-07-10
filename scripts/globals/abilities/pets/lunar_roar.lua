---------------------------------------------
-- lunar roar
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 27

    if applyResistanceAbility(pet, target, tpz.magic.ele.DARK, tpz.skill.ENFEEBLING_MAGIC, 0) > 0.25 then
        target:dispelStatusEffect()
    end
    if applyResistanceAbility(pet, target, tpz.magic.ele.DARK, tpz.skill.ENFEEBLING_MAGIC, 0) > 0.25 then
        target:dispelStatusEffect()
    end
    skill:setMsg(tpz.msg.basic.NONE)

    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return 0
end
