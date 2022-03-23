---------------------------------------------------------------------------------------------------
-- func: despawnmob <mobid-optional>
-- desc: Despawns the given mob <t> or mobID)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!despawnmob {mobID}")
end

function onTrigger(player, mobId)

    -- validate mobId
    local targ
    if mobId == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isMob() then
            error(player, "You must either provide a mobID or target a mob.")
            return
        end
    else
        -- prevent server crash
        if mobId < 16500000 or mobId > 26500000 then
            error(player, "The specified mob ID is out of range.")
            return
        end
        if (player:getInstance() == nil) then
            targ = GetMobByID(mobId)
        else
            targ = GetMobByID(mobId, player:getInstance())
        end
        if targ == nil then
            error(player, "Invalid mobID.")
            return
        end
    end

    -- despawn mob
    if (player:getInstance() == nil) then
        DespawnMob(targ:getID(), 0)
    else
        DespawnMob(targ:getID(), player:getInstance())
    end
    player:PrintToPlayer(string.format("Despawned %s %i.", targ:getName(), targ:getID()))

end
