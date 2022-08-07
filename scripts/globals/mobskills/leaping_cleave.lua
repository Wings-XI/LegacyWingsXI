---------------------------------------------
--  Leaping Cleave
--  Family: Qutrub
--  Description: Performs a jumping slash on a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes: Used only when wielding their initial sword, or the dagger on their backs.
---------------------------------------------
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 0 or mob:AnimationSub() == 2 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 3
    local dmgmod = 4

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end

    -- Zareehkl the Jubilant's Leaping Cleave
    if skill:getID() == 2363 then
        -- has a chance to stun
        if math.random() > 0.25 then
            MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.STUN, 1, 0, 4)
        end

        -- does not display the regular message (mimics auto attack)
        skill:setMsg(tpz.msg.basic.DAMAGE_SECONDARY)
    end

    return dmg
end
