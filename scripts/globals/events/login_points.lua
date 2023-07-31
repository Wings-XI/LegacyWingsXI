---------------------------------------------------------------
-- WINGSCUSTOM
-- framework for handling "login points" which are generic bonus points
-- used for receiving time-gated repeatable rewards  slightly more frequently
--(C) 2022 Wings Project. Coded by MowFord.                 --
---------------------------------------------------------------
require("scripts/globals/events/fests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

login_points = login_points or {}

login_points.params = {
    perDay = 2,
}

login_points.dailyLoginPoints = function(player)
    if player then
        local realDay = tonumber(os.date("%j")) -- %M for next minute, %j for next day
        if realDay ~= player:getCharVar("[LOGIN_POINTS]lastReward") then
            local addPoints = login_points.params.perDay
            player:setCharVar("[LOGIN_POINTS]lastReward", realDay)
            login_points.addPoints(player, addPoints)
        end
    end
end

login_points.addPoints = function(player, points)
    player:addCurrency("login_points", points)
    -- Convert old points to proper currency
    if player:getCharVar("[LOGIN_POINTS]totalPoints") > 0 then
        player:addCurrency("login_points", player:getCharVar("[LOGIN_POINTS]totalPoints"))
        player:setCharVar("[LOGIN_POINTS]totalPoints", 0)
    end
    player:timer(8 * 1000, function(player)
        player:PrintToPlayer(string.format("SYSTEM : You gained %u login points. You now have %u.", points, player:getCurrency("login_points")), 0xD)
    end)
end

login_points.delPoints = function(player, points)
    if player:getCurrency("login_points") >= points then
        player:addCurrency("login_points", -1 * points)
        player:PrintToPlayer(string.format("SYSTEM : You consumed %u login points to receive this reward. You now have %u.", points, player:getCurrency("login_points")), 0xD)
        return true
    else
        player:PrintToPlayer(string.format("SYSTEM : You need %u login points to receive this reward. You only have %u.", points, player:getCurrency("login_points")), 0xD)
        return false
    end
end