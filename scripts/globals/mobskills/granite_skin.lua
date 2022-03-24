---------------------------------------------
-- Granite Skin
-- Gives Undispellable Physical Immunity for the front Arc
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- power 3 PHYSICAL_SHIELD grants 100% guard rate and guard dmg reduction
    mob:addStatusEffectEx(tpz.effect.PHYSICAL_SHIELD, 0, 3, 0, 60)
    mob:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    skill:setMsg(tpz.msg.basic.NONE)
    return typeEffect
end