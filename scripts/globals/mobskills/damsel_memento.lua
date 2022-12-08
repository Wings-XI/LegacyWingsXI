---------------------------------------------
-- Damsel Memento
-- Recovers 5% (5,000) of his HP and removes all debuffs.
-- If Dark Ixion's horn has been broken in battle, there's a chance that it will regenerate.
-- Type: Magical
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if  mob:AnimationSub() == 1 or mob:getLocalVar("charging") == 1 or math.random(1,2) == 1 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dispel = mob:eraseStatusEffect()

    while (dispel ~= tpz.effect.NONE) do
        dispel = mob:eraseStatusEffect()
    end
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    
    return MobHealMove(mob, mob:getMaxHP()*5/100)
end

