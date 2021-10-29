---------------------------------------------------------------------------------------------------
-- func: spawnmob
-- desc: Spawns a mob.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "iii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spawnmob <mob ID> {despawntime} {respawntime}")
end

function onTrigger(player, mobId, despawntime, respawntime)

    -- validate mobId
    if mobId == nil then
        error(player, "You must provide a mob ID.")
        return
    end
    -- prevent server crash
    if mobId < 16500000 or mobId > 26500000 then
        error(player, "The specified mob ID is out of range.")
        return
    end

    local targ
    local instance = player:getInstance()

    if (instance == nil) then
        targ = GetMobByID(mobId)
        if targ == nil then
            error(player, "Invalid mob ID.")
            return
        end
    else
        targ = GetMobByID(mobId, instance)
         if targ == nil then
            error(player, "Invalid mob ID.")
            return
        end
    end

    -- validate despawntime
    if despawntime ~= nil and despawntime < 0 then
        error(player, "Invalid despawn time.")
        return
    end

    -- validate respawntime
    if respawntime ~= nil and respawntime < 0 then
        error(player, "Invalid respawn time.")
        return
    end
    if (instance == nil) then
        SpawnMob( targ:getID(), despawntime, respawntime )
    else
        SpawnMob( targ:getID(), instance, despawntime, respawntime )
    end
    player:PrintToPlayer( string.format("Spawned %s %s.", targ:getName(), targ:getID()) )
end
