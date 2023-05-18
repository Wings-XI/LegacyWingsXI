---------------------------------------------
--  Pyric Blast
--
--  Description: Deals Fire damage to enemies within a fan-shaped area. Additional effect: Plague
--  Type: Breath
--  Ignores Shadows
--  Range: Unknown Cone
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    --Only used when all 3 heads alive
    if (mob:AnimationSub() == 0 and target:isInfront(mob, 128)) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = MobBreathMove(mob, target, 0.01, 0.1, tpz.magic.ele.FIRE, 700)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)

    MobStatusEffectMove(mob, target, tpz.effect.PLAGUE, 5, 3, 60)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.FIRE)

    if (mob:getFamily() == 313 and bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) == 0) then -- re-enable no turn if all three heads are up
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end

    return dmg
end
