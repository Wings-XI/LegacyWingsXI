-----------------------------------
-- Area: Lebros Cavern
--  Mob: Imperial Stormer
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
--require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------

local assaultFood =
{
    [1]  = 5238,-- seafood_stewpot Full effet pas implémenté
    [2]  = 5142,-- bison_steak 5pts
    [3]  = 5166,-- coeurl_sub 4pts
    [4]  = 5207,-- Bison_Jerky 3pts
    [5]  = 4416,-- Pea_Soup 2pts
    [6]  = 4356,-- White_Bread 1pt
}

function foodPoints(player, mob)
    for _, v in pairs(assaultFood) do
        if player:hasItem(v.item, tpz.inventoryLocation.TEMPITEMS) then
            mob:setLocalVar("foodEaten", mob:getLocalVar("foodEaten") + v.point)
            player:setLocalVar("foodGiven", 0)
            player:delItem(v.item, 1, tpz.inventoryLocation.TEMPITEMS)
            return v.point
        end
    end
    return 0
end

function onMobSpawn(mob)
    printf("2")
	mob:setStatus(tpz.status.NORMAL)
end

function onTrigger(player, mob)
	local instance = mob:getInstance()
	local points = foodPoints(player, mob)
	local MOB = instance:getEntity(bit.band(mob:getID(), 0xFFF), tpz.objType.MOB)

	if points > 0 then
		if mob:getLocalVar("foodEaten") >= 7 and mob:getLocalVar("complete") == 0 then
			instance:setProgress(instance:getProgress() + 1)
			mob:setLocalVar("complete", 1)
			player:showText(mob, ID.text.FULL_HUNGRY)
		elseif mob:getLocalVar("complete") == 1 then
			player:showText(mob, ID.text.FULL_FED)
		else
			player:showText(mob, ID.text.STILL_HUNGRY_FED)
		end
	else
		if mob:getLocalVar("foodEaten") >= 7 then
			player:showText(mob, ID.text.FULL_HUNGRY)
		else
			player:showText(mob, ID.text.STILL_HUNGRY_TRIGGER)
		end
	end
end

function onMobDeath(mob, player, isKiller, firstCall)
end