-----------------------------------
-- Area: Ilrusi Atoll
-- NPC: Cursed Chest
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.CHEST)

    local npcID = npc:getID()
    --local npcPOS = npc:getpos()
    local instance = npc:getInstance()
    local figureheadChest = instance:getProgress()
    local npcPOS = instance:getEntity(bit.band(npcID, 0xFFF), tpz.objType.NPC):getPos()

    if (npcID == figureheadChest) then
        player:messageSpecial(ID.text.GOLDEN)
        npc:entityAnimationPacket("open")
        instance:setProgress(1)
        npc:timer(15000, function(npc) npc:entityAnimationPacket("kesu") end)
        npc:timer(16000, function(npc) npc:setStatus(tpz.status.DISAPPEAR) end)
        for i = ID.mob[GOLDEN_SALVAGE].ILRUSI_CURSED_CHEST_OFFSET, ID.mob[GOLDEN_SALVAGE].ILRUSI_CURSED_CHEST_OFFSET + 11 do
             instance:getEntity(bit.band(i, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.DISAPPEAR)
             DespawnMob(i, instance)
        end
    else
        local mob_coffer = GetMobByID(npcID, instance)
        mob_coffer:spawn()
        mob_coffer:setPos(npcPOS.x, npcPOS.y, npcPOS.z, npcPOS.rot)
        mob_coffer:updateClaim(player)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
