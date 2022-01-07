-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm4 (???)
-- Involved in quest: Pirate's Chart
-- !pos -160 4 -131 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/quests")
-----------------------------------

local tempitems =
{
    [1]  = 4148,-- Antidoate
    [2]  = 4112,-- Potion
    [3]  = 4113,-- Potion +1
    [4]  = 4114,-- Potion +2
    [5]  = 4115,-- Potion +3
    [6]  = 4206,-- Catholicon
    [7]  = 4202,-- Daedalus Wing
    [8]  = 4151,-- Echo Drops
    [9]  = 4174,-- Elixir
    [10] = 4128,-- Ether
    [11] = 4129,-- Ether +1
    [12] = 4130,-- Ether +2
    [13] = 4131,-- Ether +3
    [14] = 4150,-- Eye Drops
    [15] = 4301,-- Pear au Lait
    [16] = 4164,-- Prism Powder
    [17] = 4155,-- Remedy
    [18] = 4165,-- Silent Oil
    [19] = 4425,-- Tomato Juice
}

function RemoveTempItems(player)
    for k, v in pairs(tempitems) do
         if player:hasItem(v, 3) then
            player:delItem(v, 1, tpz.inventoryLocation.TEMPITEMS)
        end
    end
end

function onTrade(player, npc, trade)
    if player:getPartySize() > 3 then
        player:messageSpecial(ID.text.TOO_MANY_IN_PARTY, 3)
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageSpecial(ID.text.ALLIANCE_NOT_ALLOWED, 0)
    else
        if npcUtil.tradeHas(trade, 1874) then
            player:startEvent(14, 0, 0, 0, 3, 0, 0, 0, 0)
        end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.MONSTERS_KILLED_ADVENTURERS)
end

function onEventUpdate(player, csid, option)
    panictaru = GetNPCByID(ID.npc.PIRATE_CHART_TARU)
    QM = GetNPCByID(ID.npc.PIRATE_CHART_QM)

    if csid == 14 and option == 0 then
        panictaru:setAnimation(tpz.animation.NONE)
        player:confirmTrade()
        QM:setStatus(tpz.status.DISAPPEAR)
        player:addPartyEffect(143, 20, 0, 0) -- Add Level Restriction of 20
        player:addPartyEffect(276, 10, 0, 0) -- Add Confrontation Status to allow attacking the mobs
        local party = player:getParty()   
            for _,member in pairs(party) do
                member:ChangeMusic(0, 136)
                member:ChangeMusic(1, 136)
                member:ChangeMusic(2, 136)
                member:ChangeMusic(3, 136)
                member:delStatusEffectsByFlag(tpz.effectFlag.DISPELABLE)
                RemoveTempItems(member)
                member:setLocalVar("Chart", 1)
            end     
    end
end

function onEventFinish(player, csid, option)

    local mobs =
        {
            ID.mob.HOUU_THE_SHOALWADER,
            ID.mob.BEACH_MONK,
            ID.mob.HEIKE_CRAB,   
        }
    if csid == 14 and option == 0 then
        local panictaru  = GetNPCByID(ID.npc.PIRATE_CHART_TARU)
        local QM         = GetNPCByID(ID.npc.PIRATE_CHART_QM)
        local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)

        panictaru:setStatus(tpz.status.NORMAL)
        shimmering:setStatus(tpz.status.NORMAL)
        panictaru:timer(3000 , function(panictaru) panictaru:sendNpcEmote(shimmering, tpz.emote.POINT, tpz.emoteMode.MOTION) shimmering:showText(panictaru, ID.text.SHIMMERY_POINT) end)
        panictaru:timer(23000, function(panictaru) panictaru:sendNpcEmote(shimmering, tpz.emote.PANIC, tpz.emoteMode.MOTION) shimmering:showText(panictaru, ID.text.HURRY_UP) end)
        panictaru:timer(33000, function(panictaru) panictaru:sendNpcEmote(shimmering, tpz.emote.PANIC, tpz.emoteMode.MOTION) shimmering:showText(panictaru, ID.text.ITS_COMING) end)
        panictaru:timer(43000, function(panictaru) panictaru:sendNpcEmote(shimmering, tpz.emote.PANIC, tpz.emoteMode.MOTION) shimmering:showText(panictaru, ID.text.THREE_OF_THEM)  end)
        panictaru:timer(45000, function(panictaru) panictaru:showText(panictaru, ID.text.NOOOOO) end)
        panictaru:timer(45000, function(panictaru) panictaru:entityAnimationPacket("dead") shimmering:showText(panictaru, ID.text.CRY_OF_ANGUISH) end)
        panictaru:timer(50000, function(panictaru) panictaru:setStatus(tpz.status.DISAPPEAR) panictaru:entityAnimationPacket("stnd") end)        
        player:timer(50000, function(player, npc) npcUtil.popFromQM(player, QM, mobs, {claim=true, hide = 1}) end)
    end
end