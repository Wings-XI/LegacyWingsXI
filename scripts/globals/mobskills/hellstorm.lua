---------------------------------------------
-- Hellstorm
-- Deals Fire damage to enemies in an area of effect
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobID = mob:getID()
    -- if mob is Reacton, he is not allowed to use this skill before phase 3
    if mobID == 17031599 and mob:AnimationSub() < 2 then
        return 1

    -- if mob is a Pandemonium Lamp
    elseif mobID >= 17056169 and mobID <= 17056185 then
        -- only bomb form is allowed to use
        local mobSkin = mob:getModelId()
        if (mobSkin ~= 281) then
            return 1
        end
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*4, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end