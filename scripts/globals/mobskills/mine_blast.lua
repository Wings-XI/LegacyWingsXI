---------------------------------------------
-- Mine Blast
-- 10 Aoe Fire damage from a bomb
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 20
    local wDmgMultiplier = 5
    local NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE = 17092962

    -- mine blast is being used to take out walls in lebros excavation duty
    -- with the params above - mine blast in Nyzul does 9300 dmg to players
    -- so - if the mob using the skill is the mine in Nyzul Isle Investigation - nerf the damage to a reasonable 300-400 pre shell/barfira
    if (mob:getID() == NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE) then
        dmgmod = 1
        wDmgMultiplier = 4
    end

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*wDmgMultiplier, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
