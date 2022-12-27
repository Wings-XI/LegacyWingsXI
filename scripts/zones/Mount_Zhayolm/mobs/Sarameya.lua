-----------------------------------
-- Area: Mount Zhayolm
--   NM: Sarameya
-- !pos 322 -14 -581 61
-- Spawned with Buffalo Corpse: !additem 2583
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Sarameya
-- TODO: PostAIRewrite: Code the Howl effect and gradual resists.
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
--[[Howl - Throughout the battle (but not during Chainspell), Sarameya will let out a Howl, then use Ululation, Firaga III and Magma Hoplon. It will then Howl again and ignore the target with enmity until they act on it again.

    At 25% or less HP, Sarameya will replace Firaga III with Gates of Hades.
    Sarameya becomes immune to Stun during a Howl sequence.]]
    -- howl = mob:useMobAbility(1892)
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 50)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function howlSequence(mob) 
    if mob:getHPP() <= 25
        mob:useMobAbility(1789) -- Magma Hoplon
        mob:castSpell(175) -- Firaga III
        mob:useMobAbility(1178) -- Ullulation
        mob:useMobAbility(1892) -- Howl
    else
        mob:useMobAbility(1789) -- Magma Hoplon
        mob:useMobAbility(1790) -- GoH
        mob:useMobAbility(1178) -- Ullulation
        mob:useMobAbility(1892) -- Howl
    end
end

function onMobSkillFinished(mob, target, skill)
    if skill:getID() == 1789 and mob:getLocalVar("Howl") == 1 then
        mob:setLocalVar("Howl", 0)
        mob:setMod(tpz.mod.STUNRES, 0)
    end
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.MEVA, 95)
    mob:addMod(tpz.mod.MDEF, 30)
    mob:addMod(tpz.mod.SILENCERES, 20)
    mob:addMod(tpz.mod.GRAVITYRES, 20)
    mob:addMod(tpz.mod.LULLABYRES, 30)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("Howl", 0)
end

function onMobRoam(mob) -- Randomly Howl
    if math.random() > .95 then
        mob:useMobAbility(1892)
    end
end

function onMobEngaged(mob, target)
    mob:setLocalVar("HowlTime", os.time() + math.random(60,180))
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local useChainspell = false

    if hpp < 90 and mob:getLocalVar("chainspell89") == 0 then
        mob:setLocalVar("chainspell89", 1)
        useChainspell = true
    elseif hpp < 70 and mob:getLocalVar("chainspell69") == 0 then
        mob:setLocalVar("chainspell69", 1)
        useChainspell = true
    elseif hpp < 50 and mob:getLocalVar("chainspell49") == 0 then
        mob:setLocalVar("chainspell49", 1)
        useChainspell = true
    elseif hpp < 30 and mob:getLocalVar("chainspell29") == 0 then
        mob:setLocalVar("chainspell29", 1)
        useChainspell = true
    elseif hpp < 10 and mob:getLocalVar("chainspell9") == 0 then
        mob:setLocalVar("chainspell9", 1)
        useChainspell = true
    end

    if useChainspell then
        mob:useMobAbility(692) -- Chainspell
        mob:setMobMod(tpz.mobMod.GA_CHANCE, 100)
    end

    -- Spams TP moves and -ga spells
    if mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
        mob:setTP(2000)
    else -- No Chainspell
        if mob:getMobMod(tpz.mobMod.GA_CHANCE) == 100 then
            mob:setMobMod(tpz.mobMod.GA_CHANCE, 50)
        end

        if os.time() >= mob:getLocalVar("HowlTime") and mob:getLocalVar("Howl") == 0 then -- Check to see if its time to do Howl Sequence
            mob:setLocalVar("Howl", 1)
            howlSequence(mob)
            mob:setMod(tpz.mod.STUNRES, 100)
        end
    end



    -- Regens 1% of his HP a tick with Blaze Spikes on
    if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) then
        mob:setMod(tpz.mod.REGEN, math.floor(mob:getMaxHP()/100))
    else
        if mob:getMod(tpz.mod.REGEN) > 0 then
            mob:setMod(tpz.mod.REGEN, 0)
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {chance = 40, power = 50})
end

function onMobDeath(mob, player, isKiller)
end
