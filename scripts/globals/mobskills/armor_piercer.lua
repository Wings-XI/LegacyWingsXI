---------------------------------------------------
-- Armor Piercer
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getID() == 17072171) then -- Ob
        if (mob:getHPP() > 50) then
            return 1 -- only used under 50%
        end
    end
    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1.5
    local dmgmod = 4.0

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_IGNORES_DEF, .5, .5, .5)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end

    return dmg

end
