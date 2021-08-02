---------------------------------------------------
--  Cosmic Elucidation
--  Description: Cosmic Elucidation inflicts heavy AOE damage to everyone in the battle.
--  Type: 
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 
--  Notes: Ejects all combatants from the battlefield, resulting in a failure.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 1 -- only scripted use
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*17, tpz.magic.ele.LIGHT, dmgmod, TP_DMG_VARIES)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    
    skill:setMsg(302) -- cosmic elucidation messageid
    
    return dmg

end