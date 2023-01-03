---------------------------------------------------------------
-- Zeni fest - bonus zeni and ISP for soul plates!          --
--(C) 2022 Wings Project. Coded by MowFord.                 --
---------------------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

zeni_fest = {}

zeni_fest.params = {
    PercOfZeniAsBonusISP = 20,
    MaxBonusZeni = 5000,
}

zeni_fest.onSanrakuPlateTradeComplete = function(player, zeni_base)
    
    -- Sanity check
    local now = os.time()
    if ZENI_FEST_BEGIN == nil or ZENI_FEST_BEGIN >= now or
        ZENI_FEST_END == nil or ZENI_FEST_END <= now then
            return
    end
    
    -- reset bonus zeni counter for this zeni_fest period
    if player:getCharVar("[ZENI_FEST]LastZeniBonus") < ZENI_FEST_BEGIN then
        player:timer(1000, function(playerArg)
            playerArg:PrintToPlayer(string.format("Sanraku : This is your first turnin during ZeniFest! Every turn-in yields bonus Zeni up to a total of %u, also %u%% of all Zeni gained as ISP!", math.floor(zeni_fest.params.MaxBonusZeni), math.floor(zeni_fest.params.PercOfZeniAsBonusISP)), 0xD)
        end)
        player:setCharVar("[ZENI_FEST]LastZeniBonus", now)
        player:setCharVar("[ZENI_FEST]TotalZeniBonus", 0)
    end

    -- give bonus zeni if not a default plate
    if zeni_base > 5 then
        local totalBonusThisPeriod = player:getCharVar("[ZENI_FEST]TotalZeniBonus")
        local normalizedMaxZeni = 150
        local zeniPercOfMax = zeni_base / normalizedMaxZeni
        -- bonus zeni is half the distance to the normalized max
        local bonusZeni = utils.clamp(math.floor(normalizedMaxZeni * (.5) * (1 - zeniPercOfMax)), 0, zeni_fest.params.MaxBonusZeni - totalBonusThisPeriod)
        local totalZeni = zeni_base + bonusZeni
        local bonusISP = math.floor(totalZeni * zeni_fest.params.PercOfZeniAsBonusISP / 100)
        player:setCharVar("[ZENI_FEST]LastZeniBonus", now)
        player:setCharVar("[ZENI_FEST]TotalZeniBonus", totalBonusThisPeriod + bonusZeni)
        player:addCurrency("zeni_point", bonusZeni)
        player:addCurrency("imperial_standing", bonusISP)
        player:PrintToPlayer(string.format("Sanraku : ZeniFest is currently active. You get %u bonus zeni and %u bonus ISP! %u remaining bonus Zeni during this ZeniFest.", bonusZeni, bonusISP, zeni_fest.params.MaxBonusZeni - totalBonusThisPeriod - bonusZeni), 0xD)
    else
        player:PrintToPlayer(string.format("Sanraku : ZeniFest is currently active. Turn in higher-tier Soul Plates for the bonus.", bonusZeni, bonusISP), 0xD)
    end
end
