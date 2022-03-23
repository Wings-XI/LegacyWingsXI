-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Runic Seal
-- !pos 125 -2 20 72
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/besieged")
require("scripts/globals/settings")
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- ToDo - move this logic to instance.lua via a shared function.  The caller can provide the player and the zone/npc
    -- Having a "bit" set hides an option - althrough the param is an int
    NONE                    = 1     -- 1th bit (1) hides "None"
    ASSAULT                 = 2     -- 2nd bit (2) Assault override
    PATH_OF_DARKNESS        = 4     -- 3rd bit (4) hides "Path of Darkness"
    NASHMEIRAS_PLEA         = 8     -- 4th bit (8) hides "Nashmeiras Plea"
    FORGING_A_NEW_MYTH      = 16    -- 5th bit (16) hides "Forging A New Myth"
    WAKING_THE_COLOSSUS     = 32    -- 6th bit (32) hides "Waking the Colossus"
    HEROINES_HOLDFAST       = 64    -- 7th bit (64) hides "Heroine's Holdfast"
    BLACK_AND_WHITE         = 128   -- 8th bit (128) hides "Black and White"

    -- Param 1 overrides the assult entry with a pre-defined value corresponding to assault ID
    NYZUL_ISLE_INVESTIGATION = 51

    local allInstances = ASSAULT + PATH_OF_DARKNESS + NASHMEIRAS_PLEA + FORGING_A_NEW_MYTH + WAKING_THE_COLOSSUS + HEROINES_HOLDFAST + BLACK_AND_WHITE
    local availableInstances = allInstances
    local armband = 0
    if player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) then
        armband = 1
    end
    local recommendedLevel = 75

    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS and player:hasKeyItem(tpz.ki.NYZUL_ISLE_ROUTE) and player:getCharVar("AhtUrganStatus") == 1 then
        availableInstances = availableInstances - PATH_OF_DARKNESS
    end

    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.NASHMEIRAS_PLEA and player:hasKeyItem(tpz.ki.MYTHRIL_MIRROR) and player:getCharVar("AhtUrganStatus") == 1)
        or (player:getCharVar("TOAU_RING_REACQ_STATUS") == 2) then
        availableInstances = availableInstances - NASHMEIRAS_PLEA
    end

    if player:hasKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS) and player:getCharVar("assaultEntered") == 0 and (IS_NYZUL_ISLE_ASSAULT_ACTIVATED and IS_NYZUL_ISLE_ASSAULT_ACTIVATED == 1) then
        availableInstances = availableInstances - ASSAULT
    end

    if (availableInstances < allInstances) then
        player:startEvent(405, NYZUL_ISLE_INVESTIGATION, availableInstances, 0, recommendedLevel, 5, armband)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option, target)
    if csid ~= 405 then
        return
    end

    -- Begin Ugly Hack
    --
    -- For some currently unknown reason, the Nyzul event can
    -- spam event updates uncontrollably. Until we can figure
    -- out why, I used a double lock to hack around it. The
    -- first latch is auto set here, which suppresses future
    -- updates which the instance is initialized. The 2nd latch
    -- is set after the instance is created. Then we use that
    -- to force terminate the event so that we can go into the
    -- instance successfully.

    -- Dev note: this looping hack prob has something to do with the event params being sent
    -- While it works for now - it needs a deep dive to get cleared up

    if player:getLocalVar("NyzulReady") == 1 then -- Latch 2
        player:updateEvent(405, 3, 3, 3, 3, 3, 3, 3) -- Force terminate the event
        return
    elseif player:getLocalVar("NyzulLoopGuard") == 1 then
        return -- Suppress Update Spam
    else
        player:setLocalVar("NyzulLoopGuard", 1) -- Latch 1
    end
    -- End Ugly Hack

    local assaultid = player:getCurrentAssault()

    local cap = bit.band(option, 0x03)
    if cap == 0 then
        cap = 0
    elseif cap == 1 then
        cap = 70
    elseif cap == 2 then
        cap = 60
    else
        cap = 50
    end

    player:setCharVar("AssaultCap", cap)

    local party = player:getParty()

    -- PATH_OF_DARKNESS
    if option == 524288 then
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() then
                    if v:getCurrentMission(TOAU) < tpz.mission.id.toau.PATH_OF_DARKNESS then
                        player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                        player:instanceEntry(target, 1)
                        return
                    elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                        player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                        player:instanceEntry(target, 1)
                        return
                    end
                end
            end
        end

        player:createInstance(58, 77)
    -- NASHMEIRAS_PLEA
    elseif option == 786432 then

        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() then
                    if v:getCurrentMission(TOAU) < tpz.mission.id.toau.NASHMEIRAS_PLEA then
                        player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                        player:instanceEntry(target, 1)
                        return
                    elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                        player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                        player:instanceEntry(target, 1)
                        return
                    end
                end
            end
        end

        player:createInstance(59, 77)
    else
        -- nyzul isle investigation asault
        if player:getGMLevel() == 0 and player:getPartySize() < 3 then
            player:messageSpecial(ID.text.PARTY_MIN_REQS, 3)
            player:instanceEntry(target,1)
            return
        elseif player:checkSoloPartyAlliance() == 2 then
            player:messageText(player, ID.text.PARTY_NO_REQS, false)
            player:instanceEntry(target,1)
            return
        end


        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() then
                    if not v:hasKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS) and v:getCurrentAssault() == assaultid then
                        player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                        player:instanceEntry(target, 1)
                        return
                    elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                        player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                        player:instanceEntry(target, 1)
                        return
                    end
                end
            end
        end

        player:createInstance(player:getCurrentAssault(), 77)
    end

end

function onEventFinish(player, csid, option, target)
    if csid == 405 and option == 1073741824 and player:getLocalVar("NyzulReady") == 1 then
        player:startEvent(116, 2) -- This means the event was force terminated. Loop into the entrance animation.
    elseif csid == 116 or (csid == 405 and option == 4) and not(option == 1073741824) then
        player:setPos(0, 0, 0, 0, 77)
    end
end

function onInstanceCreated(player, target, instance)

    if instance then
        if instance:getID() == 58 then
            player:delKeyItem(tpz.ki.NYZUL_ISLE_ROUTE)
        elseif instance:getID() == 59 then
            player:delKeyItem(tpz.ki.MYTHRIL_MIRROR)
        else
            instance:setLevelCap(player:getCharVar("AssaultCap"))
            player:setCharVar("AssaultCap", 0)
            player:delKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS)
            player:delKeyItem(tpz.ki.ASSAULT_ARMBAND)
            player:setCharVar("Assault_Armband", 1)
            player:messageSpecial(ID.text.COMMENCING_TRANSPORT)
        end

        player:setInstance(instance)
        player:instanceEntry(target, 4)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    -- force players out of menu
                    v:release()
                    v:setInstance(instance)
                    -- Delay entrace CS
                    v:timer(2000, function(v) v:startEvent(116, 2) end)
                    v:setLocalVar("Nyzul", 1)

                    if instance:getID() == 58 then
                        v:delKeyItem(tpz.ki.NYZUL_ISLE_ROUTE)
                    elseif instance:getID() == 59 then
                        v:delKeyItem(tpz.ki.MYTHRIL_MIRROR)
                    else
                        v:delKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS)
                        v:messageSpecial(ID.text.ORDER_GIVEN_TO_INVADE, 5)
                    end
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end

    -- EventUpdate Hack: 2nd latch
    player:setLocalVar("NyzulReady", 1)
end
