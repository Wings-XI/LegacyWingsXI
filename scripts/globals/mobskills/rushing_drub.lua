---------------------------------------------
--  Rushing Drub
--
--  Description: Delivers a fourfold attack on a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: 4 shadows
--  Range: Melee
--  Notes: Only used by Mamool Ja mage with staves.
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- If animationSub is 1, the mob has already lost his weapeon and cant do this TP attack.
    if mob:AnimationSub() == 0 then
        if mob:getID() == 16986430 then
            if mob:getLocalVar("WarmUp") == 1 then
                return 1
            else
                return 0
            end   
        else
            return 0
        end
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
