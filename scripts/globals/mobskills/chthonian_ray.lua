---------------------------------------------
-- Chthonian Ray
-- Only used by Eldertaur
-- Description: Inflicts Doom to enemies within a fan-shaped area originating from the caster..
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/settings")
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DOOM
    local battlefield = mob:getBattlefield()
    local players = battlefield:getPlayers()

    for _, player in pairs(players) do
        if (target:isFacing(mob)) then
            player:addStatusEffect(typeEffect, 10, 3, 15)
        end
    end

    return typeEffect
end
