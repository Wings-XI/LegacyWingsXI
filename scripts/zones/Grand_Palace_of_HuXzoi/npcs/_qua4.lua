-----------------------------------
-- Area: Grand Palace
--  NPC: Quasilumin
-- Type: Standard NPC
-- !pos -539.9705 -1 297.24 34
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------

local path = 
        {   
            -539.9705, -1, 297.24,
            -539.9705, -1, 260.40,
            -500.07, 0, 260.9,
            -499.86, 0, 278.47,
            -499.48, 0, 340,
            -539.81, 0, 339.95,
            -539.96, 0, 379.65,
            -499.99, 0, 379.91,
            -500.27, 0, 419.92,
            -540.129, 0, 438.96,
            -539.96, 0, 478.81,
            -539.93, 0, 499.99,
            -499.89, 0, 499.95,
            -499.65, 0, 518.79,
            -499.65, 0, 539.93,
            -441.33, 0, 539.99,
            -419.91, 0, 539.99,
            -420.03, 0, 500,
            -382.61, -1, 500.04
        }

    

function onSpawn(npc)
    npc:initNpcAi()
    npc:speed(18) 
    npc:setPos(-539.9705, -1, 297.24)
    npc:hideNPC(5000)
    local qmNPC = GetNPCByID(16916930)
    qmNPC:setLocalVar("checkpoint", 0)
    qmNPC:setLocalVar("quasiStatus", 0)
    local checkpoint = qmNPC:getLocalVar("checkpoint")
    npc:pathTo(-539.9705, -1, 260.40)
end


function onTrade(player, npc, trade)
end

function onTrigger(player, npc) 
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onPath(npc, player)
    local qmNPC = GetNPCByID(16916930)

    local quasiStatus = qmNPC:getLocalVar("quasiStatus")
    local checkpoint = qmNPC:getLocalVar("checkpoint")

    if checkpoint == 0 and npc:checkDistance(-539.9705, -1, 297.24) < .1 then
        npc:pathTo(-539.9705, -1, 260.40)  
        qmNPC:setLocalVar("checkpoint", 1)
    elseif checkpoint == 1 and npc:checkDistance(-539.9705, -1, 260.40) < .1 then
        npc:pathTo(-500.07, 0, 260.9)
        qmNPC:setLocalVar("checkpoint", 2)
    elseif checkpoint == 2 and npc:checkDistance(-500.07, 0, 260.9) < .1 then
        npc:pathTo(-499.86, 0, 278.47)
        qmNPC:setLocalVar("checkpoint", 3)
    elseif checkpoint == 3 and npc:checkDistance(-499.86, 0, 278.47) < .1 then
        if quasiStatus == 1 then
            GetNPCByID(16916882):openDoor(15)
        end
        npc:pathTo(-499.48, 0, 290)
        qmNPC:setLocalVar("checkpoint", 4)
    elseif checkpoint == 4 and npc:checkDistance(-499.48, 0, 290) < .1 then
        npc:pathTo(-499.48, 0, 340)
        qmNPC:setLocalVar("checkpoint", 5)
    elseif checkpoint == 5 and npc:checkDistance(-499.48, 0, 340) < .1 then
        npc:pathTo(-539.81, 0, 339.95)
        qmNPC:setLocalVar("checkpoint", 6)
    elseif checkpoint == 6 and npc:checkDistance(-539.81, 0, 339.95) < .1 then
        npc:pathTo(-539.96, 0, 379.65)
        qmNPC:setLocalVar("checkpoint", 7)
    elseif checkpoint == 7 and npc:checkDistance(-539.96, 0, 379.65) < .1 then
        npc:pathTo(-499.99, 0, 379.91)
        qmNPC:setLocalVar("checkpoint", 8)
    elseif checkpoint == 8 and npc:checkDistance(-499.99, 0, 379.91) < .1 then
        npc:pathTo(-500.27, 0, 419.92)
        qmNPC:setLocalVar("checkpoint", 9)
    elseif checkpoint == 9 and npc:checkDistance(-500.27, 0, 419.92) < .1 then
        npc:pathTo(-540.129, 0, 438.96)
        qmNPC:setLocalVar("checkpoint", 10)
    elseif checkpoint == 10 and npc:checkDistance(-540.129, 0, 438.96) < .1 then
        if quasiStatus == 1 then
            GetNPCByID(16916883):openDoor(15)
        end
        npc:pathTo(-539.96, 0, 478.81)
        qmNPC:setLocalVar("checkpoint", 11)
    elseif checkpoint == 11 and npc:checkDistance(-539.96, 0, 478.81) < .1 then
        if quasiStatus == 1 then
            GetNPCByID(16916884):openDoor(15)
        end
        npc:pathTo(-539.93, 0, 499.99)
        qmNPC:setLocalVar("checkpoint", 12)
    elseif checkpoint == 12 and npc:checkDistance(-539.93, 0, 499.99) < .1 then
        npc:pathTo(-499.89, 0, 499.95)
        qmNPC:setLocalVar("checkpoint", 13)
    elseif checkpoint == 13 and npc:checkDistance(-499.89, 0, 499.95) < .1 then
        npc:pathTo(-499.65, 0, 518.79)
        qmNPC:setLocalVar("checkpoint", 14)
    elseif checkpoint == 14 and npc:checkDistance(-499.65, 0, 518.79) < .1 then
        if quasiStatus == 1 then
            GetNPCByID(16916885):openDoor(15)
        end
        npc:pathTo(-499.65, 0, 539.93)
        qmNPC:setLocalVar("checkpoint", 15)
    elseif checkpoint == 15 and npc:checkDistance(-499.65, 0, 539.93) < .1 then
        npc:pathTo(-441.33, 0, 539.99)
        qmNPC:setLocalVar("checkpoint", 16)
    elseif checkpoint == 16 and npc:checkDistance(-441.33, 0, 539.99) < .1 then
        if quasiStatus == 1 then
            GetNPCByID(16916886):openDoor(15)
        end
        npc:pathTo(-419.91, 0, 539.99)
        qmNPC:setLocalVar("checkpoint", 17)
    elseif checkpoint == 17 and npc:checkDistance(-419.91, 0, 539.99) < .1 then
        npc:pathTo(-420.03, 0, 500)
        qmNPC:setLocalVar("checkpoint", 18)
    elseif checkpoint == 18 and npc:checkDistance(-420.03, 0, 500) < .1 then
        npc:pathTo(-382.61, -1, 500.04)
        qmNPC:setLocalVar("checkpoint", 19)
    elseif checkpoint == 19 and npc:checkDistance(-382.61, -1, 500.04) < .1 then
        qmNPC:setLocalVar("checkpoint", 0)
        
        if quasiStatus == 1 then
            GetNPCByID(16916880):openDoor(30)
            qmNPC:setLocalVar("quasiStatus", 0)
            npc:showText(npc, 7358)
            npc:showText(npc, 7363)
        end
        npc:hideNPC(7000)
        npc:setPos(540, -1, 296.5)
        npc:pathTo(539.95, 0, 260.12)   
    end

    if quasiStatus == 0 then
        npc:updateNPCHideTime(25000)
    end
end
