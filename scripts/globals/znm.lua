-----------------------------------
-- Zeni NM System + Helpers
-- Soultrapper         : !additem 18721
-- Blank Soul Plate    : !additem 18722
-- Soultrapper 2000    : !additem 18724
-- Blank HS Soul Plate : !additem 18725
-- Soul Plate          : !additem 2477
-- Sanraku & Ryo       : !pos -127.0 0.9 22.6 50
-----------------------------------
-- require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/common")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
require("scripts/globals/pankration")
require("scripts/globals/utils")
-----------------------------------

tpz = tpz or {}
tpz.znm = tpz.znm or {}

tpz.items = tpz.items or {}
tpz.items["BLANK_SOUL_PLATE"] = 18722
tpz.items["BLANK_HIGH_SPEED_SOUL_PLATE"] = 18725
tpz.items["SOUL_PLATE"] = 2477

-----------------------------------
-- Soultrapper
-----------------------------------
tpz.znm.soultrapper = tpz.znm.soultrapper or {}

tpz.znm.soultrapper.onItemCheck = function(target, user)
    if not user:isFacing(target) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    local id = user:getEquipID(tpz.slot.AMMO)
    if
        id ~= tpz.items.BLANK_SOUL_PLATE and
        id ~= tpz.items.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    if user:getFreeSlotsCount() == 0 then
        return tpz.msg.basic.FULL_INVENTORY
    end

    return 0
end

tpz.znm.soultrapper.getZeniValue = function(target, user, item)
    local hpp = target:getHPP()
    local system = target:getSystem()
    local isNM = target:isNM()
    local distance = user:checkDistance(target)
    local isFacing = target:isFacing(user)

    -- Starting value
    local zeni = 5

    -- HP% Component
    local hpMultiplier = math.min(100 / hpp, 5)
    if hpp <= 5 then
        hpMultiplier = 10
    end
    zeni = zeni * hpMultiplier

    -- In-Demand System Component
    -- TODO: Make rotating server var
    local inDemandSystem = tpz.ecosystem.DRAGON
    if system == inDemandSystem then
        zeni = zeni * 1.5
    end

    -- NM/Rarity Component
    if isNM then
        zeni = zeni * 1.5
    end

    -- Distance Component
    zeni = zeni * utils.clamp((1 / distance) * 2, 1, 2)

    -- Angle/Facing Component
    if isFacing then
        zeni = zeni * 1.5
    end

    -- Bonus for HS Soul Plate
    if user:getEquipID(tpz.slot.AMMO) == tpz.items.BLANK_HIGH_SPEED_SOUL_PLATE then
        zeni = zeni * 1.5
    end

    -- Add a little randomness
    zeni = zeni + math.random(0, 5)

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information
    zeni = utils.clamp(zeni, 1, 100)

    return zeni
end

tpz.znm.soultrapper.onItemUse = function(target, item, user)
    -- Determine Zeni starting value
    local zeni = tpz.znm.soultrapper.getZeniValue(target, user, item)

    -- Pick a skill totally at random...
    local skillIndex, skillEntry = utils.randomEntry(tpz.pankration.feralSkills)

    -- Add plate
    local plate = user:addSoulPlate(target:getName(), target:getFamily(), zeni, skillIndex, skillEntry.fp)
    local data = plate:getSoulPlateData()
    -- utils.unused(data)
end

-----------------------------------
-- Ryo
-----------------------------------
tpz.znm.ryo = tpz.znm.ryo or {}

tpz.znm.ryo.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, tpz.items.SOUL_PLATE) then
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", plateData.zeni)
        player:startEvent(914)
    end
end

tpz.znm.ryo.onTrigger = function(player, npc)
    player:startEvent(913)
end

tpz.znm.ryo.onEventUpdate = function(player, csid, option)
    if csid == 914 then
        local zeniValue = player:getLocalVar("[ZNM][Ryo]SoulPlateValue")
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", 0)
        player:updateEvent(zeniValue)
    elseif csid == 913 then
        if option == 300 then
            player:updateEvent(player:getCurrency("zeni_point"), 0)
        else
            player:updateEvent(0, 0)
        end
    end
end

tpz.znm.ryo.onEventFinish = function(player, csid, option)
end

-----------------------------------
-- Sanraku
-----------------------------------
tpz.znm.sanraku = tpz.znm.sanraku or {}

local platesTradedToday = function(player)
    local currentDay = VanadielDayAbsolute()
    local storedDay = player:getCharVar("[ZNM][Sanraku]TradingDay")

    if currentDay ~= storedDay then
        player:setCharVar("[ZNM][Sanraku]TradingDay", 0)
        player:setCharVar("[ZNM][Sanraku]TradedPlates", 0)
        return 0
    end

    return player:getCharVar("[ZNM][Sanraku]TradedPlates")
end

tpz.znm.sanraku.onTrade = function(player, npc, trade)
    if not player:hasKeyItem(tpz.ki.RHAPSODY_IN_AZURE) then
        if platesTradedToday(player) >= 10 then
            -- TODO: A message here?
            return
        end
    else -- If you have the KI, clear out the tracking vars!
        player:setCharVar("[ZNM][Sanraku]TradingDay", 0)
        player:setCharVar("[ZNM][Sanraku]TradedPlates", 0)
    end

    if npcUtil.tradeHasExactly(trade, tpz.items.SOUL_PLATE) then
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", plateData.zeni)
        player:startEvent(910, plateData.zeni)
    end
end

tpz.znm.sanraku.onTrigger = function(player, npc)
    -- 908: First time introduction
    -- 909: Further interactions
end

tpz.znm.sanraku.onEventUpdate = function(player, csid, option)
end

tpz.znm.sanraku.onEventFinish = function(player, csid, option)
    if csid == 910 then
        player:confirmTrade()
        player:setCharVar("[ZNM][Sanraku]TradingDay", VanadielDayAbsolute())
        player:addCharVar("[ZNM][Sanraku]TradedPlates", 1)

        local zeniValue = player:getLocalVar("[ZNM][Sanraku]SoulPlateValue")
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", 0)

        player:addCurrency("zeni_point", zeniValue)
    end
end
