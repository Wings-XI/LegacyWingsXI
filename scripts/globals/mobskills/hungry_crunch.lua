---------------------------------------------
-- Hungry Crunch
-- Steals HP, TP and food effects from a player.
-- Type: Physical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Notes: Only used by Boggelmann.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dispel = target:dispelStatusEffect(tpz.effectFlag.FOOD)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.7
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:setTP(0)
    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))

    return dmg
end