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

-- todo check animation subs, give it a chance to restore, add IDs
-- currently damages itself for 0
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dispel = mob:eraseStatusEffect()


    while (dispel ~= tpz.effect.NONE) do
        dispel = mob:eraseStatusEffect()
    end

    if mob:AnimationSub() == 2 and RND <= 5 then
        mob:AnimationSub(3)
    end

    print(target:getName()) 


    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    

    return MobHealMove(mob, mob:getMaxHP()*5/100)
end

