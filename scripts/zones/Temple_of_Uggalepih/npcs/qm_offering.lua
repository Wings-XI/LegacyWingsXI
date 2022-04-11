-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Uggalepih Offering ITEM)
-- !pos 388 0 269 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasItem(1183) then
        if npcUtil.giveItem(player, 1183) then -- Uggalepih Offering
            local spawnPoints =
                {
                    {386.253,   -0.300,     269.696},
                    {386.253,   -0.300,     250.342},
                    {374.216,   -0.300,     272.746},
                    {373.432,   -0.300,     250.259},
                    {309.800,   0.000,      233.960},
                    {292.989,   0.000,      231.168},
                }
            local point = spawnPoints[math.random(#spawnPoints)]
            local delay = math.random(900, 7200) -- 15 minutes to 2 hours

            npc:setStatus(tpz.status.DISAPPEAR)
            npcUtil.queueMove(npc, point, delay)
            npc:updateNPCHideTime(delay) 
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end
