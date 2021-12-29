---------------------------------------------
-- Frog Cheer
-- Increases magical attack and grants Elemental Seal tpz.effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:hasStatusEffect(tpz.effect.MAGIC_ATK_BOOST) == false) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.MAGIC_ATK_BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, 25, 0, 300))
    mob:addStatusEffect(tpz.effect.ELEMENTAL_SEAL, 1, 0, 60)
    return typeEffect
end
