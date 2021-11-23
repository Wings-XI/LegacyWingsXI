-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Macchi Gazlitah
-- Standard Mechant NPC
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/shop")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        5703,    300,    -- Uleguerand Milk
        5684,    600,    -- Chalaimbille
        --[[
        -- 17905,   100,    -- Wormy Broth -- Out of Era
        5686,    800,    -- Cheese Sandwich
        5729,   3360,    -- Bavarois
        5718,   1300,    -- Cream Puff
        461,    5000,    -- Buffalo Milk Case
        5152,   1280,    -- Buffalo Meat
        4722,  31878,    -- Enfire II
        4723,  30492,    -- Enblizzard II
        4724,  27968,    -- Enaero II
        4725,  26112,    -- Enstone II
        4726,  25600,    -- Enthunder II
        4727,  33000,    -- Enwater II
        4850, 150000,    -- Refresh II
        ]]--
    }
    
    local mess = ID.text.MACCHI_GAZLITAH_SHOP_DIALOG1
    player:setLocalVar("MacchiMess", mess + 3)
    player:setLocalVar("MacchiID", npc:getID())
    local Bought = GetServerVariable("MacchiShopBought")
    local LastBuy = GetServerVariable("MacchiShopLast")
    
    if LastBuy ~= 0 then
        local now = os.time()
        local timeDiff = now - LastBuy
        if timeDiff > 0 then
            -- Decay 10g every second, this really needs to be
            -- further investigated
            Bought = Bought - (timeDiff * 10)
            if Bought < 0 then
                Bought = 0
            end
            SetServerVariable("MacchiShopBought", utils.clamp(Bought, 0, 1000000))
            SetServerVariable("MacchiShopLast", now)
        end
    else
        SetServerVariable("MacchiShopBought", 0)
    end
    
    if Bought >= 250000 then
        -- Full stock
        mess = mess + 2
        stock =
        {
            5703,    100,    -- Uleguerand Milk
            5684,    250,    -- Chalaimbille
            -- 17905,   100,    -- Wormy Broth -- Out of Era
            5686,    800,    -- Cheese Sandwich
            5729,   3360,    -- Bavarois
            5718,   1300,    -- Cream Puff
            461,    5000,    -- Buffalo Milk Case
            5152,   1280,    -- Buffalo Meat
            4722,  31878,    -- Enfire II
            4723,  30492,    -- Enblizzard II
            4724,  27968,    -- Enaero II
            4725,  26112,    -- Enstone II
            4726,  25600,    -- Enthunder II
            4727,  33000,    -- Enwater II
            -- 4850, 150000,    -- Refresh II -- Out of Era
        }
    elseif Bought >= 10000 then
        mess = mess + 1
        stock =
        {
            5703,    150,    -- Uleguerand Milk
            5684,    300,    -- Chalaimbille
            -- 17905,   100,    -- Wormy Broth -- Out of Era
            5686,    800,    -- Cheese Sandwich
            5729,   3360,    -- Bavarois
            5718,   1300,    -- Cream Puff
        }
    end

    player:showText(npc, mess)
    tpz.shop.general(player, stock, JEUNO)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
