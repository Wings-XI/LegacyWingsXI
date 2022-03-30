---------------------------------------------
-- Diamond Shell
-- Gives Undispellable Physical Immunity for attacks from behind
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- power 4 PHYSICAL_SHIELD grants physical immunity to damage in the rear cone
    mob:addStatusEffectEx(tpz.effect.PHYSICAL_SHIELD, 0, 4, 0, 60)
    mob:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    skill:setMsg(tpz.msg.basic.NONE)
    return typeEffect
end