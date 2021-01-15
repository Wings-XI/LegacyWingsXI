
--require("scripts/globals/zone")

function isInSameTown(from, to)
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

function tryMoveToLeaderMH(player)
    local leaderid = player:getLeaderID()
    
    if leaderid == nil or leaderid == player:getID() then
        return
    end
    
    local leader = GetPlayerByID(leaderid)
    
    if leader == nil or leader:getOpenMH() == false or isInSameTown(player:getZoneID(),leader:getZoneID()) == false then
        return
    end
    
    player:gotoPlayer(leader:getName())
    
    return
end