-----------------------------------
-- Area: Balga's Dais
--  Mob: Macan Gadangan
--  Wild Wild Whiskers BCNM60
-----------------------------------

function onMobWeaponSkillPrepare(mob, target)
	local petbreath = 480
	if math.random() < 0.72 then -- heavily prefers petrifactive_breath
		return petbreath
	else
		return 0
	end
	
end