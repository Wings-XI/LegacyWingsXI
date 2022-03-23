-----------------------------------
-- Ability: Modus Veritas
-- Increases damage done by helix spells while lowering spell duration by 50%.
-- Obtained: Scholar Level 65
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local helix = target:getStatusEffect(tpz.effect.HELIX)
    if helix ~= nil then
        return 0, 0
    else
        return 547 -- This ability can only be used on targets under the effect of a helix.
    end
end

function onUseAbility(player, target, ability)

    -- Fomor Shadowreign NM Modus Immunity
    if target:getID() == (17494213 or 17494093 or 17477708 or 17449008 or 17449017) then
        ability:setMsg(tpz.msg.basic.JA_MISS)
        return 0
    end

    local helix = target:getStatusEffect(tpz.effect.HELIX)
    if helix ~= nil then
        local mvPower = helix:getSubPower()
        
        local resist = 1
        if target:isNM() then -- NMs must pass a resistance check, but it seems to be implied that normal mobs don't need to https://ffxiclopedia.fandom.com/wiki/Modus_Veritas?oldid=1075469
            local bonusAcc = player:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT) - mvPower*40 -- dINT minus 40 M.acc per Modus already on the NM
            resist = applyResistanceAbility(player, target, tpz.magic.ele.NONE, tpz.skill.NONE, bonusAcc)
        end

        if resist < 0.5 then
            ability:setMsg(tpz.msg.basic.JA_MISS)
            return 0
        else
            -- Double power and halve remaining time
            local mvMerits = player:getMerit(tpz.merit.MODUS_VERITAS_DURATION)
            local durationMultiplier = 0.5 + (0.05 * mvMerits)
            mvPower = mvPower + 1
            local helixPower = helix:getPower() * 2
            local duration = helix:getDuration()
            local remaining = math.floor(helix:getTimeRemaining() / 1000) -- from milliseconds
            -- print(string.format("helix original dot stats: %i, duration: %i, remaining: %i", helixPower / 2, duration, remaining))
            duration = (duration-remaining) + math.floor(remaining * durationMultiplier)
            -- print(string.format("helix new dot stats: %i, remaining: %i", helixPower, duration))
            helix:setSubPower(mvPower)
            helix:setPower(helixPower)
            helix:setDuration(duration * 1000) -- back to milliseconds
        end
    else
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2) -- No effect
    end
end
