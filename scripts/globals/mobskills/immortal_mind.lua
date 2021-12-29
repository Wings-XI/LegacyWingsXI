---------------------------------------------
-- Immortal Mind
-- Enhances Magic Attack and Magic Defense
-- ToDo: Consider making this a single effect so dispel catches both (assuming a capture supports that)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    if (not mob:hasStatusEffect(tpz.effect.MAGIC_ATK_BOOST)) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobBuffMove(mob, tpz.effect.MAGIC_ATK_BOOST, 20, 0, 180))
    mob:addStatusEffect(tpz.effect.MAGIC_DEF_BOOST, 20, 0, 180)
    return tpz.effect.MAGIC_ATK_BOOST
end
