-----------------------------------
--    Starlight Celebrations     --
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
------------------------------------

------------------
-- Event Status --
------------------
function isStarlightEnabled()
    local option = 0
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    if ((month == 12 and day >= 12) or STARLIGHT_YEAR_ROUND) then -- According to wiki Startlight Festival is December 12 - December 31.
        if (STARLIGHT_2007 == 1) then
            option = 1
        end
    end

    return option
end

--------------------------------
-- For the Children Sub-Quest --
--------------------------------
function onStarlightSmilebringersTrade(player, trade, npc)
    local zone = player:getZoneName()
    local ID = zones[player:getZoneID()]
    local contentEnabled = isStarlightEnabled()
    local item = trade:getItemId()

    ------------------
    -- 2007 Edition --
    ------------------
    if (contentEnabled == 1) then
        ----------------------
        -- Presents Allowed --
        ----------------------
        local presents_table = {1742, 1743, 1744, 1745}
        local fireworks_table = {
            4215, -- Popstar
            4216, -- Brilliant Snow
            4217, -- Sparkling Hand
            4218, -- Air Rider
            4167, -- Cracker
            4168, -- Twinkle Shower
            4169, -- Little Comet
        }
        ---------------
        -- Hat Check --
        ---------------
        local head = player:getEquipID(tpz.slot.HEAD)

        for itemInList = 1, #presents_table do
            
            if (item == presents_table[itemInList] and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) < 9)) then
                player:showText(npc, ID.text.GIFT_THANK_YOU)
                player:messageSpecial(ID.text.BARRELS_JOY_TO_CHILDREN)
                player:addFame(HOLIDAY, 31)
                player:tradeComplete()
            elseif (item == fireworks_table[itemInList] and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) < 9)) then
                player:showText(npc, ID.text.GIFT_THANK_YOU)
                player:messageSpecial(ID.text.JOY_TO_CHILDREN)
                player:addFame(HOLIDAY, 15)
                player:tradeComplete()
            elseif ((item == presents_table[itemInList]) and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) >= 9)) or ((item == fireworks_table[itemInList]) and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) >= 9))  then
                player:showText(npc, ID.text.ONLY_TWO_HANDS)
            end

        end
    end
end

----------------------------------------------------------------
-- Apply Zone Decorations, Vendors, and Additional Event NPCs --
----------------------------------------------------------------
function applyStarlightDecorations(zoneid)
    if isStarlightEnabled() ~= 0 then
        local decoration = zones[zoneid].npc.STARLIGHT_DECORATIONS
        if decoration then
            for id, decoration in pairs(decoration) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(tpz.status.NORMAL)
                    local npcstatus = npc:getStatus()
                end
            end
        end
    end
end

function onStarlightMoogleTrade(player, npc, trade)
    if isStarlightEnabled() ~= 0 then
        local zone = player:getZoneName()
        local ID = zones[player:getZoneID()]
        local bodySlot = player:getEquipID(tpz.slot.BODY)
        local dreamRobe = (bodySlot == 14519 or bodySlot == 14520) and true or false

        ------------------
        -- 2007 Edition --
        ------------------
        --------------
        -- NQ Cards --
        --------------
        cardsNQ_table = {
            2119, -- Aldebaran Card
            2120, -- Betelgeuse Card
            2117, -- Canopus Card
            2118, -- Capella Card
            2114, -- Pleiades Card
        }
        --------------
        -- HQ Cards --
        --------------
        cardsHQ_table = {
            2115, -- Rigel Card
            2116, -- Sirius Card
            2540, -- Magellan Card
            2541, -- Andromeda Card
            2739, -- Perseus Card
        }
        ------------------------
        -- Confirmation Cards --
        ------------------------
        confirm_table = {
            2738, -- Cassiopeia Card
        }
        ---------------------
        -- Fireworks Table --
        ---------------------
        fireworks_table = {
            4215, -- Popstar
            4216, -- Brilliant Snow
            4217, -- Sparkling Hand
            4218, -- Air Rider
            4167, -- Cracker
            4168, -- Twinkle Shower
            4169, -- Little Comet
        }
        -- NQ Card Trade-in --
        if trade:hasItemQty(2119, 1) then
            if player:getRace() == tpz.race.HUME_M then -- Hume Male
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        elseif trade:hasItemQty(2120, 1) then
            if player:getRace() == tpz.race.HUME_F then -- Hume Female
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        elseif trade:hasItemQty(2117, 1) then
            if player:getRace() == tpz.race.ELVAAN_M then -- Elvaan Male
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        elseif trade:hasItemQty(2118, 1) then
            if player:getRace() == tpz.race.ELVAAN_F then -- Elvaan Female
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        elseif trade:hasItemQty(2114, 1) then
            if player:getRace() == tpz.race.TARU_M then -- Tarutaru Male
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        -- HQ Card Trade-in *Requires Dream Robe or Dream Robe +1 Equipped* --
        elseif trade:hasItemQty(2115, 1) and dreamRobe then
                if player:getRace() == tpz.race.ELVAAN_F then -- Elvaan Female
                    if player:getFreeSlotsCount() >= 2 then
                        local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                        player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                        player:addItem(2738) -- Cassiopeia Card
                        player:addItem(fireworkselection)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                        player:tradeComplete()
                    else
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                    end
                else
                    player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
                end
        elseif trade:hasItemQty(2116, 1) and dreamRobe then
            if player:getRace() == tpz.race.TARU_M then -- Tarutaru Male
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        elseif trade:hasItemQty(2540, 1) and dreamRobe then
            if player:getRace() == tpz.race.TARU_F then -- Tarutaru Female
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        elseif trade:hasItemQty(2541, 1) and dreamRobe then
            if player:getRace() == tpz.race.MITHRA then -- Mithra
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        elseif trade:hasItemQty(2739, 1) and dreamRobe then
            if player:getRace() == tpz.race.GALKA then -- Galka
                if player:getFreeSlotsCount() >= 2 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(2738) -- Cassiopeia Card
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, 2738)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            else
                player:showText(npc, ID.text.STARLIGHT_CARD_WRONG)
            end
        -- NQ Pathway --
        elseif trade:hasItemQty(2738, 1) and player:getCharVar("HQCard") ~= 1 then
            if player:getCharVar("CardSecondTrade") ~= 1 then
                if player:getFreeSlotsCount() >= 1 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:setCharVar("CardGiven", 0)
                    player:setCharVar("DialogChosen", 0)
                    player:setCharVar("CardChosen", 0)
                    player:setCharVar("CardSecondTrade", 1)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            elseif player:getCharVar("CardSecondTrade") == 1 then
                if player:getFreeSlotsCount() >= 1 then
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:setCharVar("CardSecondTrade", 0)
                    -- NQ Rewards --
                    if player:hasItem(14519) == false then
                        local reward = 14519 -- Dream Robe
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:hasItem(15752) == false then
                        local reward = 15752 -- Dream Boots
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:getGender() ~= 1 and player:hasItem(11967) == false then
                        local reward = 11967 -- Dream Pants (F)
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:getGender() == 1 and player:hasItem(11965) == false then
                        local reward = 11965 -- Dream Trousers (M)
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:hasItem(10382) == false then
                        local reward = 10382 -- Dream Mittens
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    end
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            end
        elseif trade:hasItemQty(2738, 1) and player:getCharVar("HQCard") == 1 then
            if player:getCharVar("CardSecondTrade") ~= 1 then
                if player:getFreeSlotsCount() >= 1 then
                    local fireworkselection =  fireworks_table[math.random(1, #fireworks_table)]
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:addItem(fireworkselection, 10)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, fireworkselection)
                    player:setCharVar("CardGiven", 0)
                    player:setCharVar("DialogChosen", 0)
                    player:setCharVar("CardChosen", 0)
                    player:setCharVar("CardSecondTrade", 1)
                    player:tradeComplete()
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            elseif player:getCharVar("CardSecondTrade") == 1 then
                if player:getFreeSlotsCount() >= 1 then
                    player:showText(npc, ID.text.STARLIGHT_CARD_CONFIRM)
                    player:setCharVar("CardSecondTrade", 0)
                    player:setCharVar("HQCard", 0)
                    -- HQ Rewards --
                    if player:hasItem(14520) == false then
                        local reward = 14520 -- Dream Robe +1
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:hasItem(15753) == false then
                        local reward = 15753 -- Dream Boots +1
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:getGender() ~= 1 and player:hasItem(11968) == false then
                        local reward = 11968 -- Dream Pants +1 (F)
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:hasItem(11966) == false then
                        local reward = 11966 -- Dream Trousers +1 (M)
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    elseif player:hasItem(10383) == false then
                        local reward = 10383 -- Dream Mittens +1
                        player:addItem(reward)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
                        player:setCharVar("CardGiven", 0)
                        player:setCharVar("DialogChosen", 0)
                        player:setCharVar("CardChosen", 0)
                        player:tradeComplete()
                    end
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                end
            end
        end
    end
end

function onStarlightMoogleTrigger(player, npc)
    if isStarlightEnabled() ~= 0 then
        local zone = player:getZoneName()
        local ID = zones[player:getZoneID()]
        local contentEnabled = isStarlightEnabled()
        local CurrentCardDay = VanadielDayOfTheWeek()
        local bodySlot = player:getEquipID(tpz.slot.BODY)
        local dreamRobe = (bodySlot == 14519 or bodySlot == 14520) and true or false
        local mainSlot = player:getEquipID(tpz.slot.MAIN)
        local dreamBellPlusOne = (mainSlot == 18864) and true or false

        ------------------
        -- 2007 Edition --
        ------------------
        --------------
        -- NQ Cards --
        --------------
        cardsNQ_table = {
            2119, -- Aldebaran Card
            2120, -- Betelgeuse Card
            2117, -- Canopus Card
            2118, -- Capella Card
            2114, -- Pleiades Card
        }
        --------------
        -- HQ Cards --
        --------------
        cardsHQ_table = {
            2115, -- Rigel Card
            2116, -- Sirius Card
            2540, -- Magellan Card
            2541, -- Andromeda Card
            2739, -- Perseus Card
        }
        ------------------------
        -- Confirmation Cards --
        ------------------------
        confirm_table = {
            2738, -- Cassiopeia Card
        }

        -- Initial Dialog --
        if player:getCharVar("CardConvo") ~= 1 then
            player:showText(npc, ID.text.STARLIGHT_CARD_1)
            player:showText(npc, ID.text.STARLIGHT_CARD_2)
            player:showText(npc, ID.text.STARLIGHT_CARD_3)
            player:setCharVar("CardConvo", 1)
            player:setCharVar("CardGiven", 0)
            player:setCharVar("CardChosen", 0)
            player:setCharVar("DialogChosen", 0)
        -- Remove for Prod, used for testing -- I see no reason to remove this, honestly
        elseif player:getCharVar("CardConvo") == 1 and dreamBellPlusOne then
            player:setCharVar("CardGiven", 0)
            player:setCharVar("CardChosen", 0)
            player:setCharVar("DialogChosen", 0)
            player:setCharVar("HQCard", 0)
            player:setCharVar("CardConvo", 0)
        -- Card Checker --
        elseif player:getCharVar("CardConvo") == 1 and player:getCharVar("DialogChosen") ~= 0 then
            if player:getCharVar("HQCard") ~= 1 then
                if player:hasItem(player:getCharVar("CardGiven")) then
                    player:showText(npc, ID.text.STARLIGHT_CARD_CHECK, player:getCharVar("DialogChosen") - 1)
                    player:showText(npc, ID.text.STARLIGHT_CARD_4)
                else
                    -- Give a new NQ card if no longer has old card
                    player:showText(npc, ID.text.STARLIGHT_CARD_1)
                    player:showText(npc, ID.text.STARLIGHT_CARD_2)
                    player:showText(npc, ID.text.STARLIGHT_CARD_3)
                    player:setCharVar("CardConvo", 1)
                    player:setCharVar("CardGiven", 0)
                    player:setCharVar("CardChosen", 0)
                    player:setCharVar("DialogChosen", 0)
                end
            elseif player:getCharVar("HQCard") == 1 then
                player:showText(npc, ID.text.STARLIGHT_CARD_CHECK, player:getCharVar("DialogChosen") - 1)
                player:showText(npc, ID.text.STARLIGHT_CARD_RED)
                player:showText(npc, ID.text.STARLIGHT_CARD_4)
            end
        -- HQ Upgrade Pathway--
        elseif player:getCharVar("CardConvo") == 1 and dreamRobe then
            -- Job and Level Choice w/ Param Set --
            local mathCardChoice = math.random(#cardsHQ_table)
            local mathChoice = mathCardChoice + 2 -- Selects which prompt to use for race/gender selection.
            player:setCharVar("CardChosen", 1)
            -- -- Dialog Selection --
            if player:getCharVar("CardChosen") ~= 0 then
                player:setCharVar("HQCard", 1)
                player:setCharVar("DialogChosen", mathChoice + 1)
                player:showText(npc, ID.text.STARLIGHT_CARD_5, mathChoice)
                player:showText(npc, ID.text.STARLIGHT_CARD_RED)
                player:showText(npc, ID.text.STARLIGHT_CARD_4)
                player:showText(npc, ID.text.STARLIGHT_CARD_6)
            end
            -- Give Item --
            local cardpicked = cardsHQ_table[mathCardChoice]
            if player:getFreeSlotsCount() >= 1 then
                player:addItem(cardpicked)
                player:messageSpecial(ID.text.ITEM_OBTAINED, cardpicked)
                player:setCharVar("CardGiven", cardpicked)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                player:setCharVar("CardGiven", 0)
                player:setCharVar("CardChosen", 0)
                player:setCharVar("DialogChosen", 0)
                player:setCharVar("HQCard", 0)
            end
        -- NQ Pathway --
        elseif player:getCharVar("CardConvo") == 1 and player:getCharVar("CardGiven") == 0 then
            -- Job and Level Choice w/ Param Set --
            local mathCardChoice = math.random(#cardsNQ_table)
            local mathChoice = mathCardChoice - 1 -- Selects which prompt to use for race/gender selection.

            player:setCharVar("CardChosen", 1)
            -- -- Dialog Selection --
            if player:getCharVar("CardChosen") ~= 0 then
                player:setCharVar("HQCard", 0)
                player:setCharVar("DialogChosen", mathChoice + 1)
                player:showText(npc, ID.text.STARLIGHT_CARD_5, mathChoice)
                player:showText(npc, ID.text.STARLIGHT_CARD_4)
                player:showText(npc, ID.text.STARLIGHT_CARD_6)
            end
            -- Give Item --
            local cardpicked = cardsNQ_table[mathCardChoice]
            if player:getFreeSlotsCount() >= 1 then
                player:addItem(cardpicked)
                player:messageSpecial(ID.text.ITEM_OBTAINED, cardpicked)
                player:setCharVar("CardGiven", cardpicked)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                player:setCharVar("CardGiven", 0)
                player:setCharVar("DialogChosen", 0)
                player:setCharVar("CardChosen", 0)
            end
        else
            -- nothing matched, reset card convo. Should be impossible.
            player:PrintToPlayer("Moogle: You appear to have found a bug, Kupo! Talk to me again for a new card!", 0xD)
            player:setCharVar("CardConvo", 0)
        end
    end
end