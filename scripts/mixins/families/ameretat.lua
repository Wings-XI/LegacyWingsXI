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

    mob:addListener("ENGAGE", "AMERETAT_ENGAGE", function(mob)
        if mob:getLocalVar("HPDrainEnabled") == 0 then
            mob:addMod(tpz.mod.REGEN, mob:getLocalVar("RegenPotency"))
        end
    end)

    mob:addListener("DISENGAGE", "AMERETAT_DISENGAGE", function(mob)
        if mob:getLocalVar("HPDrainEnabled") == 0 then
            mob:delMod(tpz.mod.REGEN, mob:getLocalVar("RegenPotency"))
        end
    end)

    mob:addListener("COMBAT_TICK", "AMERETAT_CTICK", function(mob, target)
        local ctCooldown = mob:getLocalVar("ctCooldown")
        if ctCooldown < os.time() then
            mob:setLocalVar("ctCooldown", os.time() + 1)

            -- determine distance and current status to toggle between endrain/regen
            local dist = getDistBetween(mob:getPos(), mob:getSpawnPos())
            local drainEnabled = mob:getLocalVar("HPDrainEnabled")
            local potency = mob:getLocalVar("RegenPotency")

            if dist >= 20 and drainEnabled == 0 then
                mob:setLocalVar("HPDrainEnabled", 1)
                mob:delMod(tpz.mod.REGEN, potency)
            elseif dist < 20 and drainEnabled == 1 then
                mob:setLocalVar("HPDrainEnabled", 0)
                mob:addMod(tpz.mod.REGEN, potency)
            end
        end
    end)

    mob:addListener("ATTACK", "AMERETAT_ATTACK", function(attacker, target, action)
        if attacker:getLocalVar("HPDrainEnabled") > 0 then
            local playerID = target:getID()
            local potency = attacker:getLocalVar("HPDrainPotency")

            action:messageID(playerID, tpz.msg.basic.ADD_EFFECT_HP_DRAIN)
            action:additionalEffect(playerID, tpz.subEffect.HP_DRAIN)
            action:addEffectParam(playerID, potency)
        end
    end)
end

return g_mixins.families.ameretat