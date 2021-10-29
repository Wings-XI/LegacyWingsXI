---------------------------------------------------------------------------------------------------
-- func: spawnmobinstance
-- desc: Spawns a mob.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "iii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spawnmobinstance <mob ID>")
end

function onTrigger(player, mobId)

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
        error(player, "Player not inside an instance - use spawnmob.")       
    else
        targ = GetMobByID(mobId, instance)
         if targ == nil then
            error(player, "Invalid mob ID? Invalid Spawnpoint-group-family linkage? Is the mob in instance_entities?   Either way - didnt find the mob")
            return
        end
    end

    SpawnMob( targ:getID(), instance)

    player:PrintToPlayer( string.format("Spawned %s %s.", targ:getName(), targ:getID()) )
end
