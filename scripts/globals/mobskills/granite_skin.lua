---------------------------------------------
-- Granite Skin
-- Gives Undispellable Defense Boost and Guard\Parry Boost
-- TODO: Needs to be limited to front damage only, currently not implemented
-- TODO: Add Parry\Guard rate up
-- TODO: Cannot dispel
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    mob:addStatusEffectEx(tpz.effect.PHYSICAL_SHIELD, 0, 1, 0, 20)

    return typeEffect
end