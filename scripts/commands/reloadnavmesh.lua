-----------------------------------
-- func: reloadnavmesh
-- desc: Reload the navmesh for the current zone
-- note: This is for reloading the underlying navmesh object, is not intended
--       to do anything to runtime pathing
-----------------------------------

cmdprops =
{
    permission = 4,
    parameters = ""
}

function onTrigger(player)
    -- player:getZone():reloadNavmesh()
    player:PrintToPlayer("Navmesh reload command NOT sent. Command disabled until it doesn't crash the zone...")
end
