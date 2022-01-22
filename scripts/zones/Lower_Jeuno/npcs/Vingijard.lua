-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vingijard
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local gil = player:getGil()
    player:startEvent(10034, 0, gil)
end

function onEventUpdate(player, csid, option)
    if option == 0 then
        player:setLocalVar("SelectedConfirmed", 1)
    else
        player:setLocalVar("SelectedConfirmed", 0)
    end
end

function onEventFinish(player, csid, option)
    if option == 1073741824 then -- Changed Mind
        return
    elseif option == 1 then -- Warrior
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.THE_DOORMAN
        local reward0 = 16678 -- Razor Axe
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH
        local reward1 = 14089 -- Fighter's Calligae
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT
        local reward2 = 12638 -- Fighter's Lorica
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS
        local reward3 = 13961 -- Fighter's Mufflers
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 2 then -- Monk
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.GHOSTS_OF_THE_PAST
        local reward0 = 17478 -- Beat Cesti
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.THE_FIRST_MEETING
        local reward1 = 14090 -- Temple Gaiters
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.TRUE_STRENGTH
        local reward2 = 14215 -- Temple Hose
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_STRIKING_HANDS
        local reward3 = 13962 -- Temple Gloves
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 3 then -- White Mage
        local questcity0 = SANDORIA
        local quest0 = tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND
        local reward0 = 17422 -- Blessed Hammer
        local questcity1 = SANDORIA
        local quest1 = tpz.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE
        local reward1 = 14091 -- Healer's Duckbills
        local questcity2 = SANDORIA
        local quest2 = tpz.quest.id.sandoria.PIEUJE_S_DECISION
        local reward2 = 12640 -- Healer's Briault
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_HEALING_HANDS
        local reward3 = 13963 -- Healer's Mitts
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 4 then -- Black Mage
        local questcity0 = WINDURST
        local quest0 = tpz.quest.id.windurst.THE_THREE_MAGI
        local reward0 = 17423 -- Casting Wand
        local questcity1 = WINDURST
        local quest1 = tpz.quest.id.windurst.RECOLLECTIONS
        local reward1 = 14092 -- Wizard's Sabots
        local questcity2 = WINDURST
        local quest2 = tpz.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM
        local reward2 = 13856 -- Wizard's Petasos
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_SORCEROUS_HANDS
        local reward3 = 13964 -- Wizard's Gloves
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 5 then -- Red Mage
        local questcity0 = SANDORIA
        local quest0 = tpz.quest.id.sandoria.THE_CRIMSON_TRIAL
        local reward0 = 16829 -- Fencing Degen
        local questcity1 = SANDORIA
        local quest1 = tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS
        local reward1 = 14093 -- Warlock's Boots
        local questcity2 = SANDORIA
        local quest2 = tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT
        local reward2 = 12513 -- Warlock's Chapeau
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_VERMILLION_HANDS
        local reward3 = 13965 -- Warlock's Gloves
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 6 then -- Thief
        local questcity0 = WINDURST
        local quest0 = tpz.quest.id.windurst.THE_TENSHODO_SHOWDOWN
        local reward0 = 16764 -- Marauder's Knife
        local questcity1 = WINDURST
        local quest1 = tpz.quest.id.windurst.AS_THICK_AS_THIEVES
        local reward1 = 12514 -- Rogue's Bonnet
        local questcity2 = WINDURST
        local quest2 = tpz.quest.id.windurst.HITTING_THE_MARQUISATE
        local reward2 = 14094 -- Rogue's Poulaines
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_SNEAKY_HANDS
        local reward3 = 13966 -- Rogue's Armlets
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 7 then -- Paladin
        local questcity0 = SANDORIA
        local quest0 = tpz.quest.id.sandoria.SHARPENING_THE_SWORD
        local reward0 = 17643 -- Honor Sword
        local questcity1 = SANDORIA
        local quest1 = tpz.quest.id.sandoria.A_BOY_S_DREAM
        local reward1 = 14095 -- Gallant Leggings
        local questcity2 = SANDORIA
        local quest2 = tpz.quest.id.sandoria.UNDER_OATH
        local reward2 = 12644 -- Gallant Surcoat
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_STALWART_HANDS
        local reward3 = 13967 -- Gallant Gauntlets
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 8 then -- Dark Knight
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.DARK_LEGACY
        local reward0 = 16798 -- Raven Scythe
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.DARK_PUPPET
        local reward1 = 14096 -- Chaos Sollerets
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.BLADE_OF_EVIL
        local reward2 = 12516 -- Chaos Burgeonet
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_SHADOWY_HANDS
        local reward3 = 13968 -- Chaos Gauntlets
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 9 then -- Beastmaster
        local questcity0 = JEUNO
        local quest0 = tpz.quest.id.jeuno.WINGS_OF_GOLD
        local reward0 = 16680 -- Barbaroi Axe
        local questcity1 = JEUNO
        local quest1 = tpz.quest.id.jeuno.SCATTERED_INTO_SHADOW
        local reward1 = 14097 -- Beast Gaiters
        local questcity2 = JEUNO
        local quest2 = tpz.quest.id.jeuno.A_NEW_DAWN
        local reward2 = 14222 -- Beast Trousers
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WILD_HANDS
        local reward3 = 13969 -- Beast Gloves
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 10 then -- Bard
        local questcity0 = JEUNO
        local quest0 = tpz.quest.id.jeuno.PAINFUL_MEMORY
        local reward0 = 16766 -- Paper Knife
        local questcity1 = JEUNO
        local quest1 = tpz.quest.id.jeuno.THE_REQUIEM
        local reward1 = 14098 -- Choral Slippers
        local questcity2 = JEUNO
        local quest2 = tpz.quest.id.jeuno.THE_CIRCLE_OF_TIME
        local reward2 = 12647 -- Choral Justaucorps
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_HARMONIOUS_HANDS
        local reward3 = 13970 -- Choral Cuffs
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 11 then -- Ranger
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.THE_DOORMAN
        local reward0 = 16678 -- Razor Axe
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH
        local reward1 = 14089 -- Fighter's Calligae
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT
        local reward2 = 12638 -- Fighter's Lorica
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS
        local reward3 = 13961 -- Fighter's Mufflers
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 12 then -- Samurai
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.THE_DOORMAN
        local reward0 = 16678 -- Razor Axe
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH
        local reward1 = 14089 -- Fighter's Calligae
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT
        local reward2 = 12638 -- Fighter's Lorica
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS
        local reward3 = 13961 -- Fighter's Mufflers
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 13 then -- Ninja
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.THE_DOORMAN
        local reward0 = 16678 -- Razor Axe
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH
        local reward1 = 14089 -- Fighter's Calligae
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT
        local reward2 = 12638 -- Fighter's Lorica
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS
        local reward3 = 13961 -- Fighter's Mufflers
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 14 then -- Dragoon
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.THE_DOORMAN
        local reward0 = 16678 -- Razor Axe
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH
        local reward1 = 14089 -- Fighter's Calligae
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT
        local reward2 = 12638 -- Fighter's Lorica
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS
        local reward3 = 13961 -- Fighter's Mufflers
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 15 then -- Summoner
        local questcity0 = BASTOK
        local quest0 = tpz.quest.id.bastok.THE_DOORMAN
        local reward0 = 16678 -- Razor Axe
        local questcity1 = BASTOK
        local quest1 = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH
        local reward1 = 14089 -- Fighter's Calligae
        local questcity2 = BASTOK
        local quest2 = tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT
        local reward2 = 12638 -- Fighter's Lorica
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS
        local reward3 = 13961 -- Fighter's Mufflers
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            if not (player:hasItem(reward0) and player:hasItem(reward1) and player:hasItem(reward2) and player:hasItem(reward3)) then
                player:delGil(10000)
                player:delQuest(questcity0, quest0)
                player:delQuest(questcity1, quest1)
                player:delQuest(questcity2, quest2)
                player:delQuest(questcity3, quest3)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 16 then -- Blue Mage
    elseif option == 17 then -- Corsair
    elseif option == 18 then -- Puppetmaster
    elseif option == 19 then -- Dancer
    elseif option == 20 then -- Scholar
    elseif option == 21 then -- Geomancer
        player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Job not available.
    elseif option == 22 then -- Runefencer
        player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Job not available.
    end
end
