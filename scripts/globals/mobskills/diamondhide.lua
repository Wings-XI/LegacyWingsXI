---------------------------------------------
-- Diamondhide
--
-- Description: Gives the effect of "Stoneskin."
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:hasStatusEffect(tpz.effect.STONESKIN) then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local power = 600 -- Guesstimated, def not based on mobs lv+hp*tp like was previously in this script..
    skill:setMsg(MobBuffMove(target, tpz.effect.STONESKIN, power, 0, 300))
    return tpz.effect.STONESKIN
end
