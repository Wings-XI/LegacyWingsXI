---------------------------------------------
-- Berserker Dance
-- Used only by certain Orc NMs in Wings of the Goddess Areas.
-- Grants a very strong haste effect at the cost of reducing defense
-- Should not be dispellable
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- consider giving this a unique effect combining the two effects
    local hastePower = 410 -- -- 410/1024 ~40%
    local defDownPower = 25
    local duration = 60
    local hasteTypeEffect = tpz.effect.HASTE
    local defDownTypeEffect = tpz.effect.DEFENSE_DOWN

    -- add Haste
    skill:setMsg(MobBuffMove(mob, hasteTypeEffect, hastePower, 0, duration))
    local hasteEffect = mob:getStatusEffect(hasteTypeEffect)
    if (hasteEffect) then
        hasteEffect:unsetFlag(tpz.effectFlag.DISPELABLE)
    end

    -- add def down
    mob:addStatusEffectEx(defDownTypeEffect, 0, defDownPower, 0, duration)
    local defDownTypeEffect = mob:getStatusEffect(defDownTypeEffect)
    if (defDownTypeEffect) then
        defDownTypeEffect:unsetFlag(tpz.effectFlag.DISPELABLE)
    end

    -- Mob haste is capped? Since it appears so - push delay changes for the duration of the buff to get to 2s per swing
    mob:addMod(tpz.mod.DELAY, 1750)
    mob:timer(60000, function(mob) if (mob) then mob:delMod(tpz.mod.DELAY, 1750)end end)

    return hasteTypeEffect
end
