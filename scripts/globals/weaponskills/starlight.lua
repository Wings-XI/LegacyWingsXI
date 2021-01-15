------------------------
--      Starlight     --
------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(11) -- get club skill
    local damage = lvl/9
    local damagemod = damage * (1+(tp/1000))
	player:trySkillUp(target, tpz.skill.CLUB, 1)
    return 1, 0, false, damagemod
end
