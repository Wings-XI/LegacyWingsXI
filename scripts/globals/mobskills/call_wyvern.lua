---------------------------------------------
-- Call Wyvern
-- Call my pet.
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- if drg mob has no pet just show no animation (only useed as a 2-hour)
    if mob:getPet() == nil then
        skill:setAnim(0)
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if mob:hasPet() == true then
        skill:setMsg(tpz.msg.basic.NONE)
        return 1
    else
        mob:spawnPet()
        skill:setMsg(tpz.msg.basic.NONE)
    end

    return 0
end
