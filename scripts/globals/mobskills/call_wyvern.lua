---------------------------------------------
-- Call Wyvern
-- Call my pet.
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if mob:hasPet() == true then
        return 1
    else
        mob:spawnPet()
        skill:setMsg(tpz.msg.basic.NONE)
    end

    return 0
end
