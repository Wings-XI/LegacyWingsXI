-----------------------------------
-- Area: Bhaflau Thickets
--   NM: Emergent Elm
-- !pos 71.000 -33.000 627.000 52
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 452)
end

function updateRegen(mob)
    local hour = VanadielHour()
    local regen = mob:getMod(tpz.mod.REGEN)

    if hour > 3 and hour < 20 then -- daytime between 4:00 and 20:00
        if regen ~= 40 then
            mob:setMod(tpz.mod.REGEN, 40) -- High auto-regen during the daytime (might need to be higher)
        end
    else
        if regen ~= 0 then
            mob:setMod(tpz.mod.REGEN, 0)
        end
    end
end

function onMobSpawn(mob)
    updateRegen(mob)
end

function onMobFight(mob)
    updateRegen(mob)
end

function onMobRoam(mob)
    updateRegen(mob)
end