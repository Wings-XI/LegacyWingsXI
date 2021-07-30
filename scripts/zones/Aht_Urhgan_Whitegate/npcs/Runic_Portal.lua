-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Runic Portal
-- Aht Urhgan Teleporter to Other Areas
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local hasAssault, keyitem = tpz.besieged.hasAssaultOrders(player)
    local offset2 = nil
    local hasRunicPortal = nil
    switch (hasAssault): caseof
    {
        [120] = function ()
            hasRunicPortal = tpz.besieged.hasRunicPortal(player, 1)
        end,
        [121] = function ()
            hasRunicPortal = tpz.besieged.hasRunicPortal(player, 3)
        end,
        [122] = function ()
            hasRunicPortal = tpz.besieged.hasRunicPortal(player, 4)
        end,
        [123] = function ()
            hasRunicPortal = tpz.besieged.hasRunicPortal(player, 2)
        end,
        [124] = function ()
            hasRunicPortal = tpz.besieged.hasRunicPortal(player, 5)
        end,
        --[[[125] = function ()
            hasRunicPortal = tpz.besieged.hasRunicPortal(player, 6)
        end,]]
    }

    if hasAssault > 0 then
        if hasRunicPortal then
            player:messageSpecial(ID.text.CONFIRM_ORDER, keyitem)
            player:startEvent(hasAssault)
        else
            offset2 = hasAssault - 120
            player:messageSpecial(ID.text.CONFIRM_ORDER, keyitem)
            player:messageSpecial(ID.text.ACCESS_AZOUPH + offset2)
        end
    else
        local hasPermit = player:hasKeyItem(tpz.ki.RUNIC_PORTAL_USE_PERMIT)
        local runicPortals = player:getTeleport(tpz.teleport.type.RUNIC_PORTAL)
        local mercRank = tpz.besieged.getMercenaryRank(player)
        local points = player:getCurrency("imperial_standing")
        local hasAstral = tpz.besieged.getAstralCandescence()
        player:startEvent(101, hasPermit and tpz.ki.RUNIC_PORTAL_USE_PERMIT or 0, runicPortals, mercRank, points, 0, hasAstral, hasPermit and 1 or 0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local offset = nil
    if csid == 101 then
        if option >= 101 and option <= 106 then
            offset = option - 101
            player:delKeyItem(tpz.ki.RUNIC_PORTAL_USE_PERMIT)
        elseif option >= 1001 and option <= 1006 then
            offset = option - 1001
            player:delCurrency("imperial_standing", 200)
        end
    elseif csid >= 120 and csid <= 125 and option == 1 then -- Has Assault Orders
        switch (csid): caseof
        {
            [120] = function ()
                tpz.teleport.to(player, tpz.teleport.id.AZOUPH_SP)
            end,
            [121] = function ()
                tpz.teleport.to(player, tpz.teleport.id.MAMOOL_SP)
            end,
            [122] = function ()
                tpz.teleport.to(player, tpz.teleport.id.HALVUNG_SP)
            end,
            [123] = function ()
                tpz.teleport.to(player, tpz.teleport.id.DVUCCA_SP)
            end,
            [124] = function ()
                tpz.teleport.to(player, tpz.teleport.id.ILRUSI_SP)
            end,
            --[[[125] = function ()
                tpz.teleport.to(player, tpz.teleport.id.NYZUL_SP)
            end,]]
        }
    end
    if offset then
        tpz.teleport.to(player, tpz.teleport.id.AZOUPH_SP + offset)
    end
end
