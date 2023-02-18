-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Zaranf
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

local ASKAR = 0
local DENALI = 1
local GOLIARD = 2

local HEAD = 0
local BODY = 1
local HANDS = 2
local LEGS = 3
local FEET = 4

--[[
    Turn in items:
                    Item Name           Item ID
        Askar:      Fire Crystal        4096
        Goliard:    Ice Crystal         4097
        Denali:     Wind Crystal        4098

        Head:       Oricalcum Ingot     747
        Body:       Imp. Wootz Ingot    686
        Hands:      Bloodwood Lumber    730
        Legs:       Wamoura Cloth       2289
        Feet:       Marid Leather       2152
]]

local NYZUL_ARMOR =
{
    [ASKAR] =
    {
        requiredCrystal = 4096,
        [HEAD] = {
            itemId = 16106,
            itemName = "Askar Zucchetto",
            requiredMaterial = 747
        },
        [BODY] = {
            itemId = 14568,
            itemName = "Askar Korazin",
            requiredMaterial = 686
        },
        [HANDS] = {
            itemId = 14983,
            itemName = "Askar Manopolas",
            requiredMaterial = 730
        },
        [LEGS] = {
            itemId = 15647,
            itemName = "Askar Dirs",
            requiredMaterial = 2289
        },
        [FEET] = {
            itemId = 15733,
            itemName = "Askar Gambieras",
            requiredMaterial = 2152
        }
    },
    [DENALI] =
    {
        requiredCrystal = 4098,
        [HEAD] = {
            itemId = 16107,
            itemName = "Denali Bonnet",
            requiredMaterial = 747
        },
        [BODY] = {
            itemId = 14569,
            itemName = "Denali Jacket",
            requiredMaterial = 686
        },
        [HANDS] = {
            itemId = 14984,
            itemName = "Denali Wristbands",
            requiredMaterial = 730
        },
        [LEGS] = {
            itemId = 15648,
            itemName = "Denali Kecks",
            requiredMaterial = 2289
        },
        [FEET] = {
            itemId = 15734,
            itemName = "Denali Gamashes",
            requiredMaterial = 2152
        }
    },
    [GOLIARD] =
    {
        requiredCrystal = 4097,
        [HEAD] = {
            itemId = 16108,
            itemName = "Goliard Chapeau",
            requiredMaterial = 747
        },
        [BODY] = {
            itemId = 14570,
            itemName = "Goliard Saio",
            requiredMaterial = 686
        },
        [HANDS] = {
            itemId = 14985,
            itemName = "Goliard Cuffs",
            requiredMaterial = 730
        },
        [LEGS] = {
            itemId = 15649,
            itemName = "Goliard Trews",
            requiredMaterial = 2289
        },
        [FEET] = {
            itemId = 15735,
            itemName = "Goliard Clogs",
            requiredMaterial = 2152
        }

    }
}

local function giveBackMaterial(player)
    local materialId = 0
    local selectedSet = player:getCharVar("NyzulResetSelectedSet")
    local selectedSlot = player:getCharVar("NyzulResetSelectedSlot")
    materialId = NYZUL_ARMOR[selectedSet][selectedSlot].requiredMaterial
    if materialId == 0 then
        player:PrintToPlayer("Zaranf : Well now this is odd... How did you manage to mess things up this badly? I'd blame Serverdingo, if I were you.", 0xD)
        player:PrintToPlayer(selectedSet)
        player:PrintToPlayer(selectedSlot)
        materialId = 4096
    end

    return npcUtil.giveItem(player,materialId)
end

local function giveArmor(player)
    player:PrintToPlayer("Zaranf : I see... Very well. I'll take that key of yours now...", 0xD)
    local rewardId = NYZUL_ARMOR[player:getCharVar("NyzulResetSelectedSet")][player:getCharVar("NyzulResetSelectedSlot")].itemId
    if npcUtil.giveItem(player,rewardId) then
        player:delKeyItem(tpz.ki.RUNIC_KEY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, tpz.ki.RUNIC_KEY)
        player:PrintToPlayer("Zaranf : Haha! Just a few more keys, and it'll finally be mine... All mi-- W-Wait are you still here? You have what you want, now leave me!", 0xD)
        player:PrintToPlayer("Your Nyzul Isle progress has been reset. Required weaponskill points for Mythic weaponskills remains at 250. Get to climbing!", 0x1F)
        player:setCharVar("NyzulResetQuest",3)
        player:setCharVar("NyzulResetSelectedSet", 0)
        player:setCharVar("NyzulResetSelectedSlot", 0)
        player:setCharVar("Nyzul_RunicDiscProgress", 0)
        player:setCharVar("NyzulClimbNumber",player:getCharVar("NyzulClimbNumber")+1)
        return true
    else
        player:PrintToPlayer("Zaranf : Hmmm, hold on... It appears you require some more time to think on this...", 0xD)
        return false
    end
end

local function checkSet(trade, armorSet)
    --todo: there's probably a better way to map this, with something like NYZUL_ARMOR[crystalID][materialID] - but not sure how to validate exact trade using this method.
    --      ... Or rather, I'm too lazy. Plenty of ways.
    if npcUtil.tradeHasExactly(trade, {NYZUL_ARMOR[armorSet].requiredCrystal, NYZUL_ARMOR[armorSet][HEAD].requiredMaterial}) then
        return HEAD
    elseif npcUtil.tradeHasExactly(trade, {NYZUL_ARMOR[armorSet].requiredCrystal, NYZUL_ARMOR[armorSet][BODY].requiredMaterial}) then
        return BODY
    elseif npcUtil.tradeHasExactly(trade, {NYZUL_ARMOR[armorSet].requiredCrystal, NYZUL_ARMOR[armorSet][HANDS].requiredMaterial}) then
        return HANDS
    elseif npcUtil.tradeHasExactly(trade, {NYZUL_ARMOR[armorSet].requiredCrystal, NYZUL_ARMOR[armorSet][LEGS].requiredMaterial}) then
        return LEGS
    elseif npcUtil.tradeHasExactly(trade, {NYZUL_ARMOR[armorSet].requiredCrystal, NYZUL_ARMOR[armorSet][FEET].requiredMaterial}) then
        return FEET
    else
        return -1
    end
end


function onTrade(player, npc, trade)

    -- Making selection
    if player:getCharVar("NyzulResetQuest") == 1 then

        local selectedSet = -1
        local selectedSlot = -1

        --Askar
        local slot = checkSet(trade, ASKAR)
        if slot ~= -1 then
            selectedSet = ASKAR
            selectedSlot = slot
        else
            slot = checkSet(trade, DENALI)
            if slot ~= -1 then
                selectedSet = DENALI
                selectedSlot = slot
            else
                slot = checkSet(trade, GOLIARD)
                if slot ~= -1 then
                    selectedSet = GOLIARD
                    selectedSlot = slot
                end
            end
        end

        if selectedSet >= 0 and selectedSlot >= 0 then
            player:PrintToPlayer("Zaranf : Wait, y-you're actually going to do it?! What a sucke-- Er, I mean, wise choice adventurer...", 0xD)
            player:PrintToPlayer(string.format("Zaranf : %s? Well, this is the last one of those that I have... (Well, aside from the five others in my delivery box...)",NYZUL_ARMOR[selectedSet][selectedSlot].itemName), 0xD)
            player:PrintToPlayer("Zaranf : Now for my payment... Bring me one ENTIRE Imperial Bronze Piece, and it's a done deal. Or just let me know if you're getting cold feet...", 0xD)
            player:PrintToPlayer("WARNING: On trading the bronze piece, your Nyzul Isle floor progress will be reset. Required ws points for Mythic weaponskills will remain at 250.", 0x1F)
            player:setCharVar("NyzulResetSelectedSet",selectedSet)
            player:setCharVar("NyzulResetSelectedSlot",selectedSlot)
            player:setCharVar("NyzulResetQuest",2)
            player:confirmTrade() -- take the crystal + material
        else --The player traded something other than an expected combination
            player:PrintToPlayer("Zaranf : ...I'm afraid I don't understand. Must I remind you of what I require?", 0xD)
        end
    -- Confirming Selection
    elseif player:getCharVar("NyzulResetQuest") == 2 then
        if npcUtil.tradeHasExactly(trade, {2184}) then
            if giveArmor(player) then
                player:confirmTrade() -- take the bronze piece
            end
        else
            player:PrintToPlayer("Zaranf : ...What is this? Repeat after me: One. Imperial. Bronze. Piece. Unbelievable... I swear, if you didn't have that key...", 0xD)
        end
    -- Trading him completely out of context (quest is over)
    else
        player:PrintToPlayer("Zaranf : ...What are you doing? Get away from me, you vermin.", 0xD)
    end
end

function onTrigger(player, npc)

    if player:hasKeyItem(tpz.ki.RUNIC_KEY) then
        if player:getCharVar("NyzulResetQuest") == 0 then
            -- Player visiting for the first time since getting Runic Key
            player:PrintToPlayer("Zaranf : Wait! You there! Is that a Runic Key on your person?! Don't lie to me, I can smell it on you...", 0xD)
            player:PrintToPlayer("Zaranf : I don't think you understand, I don't just want that key. I need it! I simply have to have it.", 0xD)
            player:PrintToPlayer("Zaranf : Listen, I-I'll trade you for it! I never made it to floor 100 of that damn place, but I've amassed quite a bit of the isle's armor.", 0xD)
            player:PrintToPlayer("Zaranf : (Though the armor seems far more rare as of late. Not sure why...) Erm, a-anyways!",0xD)
            player:PrintToPlayer("Interact again to continue...", 0x1F)
            player:setCharVar("NyzulResetQuest", 1)
        elseif player:getCharVar("NyzulResetQuest") == 1 then
            -- Player got opening dialogue. Remind them of what they need.
            player:PrintToPlayer("Zanraf : I'll simply need a single crystal and base material to patch up any wear and tear from over the years.", 0xD)
            player:PrintToPlayer("Zanraf :  The crystal? Depends on the style. Askar wields the power of fire, Goliard the power of ice, and Denali the power of wind.", 0xD)
            player:PrintToPlayer("Zanraf :  As for materials... For a head piece, I'll need an Orichalcum Ingot. And body armor would need an Imperial Wootz Ingot.", 0xD)
            player:PrintToPlayer("Zanraf :  Bloodwood Lumber would repair hand armor, and Wamoura Cloth for legs. And, let's say, a Marid Leather for the feet.", 0xD)
            player:PrintToPlayer("Zaranf : Got all that? Don't make me repeat myself. But I will if I have to, if it means I get that damn key of yours...", 0xD)
        elseif player:getCharVar("NyzulResetQuest") == 2 then
            -- Player interacted after trading initial crystal and material. Give material back in case they changed their mind.
            player:PrintToPlayer("Zaranf : Hmm? Having regrets? Or need more time to gather my rather exorbitant fee?~", 0xD)
            player:PrintToPlayer("Zaranf : Very well. Take your trash back then. I'm keeping the crystal, though, in exchange for you wasting my time.", 0xD)
            player:PrintToPlayer("Zaranf : Just know the offer's still on the table if you change your mind. For now...", 0xD)
            if giveBackMaterial(player) then
                player:setCharVar("NyzulResetSelectedSet",0)
                player:setCharVar("NyzulResetSelectedSlot",0)
                player:setCharVar("NyzulResetQuest", 1)
            else
                player:PrintToPlayer("Zaranf : ...Or at least that's what I would say if you had room to carry aforementioned trash.", 0xD)
            end
        elseif player:getCharVar("NyzulResetQuest") == 3 then
            -- Player got another runic key after completing the quest for the first time.
            player:PrintToPlayer("Zaranf : Well hello ther-- W-Wait did you get another Runic Key?!", 0xD)
            player:PrintToPlayer("Zaranf : That musty aroma... That tactile feel that can only be gained through centuries of rust and wear...", 0xD)
            player:PrintToPlayer("Zaranf : There can be no doubt. 'Tis genuine... I must have it. I trust you remember our deal from last time?", 0xD)
            player:PrintToPlayer("Interact again to continue...", 0x1F)
            player:setCharVar("NyzulResetQuest", 1)
        end
    else
        if player:getCharVar("NyzulResetQuest", 3) then
            player:PrintToPlayer("Zaranf : Only a few more keys to go until-- Oh, it's you! Good to see you... (I guess...)", 0xD)
            player:startEvent(668)
        else
            player:startEvent(668)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end