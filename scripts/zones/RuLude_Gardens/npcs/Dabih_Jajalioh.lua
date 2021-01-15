-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Dabih Jajalioh
-- Standard Merchant NPC
-- TODO: Add support for occasional stock.
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/shop")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local stock =
    {
        948,      60,    -- Carnation
        636,     119,    -- Chamomile
        958,     120,    -- Marguerite
        949,      96,    -- Rain Lily
        941,      80,    -- Red Rose
        951,     110,    -- Wijnruit
        --[[
        957,     120,    -- Amaryllis (Occasionally)
        574,     900,    -- Fruit Seeds (Occasionally)
        1239,    490,    -- Goblin Doll (Occasionally)
        1240,    165,    -- Koma (Occasionally)
        956,     120,    -- Lilac (Occasionally)
        1446,  50000,    -- Lacquer Tree Log (Occasionally)
        1441, 250000,    -- Libation Abjuration (Occasionally)
        630,      88,    -- Ogre Pumpkin (Occasionally)
        4750, 500000,    -- Scroll of Reraise III (Occasionally)
        1241,    354,    -- Twinkle Powder (Occasionally)
        2312,   1040,    -- Chocobo Egg (Occasionally)
        --]]
    }
    local mess = ID.text.DABIHJAJALIOH_SHOP_DIALOG -- i'm still new...
    
    local Bought = player:getCharVar("DabihShopBought")
    local Expiry = player:getCharVar("DabihShopExpiry")
    
    print(string.format("Dabih Bought = %u",Bought))
    
    if Expiry == 0 and Bought > 179 then -- 15 stacks or more
        Expiry = os.time() + 86400 -- 1 day
        player:setCharVar("DabihShopExpiry",os.time() + 604800)
    elseif Expiry ~= 0 and os.time() > Expiry then
        Expiry = 0
        player:setCharVar("DabihShopExpiry",0)
        player:setCharVar("DabihShopBought",0)
    end
    
    if Expiry ~= 0 then
        if os.time() + 82800 < Expiry then -- within an hour of getting exclusive opened
            mess = mess + 3 -- my new shipment has finally come in
        else
            mess = mess + 1 -- hello there cutie! the M&P has a lot of useful items
        end
        stock =
        {
            948,      60,    -- Carnation
            636,     119,    -- Chamomile
            958,     120,    -- Marguerite
            949,      96,    -- Rain Lily
            941,      80,    -- Red Rose
            951,     110,    -- Wijnruit
            957,     120,    -- Amaryllis (Occasionally)
            574,     900,    -- Fruit Seeds (Occasionally)
            1239,    490,    -- Goblin Doll (Occasionally)
            1240,    165,    -- Koma (Occasionally)
            956,     120,    -- Lilac (Occasionally)
            1446,  50000,    -- Lacquer Tree Log (Occasionally)
            1441, 250000,    -- Libation Abjuration (Occasionally)
            630,      88,    -- Ogre Pumpkin (Occasionally)
            4750, 500000,    -- Scroll of Reraise III (Occasionally)
            1241,    354,    -- Twinkle Powder (Occasionally)
            2312,   1040,    -- Chocobo Egg (Occasionally)
        }
    end
    
    player:showText(npc, mess)
    tpz.shop.general(player, stock, JEUNO)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
