---------------------------------------------
-- Rage
--
-- Description: The Ram goes berserk
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 50% Attack UP, -50% defense DOWN
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local duration = 60

    if(mob:isPet()) then
        local player = mob:getMaster();
        -- isJugPet is really hasJugPet.  Given an entity it returns true if that entity has a pet and the pet is a jug pet
        -- TODO - Rule of 3 counter = 1 - rename isJugPet to has, add isJugPet
        if (player~=nil and player:isJugPet()) then
            local tp = skill:getTP()
            duration = math.max(duration, duration* (tp/1000))
        end
    end

    local typeEffect = tpz.effect.BERSERK
    skill:setMsg(MobBuffMove(mob, typeEffect, 50, 0, duration))
    return typeEffect
end
