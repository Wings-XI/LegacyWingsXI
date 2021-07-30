---------------------------------------------
-- Call Beast
-- Call my pet.
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:entityAnimationPacket("casm")
    mob:timer(3000, function(mob)
        if mob:isAlive() then
            mob:entityAnimationPacket("shsm")
            mob:spawnPet()
        end
    end)

    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end
