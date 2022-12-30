-----------------------------------
-- Wild Ginseng
--
-- Description: Gives mob Blink
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local duration = math.random(210, 270)
    local regenPower = 30

    -- Bearclaw Rabbit ENM: Follow the White Rabbit
    if mob:getPool() == 384 then
        regenPower = 50
    end

    mob:addStatusEffect(tpz.effect.PROTECT, 60, 0, duration)
    mob:addStatusEffect(tpz.effect.SHELL, 60, 0, duration)
    mob:addStatusEffect(tpz.effect.HASTE, 2000, 0, duration) -- 20% haste
    mob:addStatusEffect(tpz.effect.REGEN, regenPower, 0, duration)

    local typeEffect = tpz.effect.BLINK
    skill:setMsg(MobBuffMove(mob, typeEffect, 3, 0, duration))
    return typeEffect
end
