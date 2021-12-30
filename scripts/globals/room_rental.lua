-------------------------------------------
-- Room rental NPCs                      --
-- Initial version by Caelic             --
-- Complete rewrite by Twilight          --
-- (c) 2021 Wings Open Source Project.   --
-- Licensed under AGPLv3                 --
-------------------------------------------

function rrGetPartyMemberByIndex(player, index)
    if index < 0 then
        return nil
    end
    if index == 0 then
        return player
    end
    local party = player:getParty()
    if party == nil then
        return nil
    end
    if index > #party then
        return nil
    end
    -- Sorted by member ID (I think...)
    local memberids = {}
    for key, member in pairs(party) do
        table.insert(memberids, member:getID())
    end
    table.sort(memberids)
    local targetmemberid = memberids[index]
    if targetmemberid == nil then
        return nil
    end
    for key, member in pairs(party) do
        if member:getID() == targetmemberid then
            return member
        end
    end
    return nil
end

function rrIsInSameTown(from, to)
    if from == 243 or from == 244 or from == 245 or from == 246 then -- jeuno
        if to == 243 or to == 244 or to == 245 or to == 246 then
            return true
        end
    end
    
    if from == 48 or from == 50 then -- WG
        if to == 48 or to == 50 then
            return true
        end
    end
    
    if from == 234 or from == 235 or from == 236 then -- bastok
        if to == 234 or to == 235 or to == 236 then
            return true
        end
    end
    
    if from == 230 or from == 231 or from == 232 then -- sandy
        if to == 230 or to == 231 or to == 232 then
            return true
        end
    end
    
    if from == 238 or from == 239 or from == 240 or from == 241 then -- windy
        if to == 238 or to == 239 or to == 240 or to == 241 then
            return true
        end
    end
    
    return false
end

function rrTryMoveToOpenMH(player, targetindex)

    if targetindex == nil or targetindex < 1 or targetindex > player:getPartySize() then
        return
    end
    
    local targetplayer = rrGetPartyMemberByIndex(player, targetindex)
    if targetplayer == nil or targetplayer:getID() == player:getID() then
        return
    end
    
    local targetname = targetplayer:getName()
    if targetplayer:getOpenMH() == false or targetplayer:isInMogHouse() == false or rrIsInSameTown(player:getZoneID(),targetplayer:getZoneID()) == false then
        return
    end
    
    player:gotoPlayer(targetname)
    
    return
end

function rrOnTrigger(player, npc, csid, param1)
    if param1 ~= nil then
        player:startEvent(csid, player:getNation(), param1)
    else
        player:startEvent(csid, player:getNation())
    end
end

function rrOnEventFinish(player, csid, option)
    local psize = player:getPartySize()
    if psize <= 1 then
        -- Options are meaningless when not in a party and
        -- we'd crash if we tried to use them.
        return
    end
    if option > 0 and option <= psize then
        rrTryMoveToOpenMH(player, option)
    end
end
