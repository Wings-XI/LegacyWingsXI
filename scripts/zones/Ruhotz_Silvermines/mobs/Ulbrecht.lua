-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Ulbrecht
-----------------------------------
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
require("scripts/globals/instance")
-----------------------------------

function onMobFight(mob, player)
    
    local instance = mob:getInstance()
    if (mob:getHPP() <= 20 and instance:completed() == false) then
        mob:messageText(mob, ID.text.STUDENT_BECOME_MASTER)
        instance:complete()
    end

    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        local messageID = ID.text.UNLEARNT_SPRAT + math.random(0,4)
        mob:messageText(mob, messageID)
    end)

    mob:addListener("MAGIC_START", "ULBRECHT_START_CASTING", function(mob, skillID)
        local chance = math.random(0,99)
        if chance < 40 then
            local messageID = ID.text.UNLEARNT_SPRAT + math.random(0,4)
            mob:messageText(mob, messageID)
        end
    end)
end

function onMobEngaged(mob, target)
    if mob:getLocalVar("dialog") == 0 then
        mob:messageText(mob, ID.text.MADE_YOUR_PEACE)
        mob:setLocalVar("dialog", 1)

        -- use dark arts
    end
end