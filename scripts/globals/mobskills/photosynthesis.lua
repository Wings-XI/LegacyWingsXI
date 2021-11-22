---------------------------------------------
-- Photosynthesis
--
-- Description: Adds a Regen tpz.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Only available during daytime.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- only used during daytime
    local currentTime = VanadielHour()
    if (currentTime >= 6 and currentTime <= 18) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local power = mob:getMainLvl()/10 * .75
    local duration = 30
    if power < 1 then
        power = 1
    end

    local typeEffect = tpz.effect.REGEN
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end
