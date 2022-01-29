---------------------------------------------------
-- Stellar Burst
-- A starburst damages targets in an area of effect. Additional effect: Silence
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
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_3_SHADOW)
    if mob:getID() == 16924680 then -- Apoc Nigh Damage Change
        -- Adding in a clamp to set minimum damage. This is due to the way the skill
        -- is currently setup as at times it will do little to no damage.
        -- https://www.youtube.com/watch?v=mG-qyhGOqNY&ab_channel=Smackdownbob
        dmg = utils.clamp(dmg, 100, 140)
    end
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 30)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    mob:resetEnmity(target)
    return dmg
end
