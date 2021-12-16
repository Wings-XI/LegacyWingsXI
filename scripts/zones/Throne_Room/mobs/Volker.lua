-----------------------------------
-- Area: Throne Room
--  Mob: Volker
-- Ally during Bastok Mission 9-2
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/status")

function onMobSpawn(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        -- Red Lotus Blade
        if skillID == 973 then
            mob:showText(mob, ID.text.NO_HIDE_AWAY)
        -- Spirits Within
        elseif skillID == 974 then
            mob:showText(mob, ID.text.YOUR_ANSWER)
        -- Vorpal Blade
        elseif skillID == 975 then
            mob:showText(mob, ID.text.CANT_UNDERSTAND)
        end
    end)
end

function onMobRoam(mob)
    local wait = mob:getLocalVar("wait")
    if wait > 40 then -- 40 seconds until auto engage
        local inst = mob:getBattlefield():getArea()
        local instOffset = ID.mob.ZEID_BCNM_OFFSET + 1 + (4 * (inst - 1))
        local target = GetMobByID(instOffset)
        if not target:isDead() then
            mob:addEnmity(target, 0, 1)
            mob:setLocalVar("wait", 0)
        end
    else
        mob:setLocalVar("wait", wait+3)
    end
end

function onMobDeath(mob, player, isKiller)
    mob:getBattlefield():lose()
end
