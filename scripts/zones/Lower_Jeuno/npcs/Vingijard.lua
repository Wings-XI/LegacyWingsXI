-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vingijard
-- Standard Info NPC
-----------------------------------

afQuestInfo = { -- keyed on tpz.job
    [1] = { -- Warrior
        questcity0 = BASTOK,
        quest0 = tpz.quest.id.bastok.THE_DOORMAN,
        reward0 = 16678, -- Razor Axe
        questcity1 = BASTOK,
        quest1 = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH,
        reward1 = 14089, -- Fighter's Calligae
        questcity2 = BASTOK,
        quest2 = tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT,
        reward2 = 12638, -- Fighter's Lorica
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS,
        reward3 = 13961, -- Fighter's Mufflers
        reward4 = 14214, -- Fighter's Cuisses
        reward5 = 12511, -- Fighter's Mask
    },
    [2] = { -- Monk
        questcity0 = BASTOK,
        quest0 = tpz.quest.id.bastok.GHOSTS_OF_THE_PAST,
        reward0 = 17478, -- Beat Cesti
        questcity1 = BASTOK,
        quest1 = tpz.quest.id.bastok.THE_FIRST_MEETING,
        reward1 = 14090, -- Temple Gaiters
        questcity2 = BASTOK,
        quest2 = tpz.quest.id.bastok.TRUE_STRENGTH,
        reward2 = 14215, -- Temple Hose
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_STRIKING_HANDS,
        reward3 = 13962, -- Temple Gloves
        reward4 = 12639, -- Temple Cyclas
        reward5 = 12512, -- Temple Crown
    },
    [3] = { -- White mage
        questcity0 = SANDORIA,
        quest0 = tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND,
        reward0 = 17422, -- Blessed Hammer
        questcity1 = SANDORIA,
        quest1 = tpz.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE,
        reward1 = 14091, -- Healer's Duckbills
        questcity2 = SANDORIA,
        quest2 = tpz.quest.id.sandoria.PIEUJE_S_DECISION,
        reward2 = 12640, -- Healer's Briault
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_HEALING_HANDS,
        reward3 = 13963, -- Healer's Mitts
        reward4 = 14216, -- Healer's Pantalones
        reward5 = 13855, -- Healer's Cap
    },
    [4] = { -- Black Mage
        questcity0 = WINDURST,
        quest0 = tpz.quest.id.windurst.THE_THREE_MAGI,
        reward0 = 17423, -- Casting Wand
        questcity1 = WINDURST,
        quest1 = tpz.quest.id.windurst.RECOLLECTIONS,
        reward1 = 14092, -- Wizard's Sabots
        questcity2 = WINDURST,
        quest2 = tpz.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM,
        reward2 = 13856, -- Wizard's Petasos
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_SORCEROUS_HANDS,
        reward3 = 13964, -- Wizard's Gloves
        reward4 = 14217, -- Wizard's Tonban
        reward5 = 12641, -- Wizard's Coat
    },
    [5] = { -- Red Mage
        questcity0 = SANDORIA,
        quest0 = tpz.quest.id.sandoria.THE_CRIMSON_TRIAL,
        reward0 = 16829, -- Fencing Degen
        questcity1 = SANDORIA,
        quest1 = tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS,
        reward1 = 14093, -- Warlock's Boots
        questcity2 = SANDORIA,
        quest2 = tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT,
        reward2 = 12513, -- Warlock's Chapeau
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_VERMILLION_HANDS,
        reward3 = 13965, -- Warlock's Gloves
        reward4 = 14218, -- Warlock's Tights
        reward5 = 12642, -- Warlock's Tabard
    },
    [6] = { -- Thief
        questcity0 = WINDURST,
        quest0 = tpz.quest.id.windurst.THE_TENSHODO_SHOWDOWN,
        reward0 = 16764, -- Marauder's Knife
        questcity1 = WINDURST,
        quest1 = tpz.quest.id.windurst.AS_THICK_AS_THIEVES,
        reward1 = 12514, -- Rogue's Bonnet
        questcity2 = WINDURST,
        quest2 = tpz.quest.id.windurst.HITTING_THE_MARQUISATE,
        reward2 = 14094, -- Rogue's Poulaines
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_SNEAKY_HANDS,
        reward3 = 13966, -- Rogue's Armlets
        reward4 = 14219, -- Rogue's Culottes
        reward5 = 12643, -- Rogue's Vest
    },
    [7] = { -- Paladin
        questcity0 = SANDORIA,
        quest0 = tpz.quest.id.sandoria.SHARPENING_THE_SWORD,
        reward0 = 17643, -- Honor Sword
        questcity1 = SANDORIA,
        quest1 = tpz.quest.id.sandoria.A_BOY_S_DREAM,
        reward1 = 14095, -- Gallant Leggings
        questcity2 = SANDORIA,
        quest2 = tpz.quest.id.sandoria.UNDER_OATH,
        reward2 = 12644, -- Gallant Surcoat
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_STALWART_HANDS,
        reward3 = 13967, -- Gallant Gauntlets
        reward4 = 14220, -- Gallant Breeches
        reward5 = 12515, -- Gallant Coronet
    },
    [8] = { -- Dark Knight
        questcity0 = BASTOK,
        quest0 = tpz.quest.id.bastok.DARK_LEGACY,
        reward0 = 16798, -- Raven Scythe
        questcity1 = BASTOK,
        quest1 = tpz.quest.id.bastok.DARK_PUPPET,
        reward1 = 14096, -- Chaos Sollerets
        questcity2 = BASTOK,
        quest2 = tpz.quest.id.bastok.BLADE_OF_EVIL,
        reward2 = 12516, -- Chaos Burgeonet
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_SHADOWY_HANDS,
        reward3 = 13968, -- Chaos Gauntlets
        reward4 = 14221, -- Chaos Flanchard
        reward5 = 12645, -- Chaos Cuirass
    },
    [9] = { -- Beastmaster
        questcity0 = JEUNO,
        quest0 = tpz.quest.id.jeuno.WINGS_OF_GOLD,
        reward0 = 16680, -- Barbaroi Axe
        questcity1 = JEUNO,
        quest1 = tpz.quest.id.jeuno.SCATTERED_INTO_SHADOW,
        reward1 = 14097, -- Beast Gaiters
        questcity2 = JEUNO,
        quest2 = tpz.quest.id.jeuno.A_NEW_DAWN,
        reward2 = 14222, -- Beast Trousers
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_WILD_HANDS,
        reward3 = 13969, -- Beast Gloves
        reward4 = 12517, -- Beast Helm
        reward5 = 12646, -- Beast Jackcoat
    },
    [10] = { -- Bard
        questcity0 = JEUNO,
        quest0 = tpz.quest.id.jeuno.PAINFUL_MEMORY,
        reward0 = 16766, -- Paper Knife
        questcity1 = JEUNO,
        quest1 = tpz.quest.id.jeuno.THE_REQUIEM,
        reward1 = 14098, -- Choral Slippers
        questcity2 = JEUNO,
        quest2 = tpz.quest.id.jeuno.THE_CIRCLE_OF_TIME,
        reward2 = 12647, -- Choral Justaucorps
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_HARMONIOUS_HANDS,
        reward3 = 13970, -- Choral Cuffs
        reward4 = 13857, -- Choral Roundlet
        reward5 = 14223, -- Choral Cannions
    },
    [11] = { -- Ranger
        questcity0 = WINDURST,
        quest0 = tpz.quest.id.windurst.SIN_HUNTING,
        reward0 = 17188, -- Sniping Bow
        questcity1 = WINDURST,
        quest1 = tpz.quest.id.windurst.FIRE_AND_BRIMSTONE,
        reward1 = 12518, -- Hunter's Beret
        questcity2 = WINDURST,
        quest2 = tpz.quest.id.windurst.UNBRIDLED_PASSION,
        reward2 = 14099, -- Hunter's Socks
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_CHASING_HANDS,
        reward3 = 13971, -- Hunter's Bracers
        reward4 = 12648, -- Hunter's Jerkin
        reward5 = 14224, -- Hunter's Braccae
    },
    [12] = { -- Samurai
        questcity0 = OUTLANDS,
        quest0 = tpz.quest.id.outlands.THE_SACRED_KATANA,
        reward0 = 17812, -- Magoroku
        questcity1 = OUTLANDS,
        quest1 = tpz.quest.id.outlands.YOMI_OKURI,
        reward1 = 14100, -- Myochin Sune-Ate
        questcity2 = OUTLANDS,
        quest2 = tpz.quest.id.outlands.A_THIEF_IN_NORG,
        reward2 = 13868, -- Myochin Kabuto
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_LOYAL_HANDS,
        reward3 = 13972, -- Myochin Kote
        reward4 = 14225, -- Myochin Haidate
        reward5 = 13781, -- Myochin Domaru
    },
    [13] = { -- Ninja
        questcity0 = OUTLANDS,
        quest0 = tpz.quest.id.outlands.TWENTY_IN_PIRATE_YEARS,
        reward0 = 17771, -- Anju
        reward0b = 17772, -- Zushio
        questcity1 = OUTLANDS,
        quest1 = tpz.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX,
        reward1 = 14226, -- Ninja Hakama
        questcity2 = OUTLANDS,
        quest2 = tpz.quest.id.outlands.TRUE_WILL,
        reward2 = 13782, -- Ninja Chainmail
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_LURKING_HANDS,
        reward3 = 13973, -- Ninja Tekko
        reward4 = 14101, -- Ninja Kyahan
        reward5 = 13869, -- Ninja Hatsuburi
    },
    [14] = { -- Dragoon
        questcity0 = SANDORIA,
        quest0 = tpz.quest.id.sandoria.A_CRAFTSMAN_S_WORK,
        reward0 = 16887, -- Peregrine
        questcity1 = SANDORIA,
        quest1 = tpz.quest.id.sandoria.CHASING_QUOTAS,
        reward1 = 14227, -- Drachen Brais
        questcity2 = SANDORIA,
        quest2 = tpz.quest.id.sandoria.KNIGHT_STALKER,
        reward2 = 12519, -- Drachen Armet
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_DRAGON_HANDS,
        reward3 = 13974, -- Drachen Finger Gauntlets
        reward4 = 14102, -- Drachen Greaves
        reward5 = 12649, -- Drachen Mail
    },
    [15] = { -- Summoner
        questcity0 = WINDURST,
        quest0 = tpz.quest.id.windurst.THE_PUPPET_MASTER,
        reward0 = 17532, -- Kukulcan's Staff
        questcity1 = WINDURST,
        quest1 = tpz.quest.id.windurst.CLASS_REUNION,
        reward1 = 14228, -- Evoker's Spats
        questcity2 = WINDURST,
        quest2 = tpz.quest.id.windurst.CARBUNCLE_DEBACLE,
        reward2 = 112520, -- Evoker's Horn
        questcity3 = JEUNO,
        quest3 = tpz.quest.id.jeuno.BORGHERTZ_S_CALLING_HANDS,
        reward3 = 13975, -- Evoker's Bracers
        reward4 = 14103, -- Evoker's Pigaches
        reward5 = 12650, -- Evoker's Doublet
    },
    [16] = { -- Blue Mage
        questcity0 = AHT_URHGAN,
        quest0 = tpz.quest.id.ahtUrhgan.BEGINNINGS,
        reward0 = 17717, -- Immortal's Scimitar
        questcity1 = AHT_URHGAN,
        quest1 = tpz.quest.id.ahtUrhgan.OMENS,
        reward1 = 11381, -- Magus Charuqs
        questcity2 = AHT_URHGAN,
        quest2 = tpz.quest.id.ahtUrhgan.TRANSFORMATIONS,
        reward2 = 11464, -- Magus Keffiyeh
        reward3 = 14521, -- Magus Jubbah
        reward4 = 14928, -- Magus Bazubands
        reward5 = 15600, -- Magus Shalwar
    },
    [17] = { -- Corsair
        questcity0 = AHT_URHGAN,
        quest0 = tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS,
        reward0 = 18702, -- Trump Gun
        questcity1 = AHT_URHGAN,
        quest1 = tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS,
        reward1 = 15601, -- Corsair's Culottes
        questcity2 = AHT_URHGAN,
        quest2 = tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS,
        reward2 = 11467, -- Corsair's Tricorne
        reward3 = 15685, -- Corsair's Bottes
        reward4 = 14522, -- Corsair's Frac
        reward5 = 14929, -- Corsair's Gants
    },
    [18] = { -- Puppetmaster
        questcity0 = AHT_URHGAN,
        quest0 = tpz.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATION,
        reward0 = 17858, -- Turbo Animator
        questcity1 = AHT_URHGAN,
        quest1 = tpz.quest.id.ahtUrhgan.OPERATION_TEATIME,
        reward1 = 15602, -- Puppetry Churidars
        questcity2 = AHT_URHGAN,
        quest2 = tpz.quest.id.ahtUrhgan.PUPPETMASTER_BLUES,
        reward2 = 11470, -- Puppetry Taj
        reward3 = 14523, -- Puppetry Tobe
        reward4 = 14930, -- Puppetry Dastanas
        reward5 = 15686, -- Puppetry Babouches
    },
    [19] = { -- Dancer
        questcity0 = JEUNO,
        quest0 = tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ,
        reward0 = 19203, -- War Hoop
        questcity1 = JEUNO,
        quest1 = tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM,
        reward1 = 15659, -- Dancer's Tights -- 15660
        questcity2 = JEUNO,
        quest2 = tpz.quest.id.jeuno.COMEBACK_QUEEN,
        reward2 = 14578, -- Dancer's Casaque  -- 14579
        reward3 = 15002, -- Dancer's Bangles -- 15003
        reward4 = 15746, -- Dancer's Shoes -- 15747
        reward5 = 16138, -- Dancer's Tiara -- 16139
    },
    [20] = { -- Scholar
        questcity0 = CRYSTAL_WAR,
        quest0 = tpz.quest.id.crystalWar.ON_SABBATICAL,
        reward0 = 6058, -- Klimaform Schema
        questcity1 = CRYSTAL_WAR,
        quest1 = tpz.quest.id.crystalWar.DOWNWARD_HELIX,
        reward1 = 15004, -- Scholar's Bracers
        questcity2 = CRYSTAL_WAR,
        quest2 = tpz.quest.id.crystalWar.SEEING_BLOOD_RED,
        reward2 = 16140, -- Scholar's Motarboard
        reward3 = 14580, -- Scholar's Gown
        reward4 = 15748, -- Scholar's Loafer
        reward5 = 16311, -- Scholar's Pants
    },
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local gil = player:getGil()
    -- Filter/Param0 - bitmask that hides what is matched
    --   1 hides "I have changed my mind".  2 hides War.  4 hides Mnk.  6 hides Mnk and War.
    --   1 << tpz.job = mask for the job
    

    local filter = 8388606 -- this hides everything but "I have changed my mind".  Noteably - this also hides GEO and RUN.

    for i=tpz.job.WAR, tpz.job.SCH do
        if checkArtifactProgress(player, i) then
            filter = filter - (bit.lshift(1, i))
        end
    end

    player:startEvent(10034, filter, gil)
end

function onEventUpdate(player, csid, option)
end

function checkArtifactProgress(player, job)
    if job < tpz.job.BLU then -- Boring jobs
        if player:hasCompletedQuest(afQuestInfo[job].questcity2, afQuestInfo[job].quest2) and player:hasCompletedQuest(afQuestInfo[job].questcity3, afQuestInfo[job].quest3) then
            -- Note - we do not currently have a way to tell if the player has gotten all of their coffer AF
            -- In fact - Players can continuously get coffer AF if they toss it and get another coffer key
            return true
        end
    elseif job <= tpz.job.SCH then -- Cool jobs
        if not (player:hasCompletedQuest(afQuestInfo[job].questcity2, afQuestInfo[job].quest2)) then
            return false
        end

        -- Blue Mage counts down the pieces completed in a bitmask
        if (job == tpz.job.BLU) and (player:getCharVar("[BLUAF]Remaining") == 0) then
            return true
        end

        -- Corsair uses 3 different vars
        if (job == tpz.job.COR) and (player:getCharVar("LeleroonsLetterGreen") == 5) and (player:getCharVar("LeleroonsLetterBlue") == 5) and (player:getCharVar("LeleroonsLetterRed") == 5) then
            return true
        end

        -- Puppetmaster counts down the pieces completed in a bitmask
        if (job == tpz.job.PUP) and (player:getCharVar("[PUPAF]Remaining") == 0) then
            return true
        end

        -- Dancer counts up the pieces completed in a bitmask
        if (job == tpz.job.DNC) and (player:getCharVar("dancerCompletedAF") == 7) then
            return true
        end

        -- Scholar has a var for AF complete
        if (job == tpz.job.SCH) and (player:getCharVar("AF_SCH_COMPLETE") == 1) then
            return true
        end
        
    end

    return false
end

function checkArtifactGear(player, job)
    if job == tpz.job.NIN then -- Ninja has an additional AF reward
        if not (player:hasItem(afQuestInfo[job].reward0) or player:hasItem(afQuestInfo[job].reward0b) or
                player:hasItem(afQuestInfo[job].reward1) or player:hasItem(afQuestInfo[job].reward2) or
                player:hasItem(afQuestInfo[job].reward3) or player:hasItem(afQuestInfo[job].reward4) or
                player:hasItem(afQuestInfo[job].reward5)) then
            return true
        else
            return false
        end
    elseif job == tpz.job.DNC then -- Dancer has 2 AF sets, check for both
        if not (player:hasItem(afQuestInfo[job].reward0) or player:hasItem(afQuestInfo[job].reward1) or
                player:hasItem(afQuestInfo[job].reward2) or player:hasItem(afQuestInfo[job].reward3) or
                player:hasItem(afQuestInfo[job].reward4) or player:hasItem(afQuestInfo[job].reward5) or
                player:hasItem(afQuestInfo[job].reward1 + 1) or
                player:hasItem(afQuestInfo[job].reward2 + 1) or player:hasItem(afQuestInfo[job].reward3 + 1) or
                player:hasItem(afQuestInfo[job].reward4 + 1) or player:hasItem(afQuestInfo[job].reward5 + 1)) then
            return true
        else
            return false
        end
    elseif job <= tpz.job.SCH then
        if not (player:hasItem(afQuestInfo[job].reward0) or player:hasItem(afQuestInfo[job].reward1) or
                player:hasItem(afQuestInfo[job].reward2) or player:hasItem(afQuestInfo[job].reward3) or
                player:hasItem(afQuestInfo[job].reward4) or player:hasItem(afQuestInfo[job].reward5)) then
            return true
        else
            return false
        end
    end
end

function onArtifactQuesetReset(player, job)
    -- onEventFinish is sanity checking params - so we dont have to here
    player:delGil(10000)
    player:delQuest(afQuestInfo[job].questcity0, afQuestInfo[job].quest0)
    player:delQuest(afQuestInfo[job].questcity1, afQuestInfo[job].quest1)
    player:delQuest(afQuestInfo[job].questcity2, afQuestInfo[job].quest2)

    if job == tpz.job.BLU then
        player:setCharVar("[BLUAF]Current", 0)
        player:setCharVar("[BLUAF]CraftingStage", 0)
        player:setCharVar("[BLUAF]Remaining", 7)
        player:setCharVar("[BLUAF]PaymentDay", 0)
        player:setCharVar("[BLUAF]RestingDay", 0)
    elseif job == tpz.job.COR then
        player:setCharVar("LeleroonsLetterGreen", 0)
        player:setCharVar("LeleroonsLetterBlue", 0)
        player:setCharVar("LeleroonsLetterRed", 0)
    elseif job == tpz.job.PUP then
        player:setCharVar("[PUPAF]Current", 0)
        player:setCharVar("[PUPAF]Remaining", 7)
        player:setCharVar("[PUPAF]TradeDone", 0)
        player:setCharVar("[PUPAF]TradeDay", 0)
    elseif job == tpz.job.DNC then
        player:setCharVar("dancerCompletedAF", 0)
        player:setCharVar("dancerTailorCS", 0)
        player:setCharVar("dancerAFChoice", 0)
    elseif job == tpz.job.SCH then
        player:setCharVar("AF_SCH_COMPLETE", 0)
        player:setCharVar("AF_Loussaire", 0)
        player:setCharVar("AF_SCH_BOOTS", 0)
        player:setCharVar("AF_SCH_PANTS", 0)
        player:setCharVar("AF_SCH_BODY", 0)
    elseif job < tpz.job.BLU then -- All Dark Spark AF jobs
        player:delQuest(afQuestInfo[job].questcity3, afQuestInfo[job].quest3)
    end
end

function onEventFinish(player, csid, option)
    if (option >= 1 and option <= 20) then
        onArtifactQuesetReset(player, option)
    end
end
