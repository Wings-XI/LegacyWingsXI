-----------------------------------
-- Project Shantottofication
-- ASA13 Final Battle
-----------------------------------
require("scripts/globals/battlefield")
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
        player:addStatusEffect(tpz.effect.BARTHUNDER, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_GREED)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY) then
        player:addStatusEffect(tpz.effect.BARBLIZZARD, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY)
    end 
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE) then
        player:addStatusEffect(tpz.effect.BARAERO, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT) then
        player:addStatusEffect(tpz.effect.BARSTONE, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE) then
        player:addStatusEffect(tpz.effect.BARFIRE, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BALE) then
        player:addStatusEffect(tpz.effect.BARWATER, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_BALE)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR) then
        player:addStatusEffect(tpz.effect.STR_BOOST, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET) then
        player:addStatusEffect(tpz.effect.DEX_BOOST, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE) then
        player:addStatusEffect(tpz.effect.VIT_BOOST, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY) then
        player:addStatusEffect(tpz.effect.AGI_BOOST, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR) then
        player:addStatusEffect(tpz.effect.INT_BOOST, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR) then
        player:addStatusEffect(tpz.effect.MND_BOOST, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE) then
        player:addStatusEffect(tpz.effect.CHR_BOOST, 150, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY) then
        local hpBoost = player:getMaxHP() * 300
        player:addStatusEffect(tpz.effect.MAX_HP_BOOST, hpBoost, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT) then
        local mpBoost = player:getMaxMP() * 300
        player:addStatusEffect(tpz.effect.MAX_MP_BOOST, mpBoost, 0, 0)
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT)
    end
    if player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH) then
        -- need to implement a reraise effect that gives no weakness
        player:delKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH)
    end
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end

    player:delStatusEffect(tpz.effect.BARTHUNDER)
    player:delStatusEffect(tpz.effect.BARBLIZZARD)
    player:delStatusEffect(tpz.effect.BARAERO)
    player:delStatusEffect(tpz.effect.BARSTONE)
    player:delStatusEffect(tpz.effect.BARFIRE)
    player:delStatusEffect(tpz.effect.BARWATER)
    player:delStatusEffect(tpz.effect.STR_BOOST)
    player:delStatusEffect(tpz.effect.DEX_BOOST)
    player:delStatusEffect(tpz.effect.VIT_BOOST)
    player:delStatusEffect(tpz.effect.AGI_BOOST)
    player:delStatusEffect(tpz.effect.INT_BOOST)
    player:delStatusEffect(tpz.effect.MND_BOOST)
    player:delStatusEffect(tpz.effect.CHR_BOOST)
    player:delStatusEffect(tpz.effect.MAX_HP_BOOST)
    player:delStatusEffect(tpz.effect.MAX_MP_BOOST)
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
