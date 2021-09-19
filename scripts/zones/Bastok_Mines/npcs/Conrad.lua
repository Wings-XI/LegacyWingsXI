-----------------------------------
-- Area: Bastok Mines
--  NPC: Conrad
-- Outpost Teleporter NPC
-- !pos 94.457 -0.375 -66.161 234
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

local teleporterNation = tpz.nation.BASTOK
local teleporterEvent  = 581

function onTrade(player, npc, trade)
    
    player:setLocalVar("Trader", 0)

    if isStarlightEnabled() ~= 0 then
        if (trade:hasItemQty(4215, 10) or trade:hasItemQty(4216, 10) or trade:hasItemQty(4217, 10) or trade:hasItemQty(4218, 10) or trade:hasItemQty(4167, 10) or trade:hasItemQty(4168, 10) or trade:hasItemQty(4169, 10)) then
            tpz.conquest.teleporterOnTrigger(player, teleporterNation, teleporterEvent)
            player:setLocalVar("Trader", 1)
            player:tradeComplete()
        end
    end
end

function onTrigger(player, npc)
    tpz.conquest.teleporterOnTrigger(player, teleporterNation, teleporterEvent)
end

function onEventUpdate(player, csid, option)
    if isStarlightEnabled() ~= 0 then
        if player:getLocalVar("Trader") == 1 then
            tpz.conquest.teleporterOnEventUpdateNoFee(player, csid, option, teleporterEvent)
        else
            tpz.conquest.teleporterOnEventUpdate(player, csid, option, teleporterEvent)
        end
    else
        tpz.conquest.teleporterOnEventUpdate(player, csid, option, teleporterEvent)
    end 
end

function onEventFinish(player, csid, option)
    if isStarlightEnabled() ~= 0 then
        if player:getLocalVar("Trader") == 1 then
            tpz.conquest.teleporterOnEventFinish(player, csid, option, teleporterEvent)
            player:setLocalVar("Trader", 0)
        else
            tpz.conquest.teleporterOnEventFinish(player, csid, option, teleporterEvent)
        end
    else 
        tpz.conquest.teleporterOnEventFinish(player, csid, option, teleporterEvent)
    end
end
