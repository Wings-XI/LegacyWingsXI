-----------------------------------
-- Area: Port Jeuno
--   NPC: Squintrox Dryeyes
-- Type: Addon Mission Merchant
-- !pos -100.071 -1 11.869 246
-- wiki has good info on his behavior: https://ffxiclopedia.fandom.com/wiki/Squintrox_Dryeyes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------

function onSpawn(npc)
    if ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA == 0 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
    local now = tonumber(os.date("%j"))
    local count = trade:getItemCount()
    local sLux = trade:hasItemQty(2740, 1)
    local sLuna = trade:hasItemQty(2741, 1)
    local sAstrum = trade:hasItemQty(2742, 1)
    local orcArmor = trade:hasItemQty(2757, 1)
    local quadavBack = trade:hasItemQty(596, 1)
    local yagCaulk = trade:hasItemQty(2759, 1)
    local uggalepihWhistle = trade:hasItemQty(1184, 1)
    local kit = player:getCharVar("ASA_kit")
    local enfeebKit = trade:hasItemQty(kit, 1)
    local whiteCoralKeyItems =  trade:hasItemQty(2757,1) and
                                trade:hasItemQty(2758,1) and
                                trade:hasItemQty(2759,1)

    if ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA == 0 then
        player:showText(npc, ID.text.GET_LOST)
    elseif enfeebKit and player:getCurrentMission(ASA) > tpz.mission.id.asa.PROJECT_SHANTOTTOFICATION then -- Moogle Key
        if not player:hasKeyItem(tpz.ki.MOOGLE_KEY) and now ~= player:getCharVar("LastMoogleKey") then
            player:tradeComplete()
            player:addKeyItem(tpz.ki.MOOGLE_KEY)
            player:setCharVar("LastMoogleKey", os.date("%j"))
            player:setCharVar("ASA_kit", 0)
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MOOGLE_KEY)
        else
            player:messageSpecial(ID.text.DRYEYES_3, tpz.ki.MOOGLE_KEY)
        end
    elseif whiteCoralKeyItems and count == 3 and player:getCurrentMission(AMK) > tpz.mission.id.amk.SMASH_A_MALEVOLENT_MENACE then -- White Coral Key
        if not player:hasKeyItem(tpz.ki.WHITE_CORAL_KEY) and now ~= player:getCharVar("LastWhiteCoralKey") then
            player:tradeComplete()
            player:addKeyItem(tpz.ki.WHITE_CORAL_KEY)
            player:setCharVar("LastWhiteCoralKey", os.date("%j"))
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WHITE_CORAL_KEY)
        else
            player:messageSpecial(ID.text.DRYEYES_3, tpz.ki.WHITE_CORAL_KEY)
        end
    elseif sLux and sLuna and sAstrum and count == 3 and player:getCurrentMission(ACP) >= tpz.mission.id.acp.GATHERER_OF_LIGHT_I then -- Crimson Key
        if not player:hasKeyItem(tpz.ki.CRIMSON_KEY)  and now ~= player:getCharVar("LastCrimsonKey") then
            player:tradeComplete()
            player:addKeyItem(tpz.ki.CRIMSON_KEY)
            player:setCharVar("LastCrimsonKey", os.date("%j"))
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CRIMSON_KEY)
        else
            player:messageSpecial(ID.text.DRYEYES_3, tpz.ki.CRIMSON_KEY)
        end
    end
end

function onTrigger(player, npc)
    local now = tonumber(os.date("%j"))
    if (ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA == 0) then
        player:showText(npc, ID.text.GET_LOST)
    else
        local ACPm = player:getCurrentMission(ACP)
        local AMKm = player:getCurrentMission(AMK)
        local ASAm = player:getCurrentMission(ASA)

        --Update below with missions for future add-ons
        local arg1 =
            ((ACPm < tpz.mission.id.acp.GATHERER_OF_LIGHT_I or player:hasKeyItem(tpz.ki.CRIMSON_KEY))      and   2 or 0) +
            ((ACPm < tpz.mission.id.acp.GATHERER_OF_LIGHT_I or player:hasKeyItem(tpz.ki.VIRIDIAN_KEY))     and   4 or 0) +
            ((AMKm < tpz.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN or player:hasKeyItem(tpz.ki.WHITE_CORAL_KEY))                                and   8 or 0) +
            ((AMKm < tpz.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN or player:hasKeyItem(tpz.ki.BLUE_CORAL_KEY))                                 and  16 or 0) +
            ((AMKm < tpz.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN or player:hasKeyItem(tpz.ki.BLACK_CORAL_KEY))                                and  32 or 0) +
            ((ASAm < tpz.mission.id.asa.PROJECT_SHANTOTTOFICATION or player:hasKeyItem(tpz.ki.MOOGLE_KEY) and now ~= player:getCharVar("LastMoogleKey")) and  64 or 0) +
            ((ASAm < tpz.mission.id.asa.PROJECT_SHANTOTTOFICATION or player:hasKeyItem(tpz.ki.BIRD_KEY) and now ~= player:getCharVar("LastBirdKey") )    and 128 or 0) +
            ((ASAm < tpz.mission.id.asa.PROJECT_SHANTOTTOFICATION or player:hasKeyItem(tpz.ki.BOMB_KEY) and now ~= player:getCharVar("LastBombKey") )    and 256 or 0)

        player:startEvent(323, arg1)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("update csid = %d, option = %d", csid, option)
    if csid == 323 then
        if option == 100 then -- Viridian Key
            if player:hasKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and player:hasKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE) and player:hasKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB) then
                player:updateEvent(1)
            else
                player:updateEvent(0)
            end
        elseif option == 101 then -- blue coral Key
            if
                player:hasKeyItem(tpz.ki.STURDY_METAL_STRIP) and
                player:hasKeyItem(tpz.ki.PIECE_OF_RUGGED_TREE_BARK) and
                player:hasKeyItem(tpz.ki.SAVORY_LAMB_ROAST)
            then
                player:updateEvent(3)
            else
                player:updateEvent(0)
            end
        elseif option == 102 then -- black coral Key
            if not player:hasKeyItem(tpz.ki.MOLDY_WORMEATEN_CHEST) then
                local diggingZone = amkHelpers.getDiggingZone(player)
                if diggingZone ~= 0 then
                    player:updateEvent(0, 1, amkHelpers.digSites[diggingZone].eventID)
                else
                    player:messageSpecial(ID.text.GET_LOST)
                end
            else
                player:updateEvent(0)
            end
        elseif option == 103 then -- Moogle Key
            local kit = player:getCharVar("ASA_kit")
            if kit == 0 then
                kit = 2779 + math.random(0,3)
                player:setCharVar("ASA_kit", kit)
            end
            player:updateEvent(kit)
        elseif option == 104 then -- Bird Key
            local completedSeals =
            (player:hasKeyItem(tpz.ki.AMBER_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(tpz.ki.AZURE_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(tpz.ki.CERULEAN_COUNTERSEAL) and 1 or 0) +
            (player:hasKeyItem(tpz.ki.EMERALD_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(tpz.ki.SCARLET_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(tpz.ki.VIOLET_COUNTERSEAL)   and 1 or 0)

            if completedSeals >= 3 then
                player:setCharVar("ASA_Status", completedSeals)
                player:updateEvent(0, completedSeals, 2)
            else
                player:updateEvent(0, 0, 1)
            end
        elseif option == 105 then -- Bomb Key
            local completedFragment =
            (player:hasKeyItem(tpz.ki.LUMINOUS_PURPLE_FRAGMENT) and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_YELLOW_FRAGMENT) and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_BLUE_FRAGMENT)   and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_BEIGE_FRAGMENT)  and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_RED_FRAGMENT)    and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_GREEN_FRAGMENT)  and 1 or 0)

            if completedFragment ~= 6 then
                player:updateEvent(0, 0, 0, 0, 0, 0, 3)
            end
        elseif option == 203 then -- 2nd page
            local finishedACP = player:getCurrentMission(ACP) == tpz.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
            local finishedAMK = player:getCurrentMission(AMK) == tpz.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
            local finishedASA = player:getCurrentMission(ASA) == tpz.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN

            local arg1 =
                ((not finishedACP or player:hasKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
                                 and player:hasKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
                                 and player:hasKeyItem(tpz.ki.SEEDSPALL_VIRIDIS))     and   2 or 0) +
                ((not finishedACP or player:hasKeyItem(tpz.ki.MARK_OF_SEED))          and   4 or 0) +
                ((not finishedACP or player:hasKeyItem(tpz.ki.OMNIS_STONE))           and   8 or 0) +
                ((not finishedAMK or player:hasKeyItem(tpz.ki.ORB_OF_CUPS)
                                 and player:hasKeyItem(tpz.ki.ORB_OF_COINS)
                                 and player:hasKeyItem(tpz.ki.ORB_OF_BATONS)
                                 and player:hasKeyItem(tpz.ki.ORB_OF_SWORDS))         and  16 or 0) +
                ((not finishedAMK or player:hasKeyItem(tpz.ki.NAVARATNA_TALISMAN))    and  32 or 0) +
                ((not finishedAMK or player:hasKeyItem(tpz.ki.MEGA_BONANZA_KUPON))    and  64 or 0) +
                ((not finishedASA or player:hasKeyItem(tpz.ki.BLACK_BOOK))            and 128 or 0) +
                ((not finishedASA or player:hasKeyItem(tpz.ki.WATER_SAP_CRYSTAL)
                                 and player:hasKeyItem(tpz.ki.EARTH_SAP_CRYSTAL)
                                 and player:hasKeyItem(tpz.ki.ICE_SAP_CRYSTAL)
                                 and player:hasKeyItem(tpz.ki.WIND_SAP_CRYSTAL)
                                 and player:hasKeyItem(tpz.ki.LIGHTNING_SAP_CRYSTAL)
                                 and player:hasKeyItem(tpz.ki.FIRE_SAP_CRYSTAL)
                                 and player:hasKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL)
                                 and player:hasKeyItem(tpz.ki.DARK_SAP_CRYSTAL))      and 256 or 0) +
                ((not finishedASA or player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_GREED)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BALE)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT)
                                 and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH)) and 512 or 0)

            player:updateEvent(arg1)
        elseif option == 200 then -- Seedspalls, 4 Orbs, Black Book
            if player:getSeals(0) < 5 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_4)
            elseif player:getGil() < 500 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_5)
            else
                player:updateEvent(0)
            end
        elseif option == 201 then -- Mark of Seed, Navaratna Talisman, 8 Sap Crystals
            if player:getSeals(0) < 15 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_4)
            elseif player:getGil() < 1500 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_5)
            else
                player:updateEvent(0)
            end
        elseif option == 202 then -- Omnis Stone, Mega Bonanza Kupon, 16 Tablet of Hexes
            if player:getSeals(0) < 20 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_4)
            elseif player:getGil() < 2000 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_5)
            else
                player:updateEvent(0)
            end
        end
    end

end

function onEventFinish(player, csid, option)
    -- printf("finish csid = %d, option = %d", csid, option)
    local now = tonumber(os.date("%j"))

    if (csid == 323) then
        if (option == 1) then
            player:showText(player, ID.text.DRYEYES_1)
        elseif option == 100 then -- Viridian Key
            if not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) and now ~= player:getCharVar("LastViridianKey") then
                player:addKeyItem(tpz.ki.VIRIDIAN_KEY)
                player:delKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
                player:delKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
                player:delKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
                player:setCharVar("LastViridianKey", os.date("%j"))
                player:showText(player, ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VIRIDIAN_KEY)
            else
                player:messageSpecial(ID.text.DRYEYES_3, tpz.ki.VIRIDIAN_KEY)
            end
        elseif option == 101 then -- blue coral Key
            local keyItem = tpz.ki.BLUE_CORAL_KEY
            if not player:hasKeyItem(keyItem) and now ~= player:getCharVar("LastBlueCoralKey") then
                player:addKeyItem(keyItem)
                player:delKeyItem(tpz.ki.STURDY_METAL_STRIP)
                player:delKeyItem(tpz.ki.PIECE_OF_RUGGED_TREE_BARK)
                player:delKeyItem(tpz.ki.SAVORY_LAMB_ROAST)
                player:setCharVar("LastBlueCoralKey", os.date("%j"))
                player:showText(player, ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItem)
            else
                player:messageSpecial(ID.text.DRYEYES_3, keyItem)
            end
        elseif option == 102 then -- black coral Key
            -- shouldn't trigger without the key, but just in case
            if player:hasKeyItem(tpz.ki.MOLDY_WORMEATEN_CHEST) then
                local keyItem = tpz.ki.BLACK_CORAL_KEY
                if not player:hasKeyItem(keyItem) and now ~= player:getCharVar("LastBlackCoralKey") then
                    player:addKeyItem(keyItem)
                    player:delKeyItem(tpz.ki.MOLDY_WORMEATEN_CHEST)
                    player:setCharVar("LastBlackCoralKey", os.date("%j"))
                    player:showText(player, ID.text.DRYEYES_2)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItem)
                else
                    player:messageSpecial(ID.text.DRYEYES_3, keyItem)
                end
            end
        elseif option == 103 then -- Bird Key
            npcUtil.giveKeyItem(player, {
                tpz.ki.DOMINAS_SCARLET_SEAL,
                tpz.ki.DOMINAS_CERULEAN_SEAL,
                tpz.ki.DOMINAS_EMERALD_SEAL,
                tpz.ki.DOMINAS_AMBER_SEAL,
                tpz.ki.DOMINAS_VIOLET_SEAL,
                tpz.ki.DOMINAS_AZURE_SEAL
            })
        elseif option == 104 then -- Bomb Key
            if not player:hasKeyItem(tpz.ki.BOMB_KEY) and now ~= player:getCharVar("LastBombKey") then
                player:addKeyItem(tpz.ki.BOMB_KEY)
                player:setCharVar("LastBombKey", os.date("%j"))
                player:messageSpecial(ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOMB_KEY)
            end

            player:delKeyItem(tpz.ki.LUMINOUS_PURPLE_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_YELLOW_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_BLUE_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_BEIGE_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_RED_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_GREEN_FRAGMENT)
        elseif option == 105 then -- Bird Key
            if not player:hasKeyItem(tpz.ki.BIRD_KEY) and now ~= player:getCharVar("LastBirdKey") then
                player:addKeyItem(tpz.ki.BIRD_KEY)
                player:setCharVar("LastBirdKey", os.date("%j"))
                player:messageSpecial(ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BIRD_KEY)

                player:delKeyItem(tpz.ki.DOMINAS_SCARLET_SEAL)
                player:delKeyItem(tpz.ki.DOMINAS_CERULEAN_SEAL)
                player:delKeyItem(tpz.ki.DOMINAS_EMERALD_SEAL)
                player:delKeyItem(tpz.ki.DOMINAS_AMBER_SEAL)
                player:delKeyItem(tpz.ki.DOMINAS_VIOLET_SEAL)
                player:delKeyItem(tpz.ki.DOMINAS_AZURE_SEAL)

                player:delKeyItem(tpz.ki.SCARLET_COUNTERSEAL)
                player:delKeyItem(tpz.ki.CERULEAN_COUNTERSEAL)
                player:delKeyItem(tpz.ki.EMERALD_COUNTERSEAL)
                player:delKeyItem(tpz.ki.AMBER_COUNTERSEAL)
                player:delKeyItem(tpz.ki.VIOLET_COUNTERSEAL)
                player:delKeyItem(tpz.ki.AZURE_COUNTERSEAL)
            else
                player:messageSpecial(ID.text.DRYEYES_1)
            end
        elseif option == 300 then -- 3 Seedspalls
            player:delSeals(5, 0)
            player:delGil(500)

            if not player:hasKeyItem(tpz.ki.SEEDSPALL_ROSEUM) then
                player:addKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_ROSEUM)
            end
            if not player:hasKeyItem(tpz.ki.SEEDSPALL_CAERULUM) then
                player:addKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_CAERULUM)
            end
            if not player:hasKeyItem(tpz.ki.SEEDSPALL_VIRIDIS) then
                player:addKeyItem(tpz.ki.SEEDSPALL_VIRIDIS)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_VIRIDIS)
            end
        elseif option == 301 then -- Mark of Seed
            player:delSeals(15, 0)
            player:delGil(1500)

            if not player:hasKeyItem(tpz.ki.MARK_OF_SEED) then
                player:addKeyItem(tpz.ki.MARK_OF_SEED)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MARK_OF_SEED)
            end
        elseif option == 302 then -- Omnis Stone
            player:delSeals(20, 0)
            player:delGil(2000)

            if not player:hasKeyItem(tpz.ki.OMNIS_STONE) then
                player:addKeyItem(tpz.ki.OMNIS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OMNIS_STONE)
            end
        elseif option == 303 then -- Cardians mana orbs
            player:delSeals(5, 0)
            player:delGil(500)

            for i,ki in pairs({tpz.ki.ORB_OF_CUPS,
                        tpz.ki.ORB_OF_COINS,
                        tpz.ki.ORB_OF_BATONS,
                        tpz.ki.ORB_OF_SWORDS}) do
                if not player:hasKeyItem(ki) then
                    player:addKeyItem(ki)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
                end
            end
        elseif option == 304 then -- Navaratna Talisman
            player:delSeals(15, 0)
            player:delGil(1500)

            local ki = tpz.ki.NAVARATNA_TALISMAN
            if not player:hasKeyItem(ki) then
                player:addKeyItem(ki)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
            end
        elseif option == 305 then -- Mega Bonanza Kupon
            player:delSeals(20, 0)
            player:delGil(2000)

            local ki = tpz.ki.MEGA_BONANZA_KUPON
            if not player:hasKeyItem(ki) then
                player:addKeyItem(ki)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
            end
        elseif option == 306 then -- Black Book
            player:delSeals(5, 0)
            player:delGil(500)

            if not player:hasKeyItem(tpz.ki.BLACK_BOOK) then
                player:addKeyItem(tpz.ki.BLACK_BOOK)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLACK_BOOK)
            end
        elseif option == 307 then -- Elemental Saps
            player:delSeals(15, 0)
            player:delGil(1500)

            if not player:hasKeyItem(tpz.ki.FIRE_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.FIRE_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FIRE_SAP_CRYSTAL)
            end
            if not player:hasKeyItem(tpz.ki.WATER_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.WATER_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WATER_SAP_CRYSTAL)
            end
            if not player:hasKeyItem(tpz.ki.WIND_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.WIND_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WIND_SAP_CRYSTAL)
            end
            if not player:hasKeyItem(tpz.ki.EARTH_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.EARTH_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.EARTH_SAP_CRYSTAL)
            end
            if not player:hasKeyItem(tpz.ki.LIGHTNING_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.LIGHTNING_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHTNING_SAP_CRYSTAL)
            end
            if not player:hasKeyItem(tpz.ki.ICE_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.ICE_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ICE_SAP_CRYSTAL)
            end
            if not player:hasKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_SAP_CRYSTAL)
            end
            if not player:hasKeyItem(tpz.ki.DARK_SAP_CRYSTAL) then
                player:addKeyItem(tpz.ki.DARK_SAP_CRYSTAL)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DARK_SAP_CRYSTAL)
            end
        elseif option == 308 then -- Tablet of Hexes KIs
            player:delSeals(20, 0)
            player:delGil(2000)

            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_GREED) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_GREED)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_GREED)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_ENVY)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_MALICE)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_DECEIT)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_PRIDE)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BALE) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_BALE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_BALE)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_DESPAIR)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_REGRET)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_RAGE)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_AGONY)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_DOLOR)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_RANCOR)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_STRIFE)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_PENURY)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_BLIGHT)
            end
            if not player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH) then
                player:addKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_DEATH)
            end
        end
    end
end
