-----------------------------------
-- Area: Port Jeuno
--   NPC: Squintrox Dryeyes
-- Type: Addon Mission Merchant
-- !pos -100.071 -1 11.869 246
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local now = tonumber(os.date("%j"))
    local count = trade:getItemCount()
    local sLux = trade:hasItemQty(2740, 1)
    local sLuna = trade:hasItemQty(2741, 1)
    local sAstrum = trade:hasItemQty(2742, 1)
    local orcArmor = trade:hasItemQty(2757, 1)
    local quadavBack = trade:hasItemQty(596, 1)
    local yagCaulk = trade:hasItemQty(2759, 1)
    local eKitBlind = trade:hasItemQty(2780, 1)
    local eKitPoison = trade:hasItemQty(2779, 1)
    local eKitSilence = trade:hasItemQty(2782, 1)
    local eKitSleep = trade:hasItemQty(2781, 1)
    local uggalepihWhistle = trade:hasItemQty(1184, 1)

    if (ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA ==0) then
        player:showText(npc, ID.text.GET_LOST)
    else -- Crimson Key
        if sLux and sLuna and sAstrum and count == 3 and player:getCurrentMission(ACP) >= tpz.mission.id.acp.GATHERER_OF_LIGHT_I then
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
end

function onTrigger(player, npc)
    if (ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA == 0) then
        player:showText(npc, ID.text.GET_LOST)
    else
        local ACPm = player:getCurrentMission(ACP)
        local AMKm = player:getCurrentMission(AMK)
        local ASAm = player:getCurrentMission(ASA)

        --Update below with missions for future add-ons
        local arg1 =
            ((ACPm < tpz.mission.id.acp.GATHERER_OF_LIGHT_I or player:hasKeyItem(tpz.ki.CRIMSON_KEY))     and   2 or 0) +
            ((ACPm < tpz.mission.id.acp.GATHERER_OF_LIGHT_I or player:hasKeyItem(tpz.ki.VIRIDIAN_KEY))    and   4 or 0) +
            ((ENABLE_AMK == 0 or player:hasKeyItem(tpz.ki.WHITE_CORAL_KEY))                               and   8 or 0) +
            ((ENABLE_AMK == 0 or player:hasKeyItem(tpz.ki.BLUE_CORAL_KEY))                                and  16 or 0) +
            ((ENABLE_AMK == 0 or player:hasKeyItem(tpz.ki.BLACK_CORAL_KEY))                               and  32 or 0) +
            ((ENABLE_ASA == 0 or player:hasKeyItem(tpz.ki.MOOGLE_KEY))                                    and  64 or 0) +
            ((ENABLE_ASA == 0 or player:hasKeyItem(tpz.ki.BIRD_KEY))                                      and 128 or 0) +
            ((ENABLE_ASA == 0 or player:hasKeyItem(tpz.ki.BOMB_KEY))                                      and 256 or 0)

        player:startEvent(323, arg1)
    end
end

function onEventUpdate(player, csid, option)
    if csid == 323 then
        if option == 100 then -- Viridian Key
            if player:hasKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and player:hasKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE) and player:hasKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB) then
                player:updateEvent(1)
            else
                player:updateEvent(0)
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
        end
    end
end
