---------------------------------------------------
-- Bone Crusher
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
    local numhits = 3
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
	if dmg > 0 and skill:getMsg() ~= 31 then
        target:tryInterruptSpell(mob, info.hitslanded)

        local chance = 0.033 * skill:getTP()
        if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
            if not target:hasStatusEffect(tpz.effect.STUN) and chance >= math.random()*100 then
                target:addStatusEffect(tpz.effect.STUN, 1, 0, 5)
            end
        end
    end
    return dmg
end
