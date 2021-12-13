-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Dabih Jajalioh
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/shop")
require("scripts/globals/utils")

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
    player:setLocalVar("DabihMess", mess + 3)
    player:setLocalVar("DabihID", npc:getID())
    local Bought = GetServerVariable("DabihShopBought")
    local LastBuy = GetServerVariable("DabihShopLast")
    
    if LastBuy ~= 0 then
        local now = os.time()
        local timeDiff = math.floor((now - LastBuy) / 60)
        if timeDiff > 0 then
            -- Decay 1 item every minute, this really needs to be
            -- further investigated
            Bought = Bought - timeDiff
            if Bought < 0 then
                Bought = 0
            end
            SetServerVariable("DabihShopBought", utils.clamp(Bought, 0, 20000))
            SetServerVariable("DabihShopLast", now)
        end
    else
        SetServerVariable("DabihShopBought", 0)
    end
        
    if Bought >= 4150 then
        -- Full stock
        mess = mess + 2
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
    elseif Bought >= 180 then
        mess = mess + 1
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
            630,      88,    -- Ogre Pumpkin (Occasionally)
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
