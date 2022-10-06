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
    local hastePower = 4000 -- 40% haste: https://ffxiclopedia.fandom.com/wiki/Berserker_Dance
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

    return hasteTypeEffect
end
