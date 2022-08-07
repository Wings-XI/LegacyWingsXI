-----------------------------------
-- Area: Halvung
--  ZNM: Reacton
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

local function getSwole(mob)
    -- disable/enable actions to avoid interrupting animation
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)

    mob:timer(1800, function(mob)
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
    end)

    -- increase size
    local size = mob:getLocalVar("currentSize") + 1
    mob:setLocalVar("currentSize", size)

    -- animate and apply attack boost
    mob:AnimationSub(size)
    mob:addMod(tpz.mod.ATTP, 33)

    -- apply new spell list based on size
    local listID = 0
    if size == 1 then
        listID = 447
    elseif size == 2 then
        listID = 448
    end
    mob:setSpellList(listID)

    -- return size so we can trigger self-destruct
    return size
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)

    -- fast attack speed and high defense
    mob:setMod(tpz.mod.DELAY, 1800)
    mob:setMod(tpz.mod.DMGPHYS, -33)
    mob:setMod(tpz.mod.DMGMAGIC, -33)

    -- immune to stun and immune or extremely resistant to Silence, as if
    mob:setMod(tpz.mod.SILENCERES, 95)
    mob:setMod(tpz.mod.STUNRES, 100)

    -- resist building
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 25)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 40)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 40)

    -- don't standback like your regular black mage mob
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
end

function onMobSpawn(mob)
    -- setting enrage timer anyways, in case of continuous wipes
    mob:setLocalVar("[rage]timer", 4500)

    -- phase change mechanics
    mob:setLocalVar("currentSize", 0)
    mob:setLocalVar("nextChange", 0)
    mob:setSpellList(0)
end

function onMobEngaged(mob, target)
    -- starting the phase change timer
    mob:setLocalVar("nextChange", os.time() + 45)
end

function onMobFight(mob, target)
    -- phase changes
    if utils.canUseAbility(mob) == true then
        local next = mob:getLocalVar("nextChange")
        if next > 0 and next < os.time() and mob:actionQueueEmpty() then
            if getSwole(mob) < 3 then
                mob:setLocalVar("nextChange", os.time() + 45)
            else
                -- time to go! self-destruct
                mob:setLocalVar("nextChange", 0)
                mob:useMobAbility(597)
            end
        end
    end
end

function onMobDisengage(mob)
    -- pause phase changes
    mob:setLocalVar("nextChange", 0)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    -- reset size
    mob:AnimationSub(0)
end