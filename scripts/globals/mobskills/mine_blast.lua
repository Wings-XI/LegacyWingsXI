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
    -- so - if the mob using the skill is the mine in Nyzul Isle Investigation - adjust the damage
    -- Thf NMs hits for 300-400 pre shell/barfira
    -- Rng NM a bit less
    -- Regular Thfs for ~150
    if (mob:getID() == NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE) then
        dmgmod = 1
        local mobVar = mob:getLocalVar("wDmgMultiplier")
        if (mobVar > 0) then
            wDmgMultiplier = mobVar
        else
            wDmgMultiplier = 2
        end
    end

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*wDmgMultiplier, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
