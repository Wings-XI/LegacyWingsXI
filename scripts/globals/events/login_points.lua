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

login_points = {}

login_points.params = {
    perDay = 2,
}

login_points.dailyLoginPoints = function(player)
    if player then
        local realDay = tonumber(os.date("%j")) -- %M for next minute, %j for next day
printf("%u", realDay)
        if realDay ~= player:getCharVar("[LOGIN_POINTS]lastReward") then
            local addPoints = login_points.params.perDay
            player:setCharVar("[LOGIN_POINTS]lastReward", realDay)
            login_points.addPoints(player, addPoints)
        end
    end
end

login_points.addPoints = function(player, points)
    player:addCharVar("[LOGIN_POINTS]totalPoints", points)
    player:timer(5 * 1000, function(player)
        player:PrintToPlayer(string.format("SYSTEM : You gained %u login points. You now have %u", points, player:getCharVar("[LOGIN_POINTS]totalPoints")), 0xD)
    end)
end

login_points.delPoints = function(player, points)
    if player:getCharVar("[LOGIN_POINTS]totalPoints") >= points then
        player:addCharVar("[LOGIN_POINTS]totalPoints", -1 * points)
        player:PrintToPlayer(string.format("SYSTEM : You have %u remaining points, you consumed %u points to receive this reward.", player:getCharVar("[LOGIN_POINTS]totalPoints"), points), 0xD)
        return true
    else
        player:PrintToPlayer(string.format("SYSTEM : You have %u points, you need %u points to receive this reward.", player:getCharVar("[LOGIN_POINTS]totalPoints"), points), 0xD)
        return false
    end
end