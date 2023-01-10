---------------------------------------------------
-- Self-Destruct bomb cluster
-- https://ffxiclopedia.fandom.com/wiki/Self-Destruct_(Cluster)
-- Family: Cluster
-- Type: Magical?
-- Utsusemi/Blink absorb: Ignores shdaows.
-- Range: 10' radial
-- Notes: Only used below 50% health. Normally only detonates one of the bombs in the cluster, but if its used below 20%, there's a chance all bombs will explode.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getHPP() > 50) then
        return 1
    end

    --[[
        animation subs:
        4 - three bombs
        5 - two bombs
        6 - one bomb
        explosion type:
        1 - single
        2 - all
        mobskill animations:
        3-bomb
        870 - single
        871 - all
        2-bomb
        872 - single
        873 - all
        1-bomb
        874 - single
    ]]
    local animSub = utils.clamp(mob:AnimationSub(), 4, 6)
    local explosionType = 1
    if (mob:getHPP() < 20 and math.random(100) < 15) or animSub == 6 then
        explosionType = 2
    end
    local animation = 874 - (6 - animSub) * 2 + (explosionType - 1)
    skill:setAnim(animation)
    mob:setLocalVar("explosionType", explosionType)
    mob:setLocalVar("newAnimSub", animSub + 1)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local newAnimSub = utils.clamp(mob:getLocalVar("newAnimSub"), 5, 6)
    local dmgmod = 1
        BOMB_TOSS_HPP = skill:getMobHPP() / 100

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*18*BOMB_TOSS_HPP, tpz.magic.ele.FIRE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)

    -- reduce hp based on # of bombs exploded
    if mob:getLocalVar("explosionType") == 2 then
        -- multiple dmg by number of bombs
        dmg = dmg * (8 - newAnimSub)
        mob:setHP(0)
    else
        local remainingHPP = 50
        if newAnimSub == 5 then
            remainingHPP = 66
        end
        mob:setHP(math.ceil(mob:getHP() * (remainingHPP / 100)))
        mob:AnimationSub(newAnimSub)
    end
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
