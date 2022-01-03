---------------------------------------------
-- Difusion Ray
-- Description: Deals damage to enemies within a fan-shaped area originating from the caster.
-- Type: Magical Light (Element)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- only used if target is in front of the mob
    if (target:isInfront(mob)) then
        return 0
    end
    return 1

end

function onMobWeaponSkill(target, mob, skill)
    local cap = 700

    -- Nyzul Isle Racing Chariots
    if (mob:getID() >= 17092994 and mob:getID() <= 17092998) then
        -- reducing cap and raising base dmg
        cap = 500
    end

    -- dmg is mob HP *.5 + Mob Level
    local dmgmod = MobBreathMove(mob, target, .5, 1, tpz.magic.ele.LIGHT, cap)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.damageType.BREATH, tpz.attackType.LIGHT, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.LIGHT)

    return dmg
end
