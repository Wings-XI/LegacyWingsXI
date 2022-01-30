---------------------------------------------------
-- Omega Javelin
-- Pierces a single target with an ethereal javelin. Additional effect: Petrification
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    if mob:getID() == 16924680 then -- Apoc Nigh Acc Boost
        accmod = 5
    end
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)
    if mob:getID() == 16924680 then -- Apoc Nigh Damage Change
        -- Adding in a clamp to set minimum damage. This is due to the way the skill
        -- is currently setup as at times it will do little to no damage.
        -- https://www.youtube.com/watch?v=mG-qyhGOqNY&ab_channel=Smackdownbob
        dmg = utils.clamp(dmg, 130, 200)
    end
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.PETRIFICATION, 1, 0, 45)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    mob:resetEnmity(target)
    return dmg
end
