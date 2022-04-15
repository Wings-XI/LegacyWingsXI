---------------------------------------------
--  Trembling
--
--  Description: Deals physical damage to enemies within an area of effect. Additional effect: Dispel
--  Type: Physical
--  Wipes Shadows
--  Range: 10' radial
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 3
    local accmod = 1
    local dmgmod = .5
    local requireNumHits = true
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg
    local finalInfo = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded, requireNumHits)

    if (type(finalInfo) == "number") then
        dmg = finalInfo
    else
        dmg = finalInfo.dmg

        if (finalInfo.hitslanded > 0) then
            local dispelled = math.random(2, 3)
            for i=1, dispelled do 
                target:dispelStatusEffect() 
            end    
        end
    end

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, dmg.hitslanded) end
    return dmg
end
