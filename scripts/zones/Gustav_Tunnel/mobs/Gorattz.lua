-----------------------------------
-- Area: Gustav Tunnel (212)
--  Mob: Gorattz
--  Involved in Mission: Enemy of the Empire (II) - A Shantotto Ascension
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setAllegiance(1)
    mob:setPos(-137.862, -10.443, -192.018, 192)
    mob:setLocalVar("UtsuSpam", 4)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:SetMobAbilityEnabled(false)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(true)
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
end

function onMobFight(mob, target)
    local shouldUtsu = mob:getLocalVar("UtsuSpam")

    if shouldUtsu > 0 then
        mob:castSpell(339)
        mob:setLocalVar("UtsuSpam", shouldUtsu - 1)
    end
end

function onMobDeath(mob, player, isKiller)
    -- if mob:getID() == 17645814 then
    --     mob:showText(ID.text.ASA_GORATTZ_DEATH)
    -- else
    --     for _, member in pairs(player:getParty()) do
    --         member:messageSpecial(ID.text.ASA_SHADOW_DEATH, 1)
    --     end
    -- end
end
