-----------------------------------
-- Area: Misareaux Coast
--   NM: Gration
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    local shield = GetNPCByID(16879918):getLocalVar("shield")
    if shield == 2 then
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
    end
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setMod(tpz.mod.FASTCAST, 25)
    mob:setMod(tpz.mod.RESBUILD_BIND,5)    -- "Gradually builds resistance to Gravity and Bind. Completely immune to bind from RDM after 16 casts"
    mob:setMod(tpz.mod.RESBUILD_GRAVITY,5)
    mob:setMod(tpz.mod.STUNRES, 100) -- Immune to stun
    mob:setLocalVar("fomorHateDecrease", 1)
    mob:setLocalVar("fomorHateAdj", 2)
    mob:setMod(tpz.mod.MATT, 125)
    mob:setMod(tpz.mod.ATT, 550)
end

function onMobFight(mob, target)
    local nearbyPlayers = mob:getPlayersInRange(20)
    if nearbyPlayers == nil then return end
    for _,v in ipairs(nearbyPlayers) do
        local shouldintimidate = math.random(1, 20)
        if shouldintimidate >= 19 then
            if v:hasStatusEffect(tpz.effect.INTIMIDATE) == true then
                v:delStatusEffectSilent(tpz.effect.INTIMIDATE)
            end
            v:addStatusEffectEx(tpz.effect.INTIMIDATE, 0, 1, 0, 1)
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
    local random = math.random(1,2) -- Gration only uses Power Attack or Grand Slam
    if random == 1 then
        return 667 -- Power Attack
    else
        return 665 -- Grand Slam 
    end
end

function onMobWeaponSkill(target, mob, skill)    
    local shield = GetNPCByID(16879918):getLocalVar("shield")
    if skill:getID() == 667 then
        local powerattackCounter = mob:getLocalVar("powerattackCounter")

        powerattackCounter = powerattackCounter +1
        mob:setLocalVar("powerattackCounter", powerattackCounter)

        if powerattackCounter > 1 and shield == 1 then
            mob:setLocalVar("powerattackCounter", 0)
        elseif powerattackCounter > 2 and shield == 2 then
            mob:setLocalVar("powerattackCounter", 0)    
        else
            mob:useMobAbility(667)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
