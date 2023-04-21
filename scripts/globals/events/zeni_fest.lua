---------------------------------------------------------------
-- Zeni fest - bonus zeni and ISP for soul plates!          --
--(C) 2022 Wings Project. Coded by MowFord.                 --
-- !enablefest or events/fests.lua for details
---------------------------------------------------------------
require("scripts/globals/events/fests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

zeni_fest = {}

zeni_fest.params = {
    festType = 2,
    PercOfZeniAsBonusISP = 20,
    MaxBonusZeni = 5000,
}

zeni_fest.onSanrakuPlateTradeComplete = function(player, zeni_base)
    local ZENI_FEST_START = GetServerVariable("[Fest]Start")
    local ZENI_FEST_END = GetServerVariable("[Fest]End")
    -- Sanity check
    local now = os.time()
    if GetServerVariable("[Fest]Type") ~= zeni_fest.params.festType or
        ZENI_FEST_START == nil or ZENI_FEST_START >= now or
        ZENI_FEST_END == nil or ZENI_FEST_END <= now then
            return
    end
    
    -- reset bonus zeni counter for this zeni_fest period
    if player:getCharVar("[ZENI_FEST]LastZeniBonus") < ZENI_FEST_START then
        player:timer(1000, function(playerArg)
            playerArg:PrintToPlayer(string.format("Sanraku : This is your first turnin during ZeniFest! Every turn-in yields bonus Zeni up to a total of %u, also %u%% of all Zeni gained as ISP!", math.floor(zeni_fest.params.MaxBonusZeni), math.floor(zeni_fest.params.PercOfZeniAsBonusISP)), 0xD)
        end)
        player:setCharVar("[ZENI_FEST]LastZeniBonus", now)
        player:setCharVar("[ZENI_FEST]TotalZeniBonus", 0)
    end

    -- give bonus zeni if not a default plate
    if zeni_base > 5 then
        local totalBonusThisPeriod = player:getCharVar("[ZENI_FEST]TotalZeniBonus")
        local normalizedMaxZeni = 105
		if zeni_base > 125 then
			normalizedMaxZeni = 250
		elseif zeni_base > 75 then
			normalizedMaxZeni = 150
		end
        local zeniPercOfMax = zeni_base / normalizedMaxZeni
        -- bonus zeni is half the distance to the normalized max
        local bonusZeni = utils.clamp(math.floor(normalizedMaxZeni * (.5) * (1 - zeniPercOfMax)), 0, zeni_fest.params.MaxBonusZeni - totalBonusThisPeriod)
        local totalZeni = zeni_base + bonusZeni
        local bonusISP = math.floor(totalZeni * zeni_fest.params.PercOfZeniAsBonusISP / 100)
        player:setCharVar("[ZENI_FEST]LastZeniBonus", now)
        player:setCharVar("[ZENI_FEST]TotalZeniBonus", totalBonusThisPeriod + bonusZeni)
        player:addCurrency("zeni_point", bonusZeni)
        player:addCurrency("imperial_standing", bonusISP)
        player:PrintToPlayer(string.format("Sanraku : ZeniFest ends %s. You get %u bonus zeni and %u bonus ISP! %u remaining bonus Zeni during this ZeniFest.", os.date("%Y/%m/%d %H:%M:%S(server time)", ZENI_FEST_END), bonusZeni, bonusISP, zeni_fest.params.MaxBonusZeni - totalBonusThisPeriod - bonusZeni), 0xD)
    else
        player:PrintToPlayer(string.format("Sanraku : ZeniFest ends %s. Turn in higher-tier Soul Plates for the bonus.", os.date("%Y/%m/%d %H:%M:%S(server time)", ZENI_FEST_END), bonusZeni, bonusISP), 0xD)
    end
end
