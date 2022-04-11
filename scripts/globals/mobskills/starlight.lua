---------------------------------------------
-- Starlight
--
-- Description: Restores MP (self).
-- Type: Physical
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local mpRecoverAmt = mob:getWeaponDmg() *1.75
    local maxmp = target:getMaxMP()
    local currmp = target:getMP()
    if ( mpRecoverAmt + currmp > maxmp ) then
            mpRecoverAmt = maxmp - currmp
        end
    skill:setMsg(tpz.msg.basic.RECOVERS_MP, 0, mpRecoverAmt)
end
