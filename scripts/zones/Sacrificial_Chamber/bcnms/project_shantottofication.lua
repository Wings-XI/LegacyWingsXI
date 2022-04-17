-----------------------------------
-- Project Shantottofication
-- ASA13 Final Battle
-----------------------------------
require("scripts/globals/battlefield")
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
-----------------------------------

function onBattlefieldInitialise(battlefield)
end

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_GREED) then
        player:addStatusEffectEx(tpz.effect.BARTHUNDER, tpz.effect.MAGIC_DEF_BOOST, 0, 0, 0)
        player:setMod(tpz.mod.THUNDERRES, 150)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY) then
        player:addStatusEffectEx(tpz.effect.BARBLIZZARD, tpz.effect.MAGIC_DEF_BOOST, 0, 0, 0)
        player:setMod(tpz.mod.ICERES, 150)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE) then
        player:addStatusEffectEx(tpz.effect.BARAERO, tpz.effect.MAGIC_DEF_BOOST, 0, 0, 0)
        player:setMod(tpz.mod.WINDRES, 150)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT) then
        player:addStatusEffectEx(tpz.effect.BARSTONE, tpz.effect.MAGIC_DEF_BOOST, 0, 0, 0)
        player:setMod(tpz.mod.EARTHRES, 150)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE) then
        player:addStatusEffectEx(tpz.effect.BARFIRE, tpz.effect.MAGIC_DEF_BOOST, 0, 0, 0)
        player:setMod(tpz.mod.FIRERES, 150)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BALE) then
        player:addStatusEffectEx(tpz.effect.BARWATER, tpz.effect.MAGIC_DEF_BOOST, 0, 0, 0)
        player:setMod(tpz.mod.WATERRES, 150)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR) then
        player:addStatusEffect(tpz.effect.STR_BOOST, 150, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET) then
        player:addStatusEffect(tpz.effect.DEX_BOOST, 150, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE) then
        player:addStatusEffect(tpz.effect.VIT_BOOST, 150, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY) then
        player:addStatusEffect(tpz.effect.AGI_BOOST, 150, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR) then
        player:addStatusEffect(tpz.effect.INT_BOOST, 150, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR) then
        player:addStatusEffect(tpz.effect.MND_BOOST, 150, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE) then
        player:addStatusEffect(tpz.effect.CHR_BOOST, 150, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY) then
        player:addStatusEffect(tpz.effect.MAX_HP_BOOST, 200, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT) then
        player:addStatusEffect(tpz.effect.MAX_MP_BOOST, 200, 0, 0)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH) then
        player:addStatusEffect(tpz.effect.RERAISE, 1, 0, 3600)
        player:setLocalVar("Shantottofication", 1)
    end

    player:getStatusEffect(tpz.effect.BARTHUNDER):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.BARBLIZZARD):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.BARAERO):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.BARSTONE):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.BARFIRE):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.BARWATER):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.STR_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.DEX_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.VIT_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.AGI_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.INT_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.MND_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.CHR_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.MAX_HP_BOOST):unsetFlag(tpz.effectFlag.DEATH)
    player:getStatusEffect(tpz.effect.MAX_MP_BOOST):unsetFlag(tpz.effectFlag.DEATH)

    player:setCharVar("ASA_BCNM", 1)
    player:setTP(0)
    player:timer(1000, function(player) player:setHP(player:getMaxHP()) player:setMP(player:getMaxMP()) end)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 163, battlefield:getLocalVar("[cs]bit"), 0)

        local now = tonumber(os.date("%j"))
        local lastTonberry = player:getCharVar("LastTonberryKey")

        player:addExp(750)

        if player:getCharVar("ASA_BCNM") == 1 then
            player:setCharVar("ASA_BCNM", 0)
            if not player:hasKeyItem(tpz.ki.TONBERRY_KEY) and now ~= lastTonberry and player:getCurrentMission(ASA) >= tpz.mission.id.asa.BATTARU_ROYALE then
                player:setCharVar("LastTonberryKey", os.date("%j"))
                player:addKeyItem(tpz.ki.TONBERRY_KEY)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TONBERRY_KEY)
            end
        end
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end

    player:delStatusEffect(tpz.effect.BARTHUNDER)
    player:delStatusEffect(tpz.effect.BARBLIZZARD)
    player:delStatusEffect(tpz.effect.BARAERO)
    player:delStatusEffect(tpz.effect.BARSTONE)
    player:delStatusEffect(tpz.effect.BARFIRE)
    player:delStatusEffect(tpz.effect.BARWATER)
    player:setMod(tpz.mod.ICERES, 0)
    player:setMod(tpz.mod.WINDRES, 0)
    player:setMod(tpz.mod.EARTHRES, 0)
    player:setMod(tpz.mod.FIRERES, 0)
    player:setMod(tpz.mod.WATERRES, 0)
    player:delStatusEffect(tpz.effect.STR_BOOST)
    player:delStatusEffect(tpz.effect.DEX_BOOST)
    player:delStatusEffect(tpz.effect.VIT_BOOST)
    player:delStatusEffect(tpz.effect.AGI_BOOST)
    player:delStatusEffect(tpz.effect.INT_BOOST)
    player:delStatusEffect(tpz.effect.MND_BOOST)
    player:delStatusEffect(tpz.effect.CHR_BOOST)
    player:delStatusEffect(tpz.effect.MAX_HP_BOOST)
    player:delStatusEffect(tpz.effect.MAX_MP_BOOST)
    player:setLocalVar("Shantottofication", 0)

    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_GREED)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_BALE)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT)
    player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(ASA) == tpz.mission.id.asa.PROJECT_SHANTOTTOFICATION then
            player:startEvent(5)
            player:completeMission(ASA, tpz.mission.id.asa.PROJECT_SHANTOTTOFICATION)
            player:addMission(ASA, tpz.mission.id.asa.AN_UNEASY_PEACE)
            player:setPos(299.967, 0.22, 339.836, 0)
        end
    end
end
