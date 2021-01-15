-----------------------------------
-- Area: Ghelsba Outpost
--   NM: Fodderchief Vokdek
-- Involved in Mission: Save the Children
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobDeath(mob, player, isKiller)
end


function onMobEngaged(mob, target)
	local vokdek = GetMobByID(17350662)
	local zodvad = GetMobByID(17350664)
	local snatgat = GetMobByID(17350663)
	
	zodvad:updateEnmity(target)
	snatgat:updateEnmity(target)

end