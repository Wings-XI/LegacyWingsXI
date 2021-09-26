-----------------------------------
--
-- Assault: Leujaoam Cleansing
--
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/instance")
require("scripts/globals/missions")
require("scripts/globals/assault")
require("scripts/globals/zone")
-----------------------------------

function onInstanceCreated(instance)
    instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC):setPos(476, 8.479, 39, 49)
    instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC):setPos(476, 8.479, 40, 49)

    spawnMobInAssault(instance, ID.mob)
end

function afterInstanceRegister(player)
    afterAssaultRegister(player, 5343, ID.text, ID.mob)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    onAssaultFailure(instance, 102, ID.text)
end

function onInstanceProgressUpdate(instance, progress)
    if (instance:getProgress() >= 15) then
        instance:fail()
    end
end

function onInstanceComplete(instance)
    onAssaultComplete(instance, 8, 8, ID.text, ID.npc)
end

function onEventUpdate(player, csid, option)
end
