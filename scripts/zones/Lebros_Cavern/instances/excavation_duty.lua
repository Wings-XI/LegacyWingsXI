-----------------------------------
--
-- Assault: Excavation Duty
--
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/instance")
require("scripts/globals/missions")
require("scripts/globals/assault")
require("scripts/globals/zone")
-----------------------------------

function onInstanceCreated(instance)
    instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC):setPos(49.999,-40.837,96.999,0)
    instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC):setPos(50.000,-40.070,99.999,0)

    spawnMobInAssault(instance, ID.mob)
end

function afterInstanceRegister(player)
    afterAssaultRegister(player, 5345, ID.text, ID.mob)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    onAssaultFailure(instance, 102, ID.text)
end

function onInstanceProgressUpdate(instance, progress)
    if progress >= 5 then    
        instance:complete()
    end
end

function onInstanceComplete(instance)
    onAssaultComplete(instance, 5, 10, ID.text, ID.npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    assaultOnEventFinish(player, 102, tpz.zone.MOUNT_ZHAYOLM)
end
