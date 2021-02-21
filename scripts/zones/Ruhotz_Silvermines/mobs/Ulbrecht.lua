-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Ulbrecht
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobFight(mob, player)
    
    local instance = mob:getInstance()
    if (mob:getHPP() <= 20 and instance:completed() == false) then
        instance:complete()
    end

    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        -- Vulcan Shot
        if(skillId == 254) then
            mob:showText(mob, ID.text.FOR_EPHRAMAD) -- 7497 Prepare to recieve
            mob:timer(3000, function(mob)
                mob:showText(mob, ID.text.TROUBLESOME_SQUABS)
            end)
        -- Circle Blade
        elseif(skillId == 938) then
            mob:showText(mob, ID.text.FOR_THE_BLACK_COFFIN)
        end
    end)
    -- 20% hp
    -- set seeing blood red to 4
    -- play event 10000 > grauberg > event 15
end