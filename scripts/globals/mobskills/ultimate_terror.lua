---------------------------------------------
-- Ultimate Terror
--
-- Description: AoE Absorb All with randomness
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)  

    local drained = 0

    if math.random() < 3/7 then
        skill:setMsg(MobDrainAttribute(mob, target, 136, 10, 3, 60))
        drained = drained + 1
    end
    
    if math.random() < 3/7 then
        skill:setMsg(MobDrainAttribute(mob, target, 137, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < 3/7 then
        skill:setMsg(MobDrainAttribute(mob, target, 138, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < 3/7 then
        skill:setMsg(MobDrainAttribute(mob, target, 139, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < 3/7 then
        skill:setMsg(MobDrainAttribute(mob, target, 140, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < 3/7 then
        skill:setMsg(MobDrainAttribute(mob, target, 141, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < 3/7 then
        skill:setMsg(MobDrainAttribute(mob, target, 142, 10, 3, 60))
        drained = drained + 1
    end

    return drained
    
end