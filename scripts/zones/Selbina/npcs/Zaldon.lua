-----------------------------------
-- Area: Selbina
--  NPC: Zaldon
-- Involved in Quests: Under the sea, A Boy's Dream
-- Starts and Finishes: Inside the Belly
-- !pos -13 -7 -5 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

-- TODO: need more accurate quest fish (used level as a guide for now)
-- data from http://wiki.ffxiclopedia.org/wiki/Inside_the_Belly
local fishRewards =
{
    ----- Quest 1 -----
    [4428] = -- Dark Bass
    {
        gil = 10,
        items =
        {
            {chance = 4.9, itemId = 772}, -- Green Rock
        }
    },
    [4469] = -- Giant Catfish
    {
        gil = 50,
        title = tpz.title.CORDON_BLEU_FISHER,
        items =
        {
            {chance = 7.2, itemId = 17076}, -- Earth Wand
        }
    },
    [4481] = -- Ogre Eel
    {
        gil = 16,
        title = tpz.title.CORDON_BLEU_FISHER,
        items =
        {
            {chance = 2.6, itemId = 13480}, -- Turquoise Ring
        }
    },
    [5141] = -- Veydal Wrasse
    {
        gil = 225,
        items =
        {
            {chance = 5, itemId = 4361}, -- Nebimonite (guessing 5%. Wiki unknown.)
            {chance = 5, itemId = 888}, -- Seashell (guessing 5%. Wiki unknown.)
        }
    },
    ----- Quest 2 -----
    [4385] = -- Zafmlug Bass
    {
        gil = 15,
        items =
        {
            {chance = 1.4, itemId = 770}, -- Blue Rock
        }
    },
    [4306] = -- Giant Donko
    {
        gil = 96,
        items =
        {
            {chance = 4.7, itemId = 1833}, -- Broken Halcyon Fishing Rod
        }
    },
    [4479] = -- Bhefhel Marlin
    {
        gil = 150,
        items =
        {
            {chance = 3.0, itemId = 1873}, -- Brigand's Chart
            {chance = 4.4, itemId = 1874}, -- Pirate's Chart
        }
    },
    [4471] = -- Bladefish
    {
        gil = 200,
        items =
        {
            {chance = 11.7, itemId = 17002}, -- Robber Rig
        }
    },
    [4451] = -- Silver Shark
    {
        gil = 250,
        title = tpz.title.ACE_ANGLER,
        items =
        {
            {chance = 1.3, itemId = 16837}, -- Trident
        }
    },
    ----- Quest 3 -----
    [4307] = -- Jungle Catfish
    {
        gil = 300,
        items =
        {
            {chance = 3, itemId = 1832}, -- Broken Hume Fishing Rod
        }
    },
    [4477] = -- Gavial Fish
    {
        gil = 250,
        items =
        {
            {chance = 5.0, itemId = 13361}, -- Drone Earring
        }
    },
    [5470] = -- Pirarucu
    {
        gil = 516,
        items =
        {
            {chance = 5, itemId = 1122}, -- Wyvern Skin (guessing 5%. Wiki unknown.)
            {chance = 2.5, itemId = 2523}, -- Peiste Skin (guessing 2.5%. Wiki unknown.)
        }
    },
    [4454] = -- Emperor Fish
    {
        gil = 300,
        items =
        {
            {chance = 1, itemId = 12955}, -- Cuir Highboots (guessing 1%. Wiki says 0%.)
        }
    },
    [5467] = -- Megalodon
    {
        gil = 532,
        items =
        {
            {chance = 3, itemId = 483}, -- Broken Mithran Fishing Rod (guessing 3%. Wiki unknown.)
            {chance = 3, itemId = 17380}, -- Mithran Fishing Rod (guessing 3%. Wiki unknown.)
        }
    },
    [5462] = -- Morinabaligi
    {
        gil = 300,
        items =
        {
            {chance = 5, itemId = 12699}, -- Cuir Gloves (guessing 5%. Wiki unknown.)
        }
    },
    ----- Quest 4 -----
    [5133] = -- Pterygotus
    {
        gil = 390,
        items =
        {
            {chance = 6.6, itemId = 795}, -- Lapis Lazuli
        }
    },
    [5140] = -- Kalkanbaligi
    {
        gil = 390,
        items =
        {
            {chance = 3.3, itemId = 16184}, -- Flat Shield
        }
    },
    [4463] = -- Takitaro
    {
        gil = 350,
        items =
        {
            {chance = 2.1, itemId = 942}, -- Philosopher's Stone
        }
    },
    [4475] = -- Sea Zombie
    {
        gil = 350,
        items =
        {
            {chance = 23.4, itemId = 17006}, -- Drill Calamary
        }
    },
    [4476] = -- Titanictus
    {
        gil = 350,
        title = tpz.title.LU_SHANGLIKE_FISHER_KING,
        items =
        {
            {chance = 1.4, itemId = 16533}, -- Ancient Sword
        }
    },
    [5137] = -- Turnabaligi
    {
        gil = 340,
        items =
        {
            {chance = 0.8, itemId = 1262}, -- Chunk of Dark Ore
            {chance = 1.6, itemId = 1256}, -- Chunk of Ice Ore
            {chance = 1.3, itemId = 1260}, -- Chunk of Water Ore
        }
    },
    [4309] = -- Cave Cherax
    {
        gil = 800,
        items =
        {
            {chance = 23.2, itemId = 17007}, -- Dwarf Pugil
        }
    },
    [4319] = -- Tricorn
    {
        gil = 810,
        items =
        {
            {chance = 4, itemId = 645}, -- Chunk of Darksteel Ore (guessing 4%. Wiki unknown.)
        }
    },
    ----- Unlisted 120+ -----
    [4308] = -- Giant Chirai
    {
        gil = 550,
        items =
        {
            {chance = 1.2, itemId = 1278}, -- Spool of Twinthread
        }
    },
    [5127] = -- Gugrusaurus
    {
        gil = 880,
        items =
        {
            {chance = 0.4, itemId = 1837}, -- Saber Shoot
        }
    },
    [5129] = -- Lik
    {
        gil = 880,
        items =
        {
            {chance = 0.5, itemId = 1826}, -- Spool of Opal Silk
        }
    },
    [4305] = -- Ryugu Titan
    {
        gil = 800,
        items =
        {
            {chance = 1.0, itemId = 18377}, -- Mercurial Sword
        }
    },
    [4480] = -- Gugru Tuna
    {
        gil = 50,
        items =
        {
            {chance = 2.5, itemId = 19186}, -- Tiny Tathlum
        }
    },
    [5136] = -- Istavrit
    {
        gil = 50,
        items =
        {
            {chance = 1.6, itemId = 944}, -- Venom Dust
        }
    },
    [5475] = -- Gigant Octopus
    {
        gil = 119,
        items =
        {
            {chance = 1.6, itemId = 929}, -- Black Ink
        }
    },
    [4474] = -- Gigant Squid
    {
        gil = 300,
        items =
        {
            {chance = 2.5, itemId = 12317}, -- Flame Shield (Need source for drop %, just went with 2.5 to match other misc gear.)
        }
    },
    [5135] = -- Rhinochimera
    {
        gil = 300,
        items =
        {
            {chance = 3.2, itemId = 11624}, -- Solon Torque
        }
    },
    [4304] = -- Grimmonite
    {
        gil = 350,
        items =
        {
            {chance = 1, itemId = 13445}, -- Gold Ring  (Not really any good sources on drop % on these, just guessed.)
            {chance = 2, itemId = 13446}, -- Mythril Ring
            {chance = 3, itemId = 13456}, -- Silver Ring
        }
    },
    [4316] = -- Armored Pisces
    {
        gil = 350,
        items =
        {
            {chance = 0.4, itemId = 13736}, -- Stolid Breastplate
        }
    },
    [5134] = -- Mola Mola
    {
        gil = 487,
        items =
        {
            {chance = 1.8, itemId = 16850}, -- Mercurial Spear
        }
    },
    [5450] = -- Lakerda
    {
        gil = 51,
        items =
        {
            {chance = 6, itemId = 792}, -- Pearl
            {chance = 1.9, itemId = 793}, -- Black Pearl
        }
    },
    [5463] = -- Yayinbaligi
    {
        gil = 50,
        items =
        {
            {chance = 2.5, itemId = 14649}, -- Telluric Ring
        }
    },
    [5451] = -- Kilicbaligi
    {
        gil = 150,
        items =
        {
            {chance = 2.5, itemId = 16606}, -- Rusty Greatsword
        }
    },
    [5455] = -- Ahtapot
    {
        gil = 350,
        items =
        {
            {chance = 10.2, itemId = 2886}, -- Mildewy Ingot
            {chance = 18.5, itemId = 2887}, -- Decayed Ingot
        }
    },
    [5471] = -- Gerrothorax
    {
        gil = 423,
        items =
        {
            {chance = 1.2, itemId = 11492}, -- Risky Patch
        }
    },
}

local function tradeFish(player, fishId)
    player:setCharVar("insideBellyFishId", fishId)
    player:setCharVar("insideBellyItemIdx", 0)
    player:confirmTrade()

    local rewards = fishRewards[fishId].items
    local roll = math.random(1000) / 10
    local sum = 0
    local item = nil

    for i = 1, #rewards do
        sum = sum + rewards[i].chance

        if roll <= sum then
            found = true
            player:setCharVar("insideBellyItemIdx", i)
            item = rewards[i].itemId
            break
        end
    end

    if item then
        player:startEvent(166, 0, item)
    else
        player:startEvent(167)
    end
end

local function giveReward(player, csid)
    if csid == 166 or csid == 167 then
        local fishId  = player:getCharVar("insideBellyFishId")
        local itemIdx = player:getCharVar("insideBellyItemIdx")
        local reward = fishRewards[fishId]

        local itemId = nil
        local itemQt = nil
        local rewardSet = {}

        -- Reset the character variables
        player:setCharVar("insideBellyFishId", 0)
        player:setCharVar("insideBellyItemIdx", 0)

        -- Regardless of success or failure, give gil, and set the char vars to 0
        player:addGil(GIL_RATE * reward.gil)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE * reward.gil)

        --If successful (other than gil) give the item
        if itemIdx > 0 then     -- Successful reward (other than gil)
            local r = reward.items[itemIdx]
            itemId = r.itemId
            itemQt = 1
            if r.min ~= nil and r.max ~= nil then
                itemQt = math.random(r.min, r.max)
            end

            -- Issue the reward
            rewardSet = {itemId, itemQt}
            local traded = npcUtil.giveItem(player, {rewardSet})

            -- If the player has received a reward, mark the quest log as complete if it's accepted
            if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.INSIDE_THE_BELLY) == QUEST_ACCEPTED then
                player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.INSIDE_THE_BELLY)
            end

            -- If there's a title to grant based on the reward, grant it.
            if reward.title ~= nil then
                player:addTitle(reward.title)
            end
        end
    end



end

function onTrade(player, npc, trade)
    local underTheSea    = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNDER_THE_SEA)
    local insideTheBelly = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.INSIDE_THE_BELLY)

    -- UNDER THE SEA
    if underTheSea == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.ETCHED_RING) and npcUtil.tradeHas(trade, 4501) then
        player:confirmTrade()
        if math.random(100) <= 20 then
            player:startEvent(35) -- Ring found !
        else
            player:startEvent(36) -- Ring not found...
        end

    -- A BOY'S DREAM
    elseif player:getCharVar("aBoysDreamCS") >= 4 and npcUtil.tradeHas(trade, 4562) then
        player:startEvent(85)

    -- INSIDE THE BELLY
    elseif insideTheBelly == QUEST_ACCEPTED or insideTheBelly == QUEST_COMPLETED then
        for fish, v in pairs(fishRewards) do
            if npcUtil.tradeHas(trade, fish) then
                tradeFish(player, fish)
                break
            end
        end
    end
end

function onTrigger(player, npc)

    local theRealGift    = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_REAL_GIFT)
    local insideTheBelly = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.INSIDE_THE_BELLY)
    local fishingSkill = player:getSkillLevel(tpz.skill.FISHING)
    local fishingRank = player:getSkillRank(tpz.skill.FISHING)
    local realSkill = (fishingSkill - fishingRank) / 32

    -- UNDER THE SEA
    if player:getCharVar("underTheSeaVar") == 3 then
        player:startEvent(34, 4501) -- During quest "Under the sea" - 3rd dialog

    -- INSIDE THE BELLY
    elseif realSkill >= 30 and theRealGift == QUEST_COMPLETED and insideTheBelly == QUEST_AVAILABLE then
        player:startEvent(161)
    elseif realSkill >= 30 and realSkill < 39 and (insideTheBelly == QUEST_ACCEPTED or insideTheBelly == QUEST_COMPLETED) then
        player:startEvent(162, 4428, 4469, 4481, 5141)
    elseif realSkill >= 40 and realSkill < 49 and (insideTheBelly == QUEST_ACCEPTED or insideTheBelly == QUEST_COMPLETED) then
        player:startEvent(163, 4385, 4306, 4479, 4471, 4451)
    elseif realSkill >= 50 and realSkill <= 74 and (insideTheBelly == QUEST_ACCEPTED or insideTheBelly == QUEST_COMPLETED) then
        player:startEvent(164, 4307, 4477, 5470, 4454, 5467, 5462)
    elseif realSkill >= 75 and (insideTheBelly == QUEST_ACCEPTED or insideTheBelly == QUEST_COMPLETED) then
        player:startEvent(165, 5133, 5140, 4463, 4475, 4476, 5137, 4309, 4319)

    -- STANDARD DIALOG
    else
        player:startEvent(150)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- UNDER THE SEA
    if csid == 34 then
        player:setCharVar("underTheSeaVar", 4)
    elseif csid == 35 then
        npcUtil.giveKeyItem(player, tpz.ki.ETCHED_RING)

    -- A BOY'S DREAM
    elseif csid == 85 then
        npcUtil.giveKeyItem(player, tpz.ki.KNIGHTS_BOOTS)
        player:setCharVar("aBoysDreamCS", 6)
        player:confirmTrade()

    -- INSIDE THE BELLY
    elseif csid == 161 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.INSIDE_THE_BELLY)
    elseif csid == 166 or csid == 167 then
        giveReward(player, csid)
    end
end
