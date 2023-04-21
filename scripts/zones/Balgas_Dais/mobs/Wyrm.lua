-----------------------------------
-- Area: Balga's Dais
-- Mob: Wyrm
-- KSNM: Early Bird Catches the Wyrm
-- For future reference: Trusts are not allowed in this fight 
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/families/wyrm_wakeup")}
-----------------------------------
local function grounded(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setBehaviour(1024)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.MDEF, 20)
    mob:addMod(tpz.mod.DEFP, 20)
    mob:addMod(tpz.mod.ATTP, 10)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_IGNORE_STATIONARY, 1)
    mob:setTP(3000) -- opens fight with a skill
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:AnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
    mob:setLocalVar("state", 0)
    grounded(mob)
    -- cleanup if mob wasn't killed from previous run and was below 33%
    mob:delStatusEffectSilent(tpz.effect.EVASION_BOOST)
    mob:delStatusEffectSilent(tpz.effect.DEFENSE_BOOST)
    mob:delStatusEffectSilent(tpz.effect.MAGIC_DEF_BOOST)
end

function onMobEngaged(mob, target)
    mob:setMod(tpz.mod.REGAIN, 100) -- very close to the capture by comparing stop watch measures
    mob:setMod(tpz.mod.REGEN, 50) -- might be higher: capture showed no change in HP with Poison II and Bio III procced
end

function onMobFight(mob, target)
    local state = mob:getLocalVar("state")

    if state == 1 then  
        local spawn = mob:getSpawnPos()
        local current = mob:getPos()
        local diffX = spawn.x - current.x 
        local diffY = spawn.y - current.y 
        local diffZ = spawn.z - current.z   

        local distance = math.sqrt(math.pow(diffX, 2) + math.pow(diffY, 2) + math.pow(diffZ, 2))
        if distance < 0.2 then
            mob:setLocalVar("state", 2) -- fly state
            mob:setBehaviour(0)
            mob:AnimationSub(1)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(1159)
        else
            mob:pathTo(spawn.x , spawn.y, spawn.z)
        end
    elseif state == 2 then
        mob:lookAt(target:getPos()) 
    end

    if mob:actionQueueEmpty() then
        -- Fly @ 66%
        if (mob:AnimationSub() == 0 and mob:getHPP() <= 66 and state == 0) then
            local spawn = mob:getSpawnPos()
            mob:pathTo(spawn.x , spawn.y, spawn.z)
            mob:setLocalVar("state", 1) -- moving to spawn

        -- Land @ 33%    
        elseif mob:AnimationSub() == 1 and mob:getHPP() <= 33 and state == 2 then
            mob:setLocalVar("state", 3) -- final state
            mob:useMobAbility(954)
            grounded(mob)
            mob:addStatusEffect(tpz.effect.EVASION_BOOST, 50, 0, 0)
            mob:addStatusEffect(tpz.effect.DEFENSE_BOOST, 50, 0, 0)
            mob:addStatusEffect(tpz.effect.MAGIC_DEF_BOOST, 40, 0, 0)
        end
    end
end

function onMobDeath(mob, player, isKiller)

end