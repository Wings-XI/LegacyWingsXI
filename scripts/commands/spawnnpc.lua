---------------------------------------------------------------------------------------------------
-- func: spawnnpc
-- desc: Spawns an NPC.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "iii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spawnnpc <NPC ID>")
end

function onTrigger(player, npcid, newstatus)

    -- validate NPC ID
    if npcid == nil then
        error(player, "You must provide an NPC ID.")
        return
    end
    local npc = GetNPCByID(npcid)
    if npc == nil then
        error(player, "Invalid NPC ID.")
        return
    end

	if newstatus == nil then
		newstatus = tpz.status.NORMAL
	end
	npc:setStatus(newstatus)
	
    player:PrintToPlayer( string.format("Spawned %s %s.", npc:getName(), npc:getID()) )
end
