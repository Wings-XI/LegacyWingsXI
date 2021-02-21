-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Ulbrecht
-----------------------------------
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
require("scripts/globals/instance")
-----------------------------------

function onMobSpawn(mob)
    mob:setUnkillable(true)
end

function onMobFight(mob, player)
    
    local instance = mob:getInstance()
    if (mob:getHPP() <= 20 and instance:completed() == false) then
        mob:messageText(mob, ID.text.STUDENT_BECOME_MASTER)
        instance:complete()
    end

    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        local chance = math.random(0,99)
        if chance < 33 then
            mob:messageText(mob, ID.text.PAINFUL_LESSON)
        end
    end)

    mob:addListener("MAGIC_START", "ULBRECHT_MAGIC_START", function(mob, skillID)
        local chance = math.random(0,99)
        if chance < 50 then
            mob:messageText(mob, ID.text.TRUE_TEACHING)
        end
    end)

    mob:addListener("JOB_SPECIAL_BEG_", "ULBRECHT_TABULA_RASA", function(mob, skillID)
        mob.messageText(mob, ID.text.MOST_IMPRESSIVE)
    end)

    mob:addListener("ABILITY_USE", "ULBRECTH_ABILITY_USE", function(mob, target, skillID)
        -- if not dark arts and 25% chance
        if skillID ~= 2303 and math.random(0,99) < 25 then 
            mob:messageText(mob, ID.text.ANSWER_THIS)
        end
    end)
end

function onMobEngaged(mob, target)
    if mob:getLocalVar("dialog") == 0 then
        mob:messageText(mob, ID.text.MADE_YOUR_PEACE)
        mob:setLocalVar("dialog", 1)

        mob:useMobAbility(2303) -- use dark arts
    end
end