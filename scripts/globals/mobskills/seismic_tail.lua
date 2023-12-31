---------------------------------------------------
-- Seismic Tail
-- Deals extreme damage to targets behind the user.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)

    if mob:getID() == 16998874 then
        return 0
    else
        if not target:isBehind(mob, 96) then
            return 1
        else
            return 0
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 2
    local dmgmod = math.random(5, 7) 
    
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 2, 3, 4)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    

    if mob:getID() == 16998874 then
        mob:setLocalVar("Phase", 1)
        mob:setLocalVar("Changed",1)
    end
    return dmg
end