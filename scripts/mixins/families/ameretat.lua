--------------------------------
-- Ameretat (sub?)family mixin
--------------------------------
require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function getDistBetween(pos1, pos2)
    return math.sqrt((pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2 + (pos1.z - pos2.z) ^ 2)
end

g_mixins.families.ameretat = function(mob)
    -- set default to 17 HP Drain per hit, and a 50 HP Regen per tick.
    -- this can be overridden in onMobSpawn()
    mob:addListener("SPAWN", "AMERETAT_SPAWN", function(mob)
        mob:setLocalVar("HPDrainPotency", 17)
        mob:setLocalVar("RegenPotency", 50)
    end)

    mob:addListener("COMBAT_TICK", "AMERETAT_CTICK", function(mob, target)
        local ctCooldown = mob:getLocalVar("ctCooldown")
        if ctCooldown < os.time() then
            mob:setLocalVar("ctCooldown", os.time() + 1)

            -- determine distance from spawn and add/remove regen accordingly
            if getDistBetween(mob:getPos(), mob:getSpawnPos()) > 20 then
                mob:setMod(tpz.mod.REGEN, 0)
            else
                local potency = mob:getLocalVar("RegenPotency")
                mob:setMod(tpz.mod.REGEN, potency)
            end
        end
    end)

    mob:addListener("ATTACK", "AMERETAT_ATTACK", function(attacker, target, action)
        if attacker:getMod(tpz.mod.REGEN) == 0 then
            local playerID = target:getID()
            local potency = attacker:getLocalVar("HPDrainPotency")

            action:messageID(playerID, tpz.msg.basic.ADD_EFFECT_HP_DRAIN)
            action:additionalEffect(playerID, tpz.subEffect.HP_DRAIN)
            action:addEffectParam(playerID, potency)
        end
    end)
end

return g_mixins.families.ameretat