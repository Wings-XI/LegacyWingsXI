-----------------------------------
-- Area: Qu'Bia Arena (Those Who Lurk in Shadows (III))
--  Mob: Seed Goblin
-----------------------------------

local ID = require("scripts/zones/QuBia_Arena/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.LULLABYRES, 80)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("skillReady", 1)
end

function onMobFight(mob, target)
    if mob:getLocalVar("skillReady") == 1 then
        mob:setLocalVar("skillReady", 0)

        -- Move goblin behind a random party member and WS every 25-35 seconds
        mob:timer(math.random(25000, 35000), function(mob)
            local target = mob:getTarget()

            if target ~= nil then
                local party = target:getParty()
                if party ~= nil then
                    newTarget = party[math.random(#party)]
                    if newTarget:getZoneID() == target:getZoneID() and newTarget:isAlive() and mob:checkDistance(newTarget) < 50 then
                        target = newTarget
                    end
                end

                mob:SetAutoAttackEnabled(false)
                mob:setStatus(tpz.status.INVISIBLE)
                mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                --mob:addStatusEffect(tpz.effect.SNEAK_ATTACK, 1, 0, 10)

                mob:timer(1000, function(mob)
                    local pos = target:getPos()
                    local posX = pos.x
                    local posZ = pos.z
                    local posRot = pos.rot

                    local radians = (256 - posRot) * (math.pi / 128)
                    posX = posX - (2 * math.cos(radians))
                    posZ = posZ - (2 * math.sin(radians))

                    mob:setPos(posX, pos.y, posZ, posRot)
                    mob:SetAutoAttackEnabled(true)
                    mob:setStatus(tpz.status.UPDATE)
                    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
                    
                    mob:useMobAbility(({590, 591, 2414})[math.random(1, 3)], target)
                end)
                mob:setLocalVar("skillReady", 1)
            end
        end)
    end
end

function onMobDeath(mob, player, isKiller)
end
