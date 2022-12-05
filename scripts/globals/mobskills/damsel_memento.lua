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

-- Animation sub stuff doesnt work yet, may need to deal with it in weaponskillprepare on mob lua

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dispel = mob:eraseStatusEffect()
    local RND = math.random(1,100)


    while (dispel ~= tpz.effect.NONE) do
        dispel = mob:eraseStatusEffect()
    end

    if mob:AnimationSub() == 2 and RND >= 5 then
        mob:AnimationSub(3)
    end
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    
    

    return MobHealMove(mob, mob:getMaxHP()*5/100)
end

