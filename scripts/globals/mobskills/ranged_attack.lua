---------------------------------------------------
-- Ranged Attack
-- Deals a ranged attack to a single target.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0

    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, info.hitslanded)

    local msg = skill:getMsg()
    if dmg > 0 and msg ~= tpz.msg.basic.SHADOW_ABSORB then
      target:addTP(20)
      mob:addTP(80)
    end

    if msg ~= tpz.msg.basic.SHADOW_ABSORB then
        target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
    end

    if mob:getFamily() == 3 and msg ~= tpz.msg.basic.SHADOW_ABSORB then
        skill:setMsg(352)
    end

    return dmg
end
