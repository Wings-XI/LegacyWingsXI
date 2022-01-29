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
end

function checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option)
    if option >= 16 then -- Cool jobs
        if player:hasCompletedQuest(questcity2, quest2) then
            return 1
        else
            return 0
        end
    elseif option < 16 then -- Boring jobs
        if player:hasCompletedQuest(questcity2, quest2) and player:hasCompletedQuest(questcity3, quest3) then
            return 1
        else
            return 0
        end
    end
end

function checkArtifactGear(player, reward0, reward0b, reward1, reward2, reward3, option)
    if option >= 16 then -- Cool jobs
        if not (player:hasItem(reward0) or player:hasItem(reward1) or player:hasItem(reward2)) then
            return 1
        else
            return 0
        end
    elseif option == 13 then -- Ninja
        if not (player:hasItem(reward0) or player:hasItem(reward0b) or player:hasItem(reward1) or player:hasItem(reward2) or player:hasItem(reward3)) then
            return 1
        else
            return 0
        end
    elseif option < 16 then -- Boring jobs
        if not (player:hasItem(reward0) or player:hasItem(reward1) or player:hasItem(reward2) or player:hasItem(reward3)) then
            return 1
        else
            return 0
        end
    end
end

function onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
    if option == 16 then -- Blue Mage
        player:delGil(10000)
        player:delQuest(questcity0, quest0)
        player:delQuest(questcity1, quest1)
        player:delQuest(questcity2, quest2)
        player:setCharVar("[BLUAF]Current", 0)
        player:setCharVar("[BLUAF]CraftingStage", 0)
        player:setCharVar("[BLUAF]Remaining", 5)
        player:setCharVar("[BLUAF]PaymentDay", 0)
        player:setCharVar("[BLUAF]RestingDay", 0)
    elseif option == 17 then -- Corsair
        player:delGil(10000)
        player:delQuest(questcity0, quest0)
        player:delQuest(questcity1, quest1)
        player:delQuest(questcity2, quest2)
        player:setCharVar("LeleroonsLetterGreen", 0)
        player:setCharVar("LeleroonsLetterBlue", 0)
        player:setCharVar("LeleroonsLetterRed", 0)
    elseif option == 18 then -- Puppetmaster
        player:delGil(10000)
        player:delQuest(questcity0, quest0)
        player:delQuest(questcity1, quest1)
        player:delQuest(questcity2, quest2)
        player:setCharVar("[PUPAF]Current", 0)
        player:setCharVar("[PUPAF]Remaining", 5)
        player:setCharVar("[PUPAF]TradeDone", 0)
        player:setCharVar("[PUPAF]TradeDay", 0)
    elseif option == 19 then -- Dancer
        player:delGil(10000)
        player:delQuest(questcity0, quest0)
        player:delQuest(questcity1, quest1)
        player:delQuest(questcity2, quest2)
        player:setCharVar("dancerCompletedAF", 0)
        player:setCharVar("dancerTailorCS", 0)
        player:setCharVar("dancerAFChoice", 0)
    elseif option == 20 then -- Scholar
        player:delGil(10000)
        player:delQuest(questcity0, quest0)
        player:delQuest(questcity1, quest1)
        player:delQuest(questcity2, quest2)
        player:setCharVar("AF_SCH_COMPLETE", 0)
        player:setCharVar("AF_Loussaire", 0)
        player:setCharVar("AF_SCH_BOOTS", 0)
        player:setCharVar("AF_SCH_PANTS", 0)
        player:setCharVar("AF_SCH_BODY", 0)
    elseif option < 16 then -- All of the boring jobs
        player:delGil(10000)
        player:delQuest(questcity0, quest0)
        player:delQuest(questcity1, quest1)
        player:delQuest(questcity2, quest2)
        player:delQuest(questcity3, quest3)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
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
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 11 then -- Ranger
        local questcity0 = WINDURST
        local quest0 = tpz.quest.id.windurst.SIN_HUNTING
        local reward0 = 17188 -- Sniping Bow
        local questcity1 = WINDURST
        local quest1 = tpz.quest.id.windurst.FIRE_AND_BRIMSTONE
        local reward1 = 12518 -- Hunter's Beret
        local questcity2 = WINDURST
        local quest2 = tpz.quest.id.windurst.UNBRIDLED_PASSION
        local reward2 = 14099 -- Hunter's Socks
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_CHASING_HANDS
        local reward3 = 13971 -- Hunter's Bracers
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 12 then -- Samurai
        local questcity0 = OUTLANDS
        local quest0 = tpz.quest.id.outlands.THE_SACRED_KATANA
        local reward0 = 17812 -- Magoroku
        local questcity1 = OUTLANDS
        local quest1 = tpz.quest.id.outlands.YOMI_OKURI
        local reward1 = 14100 -- Myochin Sune-Ate
        local questcity2 = OUTLANDS
        local quest2 = tpz.quest.id.outlands.A_THIEF_IN_NORG
        local reward2 = 13868 -- Myochin Kabuto
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_LOYAL_HANDS
        local reward3 = 13972 -- Myochin Kote
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 13 then -- Ninja
        local questcity0 = OUTLANDS
        local quest0 = tpz.quest.id.outlands.TWENTY_IN_PIRATE_YEARS
        local reward0 = 17771 -- Anju
        local reward0b = 17772 -- Zushio
        local questcity1 = OUTLANDS
        local quest1 = tpz.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX
        local reward1 = 14226 -- Ninja Hakama
        local questcity2 = OUTLANDS
        local quest2 = tpz.quest.id.outlands.TRUE_WILL
        local reward2 = 13782 -- Ninja Chainmail
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_LURKING_HANDS
        local reward3 = 13973 -- Ninja Tekko
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward0b, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 14 then -- Dragoon
        local questcity0 = SANDORIA
        local quest0 = tpz.quest.id.sandoria.A_CRAFTSMAN_S_WORK
        local reward0 = 16887 -- Peregrine
        local questcity1 = SANDORIA
        local quest1 = tpz.quest.id.sandoria.CHASING_QUOTAS
        local reward1 = 14227 -- Drachen Brais
        local questcity2 = SANDORIA
        local quest2 = tpz.quest.id.sandoria.KNIGHT_STALKER
        local reward2 = 12519 -- Drachen Armet
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_DRAGON_HANDS
        local reward3 = 13974 -- Drachen Finger Gauntlets
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 15 then -- Summoner
        local questcity0 = WINDURST
        local quest0 = tpz.quest.id.windurst.THE_PUPPET_MASTER
        local reward0 = 17532 -- Kukulcan's Staff
        local questcity1 = WINDURST
        local quest1 = tpz.quest.id.windurst.CLASS_REUNION
        local reward1 = 14228 -- Evoker's Spats
        local questcity2 = WINDURST
        local quest2 = tpz.quest.id.windurst.CARBUNCLE_DEBACLE
        local reward2 = 112520 -- Evoker's Horn
        local questcity3 = JEUNO
        local quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_CALLING_HANDS
        local reward3 = 13975 -- Evoker's Bracers
        if checkArtifactProgress(player, questcity2, quest2, questcity3, quest3, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, reward3, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, questcity3, quest3, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 16 then -- Blue Mage
        local questcity0 = AHT_URHGAN
        local quest0 = tpz.quest.id.ahtUrhgan.BEGINNINGS
        local reward0 = 17717 -- Immortal's Scimitar
        local questcity1 = AHT_URHGAN
        local quest1 = tpz.quest.id.ahtUrhgan.OMENS
        local reward1 = 11381 -- Magus Charuqs
        local questcity2 = AHT_URHGAN
        local quest2 = tpz.quest.id.ahtUrhgan.TRANSFORMATIONS
        local reward2 = 11464 -- Magus Keffiyeh
        if checkArtifactProgress(player, questcity2, quest2, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 17 then -- Corsair
        local questcity0 = AHT_URHGAN
        local quest0 = tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS
        local reward0 = 18702 -- Trump Gun
        local questcity1 = AHT_URHGAN
        local quest1 = tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS
        local reward1 = 15601 -- Corsair's Culottes
        local questcity2 = AHT_URHGAN
        local quest2 = tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS
        local reward2 = 11467 -- Corsair's Tricorne
        if checkArtifactProgress(player, questcity2, quest2, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 18 then -- Puppetmaster
        local questcity0 = AHT_URHGAN
        local quest0 = tpz.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATION
        local reward0 = 17858 -- Turbo Animator
        local questcity1 = AHT_URHGAN
        local quest1 = tpz.quest.id.ahtUrhgan.OPERATION_TEATIME
        local reward1 = 15602 -- Puppetry Churidars
        local questcity2 = AHT_URHGAN
        local quest2 = tpz.quest.id.ahtUrhgan.PUPPETMASTER_BLUES
        local reward2 = 11470 -- Puppetry Taj
        if checkArtifactProgress(player, questcity2, quest2, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 19 then -- Dancer
        local questcity0 = JEUNO
        local quest0 = tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ
        local reward0 = 19203 -- War Hoop
        local questcity1 = JEUNO
        local quest1 = tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM
        local reward1 = 15659 -- Dancer's Tights
        local questcity2 = JEUNO
        local quest2 = tpz.quest.id.jeuno.COMEBACK_QUEEN
        local reward2 = 14578 -- Dancer's Casaque
        if checkArtifactProgress(player, questcity2, quest2, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 20 then -- Scholar
        local questcity0 = CRYSTAL_WAR
        local quest0 = tpz.quest.id.crystalWar.ON_SABBATICAL
        local reward0 = 6058 -- Klimaform Schema
        local questcity1 = CRYSTAL_WAR
        local quest1 = tpz.quest.id.crystalWar.DOWNWARD_HELIX
        local reward1 = 15004 -- Scholar's Bracers
        local questcity2 = CRYSTAL_WAR
        local quest2 = tpz.quest.id.crystalWar.SEEING_BLOOD_RED
        local reward2 = 16140 -- Scholar's Motarboard
        if checkArtifactProgress(player, questcity2, quest2, option) == 1 then
            if checkArtifactGear(player, reward0, reward1, reward2, option) == 1 then
                onArtifactQuesetReset(player, questcity0, quest0, questcity1, quest1, questcity2, quest2, option)
            else
                player:PrintToPlayer("Vingijard: You must forget the items you have gained during your trials.", 13) -- Player still has quested AF gear.
            end
        else
            player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Player has not completed all quests.
        end
    elseif option == 21 then -- Geomancer
        player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Job not available.
    elseif option == 22 then -- Runefencer
        player:PrintToPlayer("Vingijard: You have not endured the trials of which I can erase.", 13) -- Job not available.
    end
end
