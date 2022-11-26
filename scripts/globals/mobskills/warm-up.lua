---------------------------------------------
-- Warm-Up
--
-- Description: Enhances accuracy and evasion.
-- mamool ja fight get the acc bonus and mamool ja mage get the eva bonus
-- Type: Magical (Earth)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getID() == 16986430 then
        if mob:getLocalVar("WarmUp") == 1 then
            return 1
        else
            return 0
        end   
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local power = 40 -- from ffxiclopedia/bg-wiki
    local mobSkin = mob:getModelId()

    if mob:getID() == 16986430 then
        mob:setLocalVar("WarmUp", 1)
    end

    if mobSkin == 1618 then
        skill:setMsg(MobBuffMove(mob, tpz.effect.ACCURACY_BOOST, power, 0, 90))
        return tpz.effect.ACCURACY_BOOST
    else
        skill:setMsg(MobBuffMove(mob, tpz.effect.EVASION_BOOST, power, 0, 90))
        return tpz.effect.EVASION_BOOST
    end
end
