-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Media
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/settings")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobEngaged(mob)
    mob:setMod(tpz.mod.REGAIN, 200)
end

function onAdditionalEffect(mob, target, damage)
    local chance = 50
    if math.random() <= chance then
        local effect = target:dispelStatusEffect()
        if effect ~= tpz.effect.NONE then
            return tpz.subEffect.DISPEL, tpz.msg.basic.ADD_EFFECT_DISPEL, effect
        end
    end

    return 0, 0, 0
end

function onMobDisengage(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
end

function onMobDeath(mob, player, isKiller)
    if (isKiller) then
        SpawnMob(mob:getID() + 1):updateClaim(player)
    end
end

function onMobDespawn(mob)
    if (not GetMobByID(mob:getID() + 1):isSpawned()) then -- if this Media despawns and Grande is not alive, it would be because it despawned outside of being killed.
        GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME)
    end
end
