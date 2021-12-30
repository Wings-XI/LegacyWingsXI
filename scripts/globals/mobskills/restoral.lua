---------------------------------------------
-- Restoral
-- Description: Restores HP.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/gears")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getHPP() < 100) then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    --[[
    The only calculations available on the net are for the players blue magic version,
    which does not seem to fit with retail in game observations on the mobskill version..
    So math.random() for now!
    ]]
    local heal = math.random(900, 1400)
    if mob:getPool() == 243 then
        heal = heal * 2.5
    end

    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    local preHealHPP = mob:getHPP()
    local healAmount = MobHealMove(mob, heal)
    local postHealHPP = mob:getHPP()

    if (preHealHPP <= 25) then
        if (postHealHPP > 50) then
            -- Healed from below 25 to over 50 - 3 gears
            tpz.gears.updateNumberOfGears(mob, 0)
        elseif (postHealHPP > 25) then
            -- Healed from below 25 to over 25 - 2 gears
            tpz.gears.updateNumberOfGears(mob, 1)
        end
    elseif (preHealHPP <= 50) and (postHealHPP > 50) then
        -- Healed from below 50 to over 50 - 3 gears
        tpz.gears.updateNumberOfGears(mob, 0)
    end
    return healAmount
end
