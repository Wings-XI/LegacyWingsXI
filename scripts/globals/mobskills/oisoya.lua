---------------------------------------------------
--  Oisoya
--  Description: 
--  Type: Weaponskill
--  Utsusemi/Blink absorb:
--  Range: Ranged Attack
--  Notes: Unique ranged weaponskill used by Tenzen during The Warrior's Path. Also used by Trust: Tenzen II.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 5 or mob:AnimationSub() == 6 then -- if tenzen is in bow mode
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 5.5

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 2.75, 2.75, 2.75)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg

end
