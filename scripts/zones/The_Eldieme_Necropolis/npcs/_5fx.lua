-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Tallow Candle
-- !pos 100.01 5.69 -106.07
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
-----------------------------------

function onTrade(player, npc, trade)
    local tradeCount = GetServerVariable("SkullTradeCount")
    local tradeWindow = GetServerVariable("SkullTradeTimer")
    local active = npc:getLocalVar("BrazierActive")

    if npcUtil.tradeHas(trade, 768) then
        if os.time() < tradeWindow and os.time() > active then
            npc:setLocalVar("BrazierActive", os.time() + 10)

            if tradeCount == 1 then
                SetServerVariable("SkullTradeCount", 2)
                player:messageSpecial(ID.text.SKULL_FIVE_REMAIN)
                player:confirmTrade()
            elseif tradeCount == 2 then
                SetServerVariable("SkullTradeCount", 3)
                player:messageSpecial(ID.text.SKULL_FOUR_REMAIN)
                player:confirmTrade()
            elseif tradeCount == 3 then
                SetServerVariable("SkullTradeCount", 4)
                player:messageSpecial(ID.text.SKULL_THREE_REMAIN)
                player:confirmTrade()
            elseif tradeCount == 4 then
                SetServerVariable("SkullTradeCount", 5)
                player:messageSpecial(ID.text.SKULL_TWO_REMAIN)
                player:confirmTrade()
            elseif tradeCount == 5 then
                SetServerVariable("SkullTradeCount", 6)
                player:messageSpecial(ID.text.SKULL_ONE_REMAIN)
                player:confirmTrade()
            elseif tradeCount == 6 then
                SetServerVariable("SkullTradeCount", 0)
                player:messageSpecial(ID.text.SKULL_SPAWN)
                player:confirmTrade()

                -- Spawn all 7 Skulls
                SpawnMob(ID.mob.SKULL_OF_ENVY)
                SpawnMob(ID.mob.SKULL_OF_GLUTTONY)
                SpawnMob(ID.mob.SKULL_OF_GREED)
                SpawnMob(ID.mob.SKULL_OF_LUST)
                SpawnMob(ID.mob.SKULL_OF_PRIDE)
                SpawnMob(ID.mob.SKULL_OF_SLOTH)
                SpawnMob(ID.mob.SKULL_OF_WRATH)
            end
        elseif os.time() > active then
            SetServerVariable("SkullTradeCount", 1)
            SetServerVariable("SkullTradeTimer", os.time() + 10)
            player:messageSpecial(ID.text.SKULL_SIX_REMAIN)
            player:confirmTrade()
        end
    end
end

function onTrigger(player, npc)
    local timer = GetServerVariable("SkullRespawn")
    local active = npc:getLocalVar("BrazierActive")

    if os.time() < active then
        player:messageSpecial(ID.text.BRAZIER_ACTIVE)
    elseif os.time() > timer and os.time() > active then
        player:messageSpecial(ID.text.BRAZIER_OUT, 0, 768)
    else
        player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end