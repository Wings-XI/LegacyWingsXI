---------------------------------------------
-- Target Analysis
--
-- Description: AoE Absorb All with randomness
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- skillList  54 = Omega
    -- skillList 727 = Proto-Omega
    -- skillList 728 = Ultima
    -- skillList 729 = Proto-Ultima
    local skillList = mob:getMobMod(tpz.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()

    if ((skillList == 54 and mobhp > 25) or (skillList == 727 and mob:AnimationSub() == 1)) then
        return 0
    else
        return 1
    end
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
