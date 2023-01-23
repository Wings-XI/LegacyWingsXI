-----------------------------------
-- Area: Mount Zhayolm
--   NM: Sarameya
-- !pos 322 -14 -581 61
-- Spawned with Buffalo Corpse: !additembyid 2583
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Sarameya
-- TODO: PostAIRewrite: Code the Howl effect and gradual resists.
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
--[[
    Howl looks good, but one thing might need tweaking at the end?
     -- It will then Howl again and ignore the target with enmity until they act on it again.
    note that howl was being wonky queuing up skills and spells, so i extended the logic to add a 5s delay between each

    alliance hate? should Tyger have it as well since other 2 do?
]]
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 50)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(tpz.mod.UDMGBREATH, -20)
    mob:setMod(tpz.mod.UDMGMAGIC, -20)
    mob:setMod(tpz.mod.SILENCERES, 100)
end

function howlSequence(mob)
    local howlNum = mob:getLocalVar("Howl")
    mob:setLocalVar("HowlTime", os.time() + 5)

    if howlNum > 0 then
        -- howl sequence
        if howlNum == 1 then
            mob:setMod(tpz.mod.STUNRES, 100)
            mob:SetAutoAttackEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:SetMagicCastingEnabled(false)

            mob:useMobAbility(1892) -- Howl
            mob:setLocalVar("Howl", howlNum + 1)
        elseif howlNum == 2 then
            mob:useMobAbility(1788) -- Ullulation
            mob:setLocalVar("Howl", howlNum + 1)
        elseif howlNum == 3 then
            if mob:getHPP() > 25 then
                -- can also not do this and just idle during this 5s period
                local mp = mob:getMP()
                if mp < 300 then
                    mob:addMP(300 - mp)
                end
                mob:castSpell(176) -- Firaga III
            else
                mob:useMobAbility(1790) -- GoH
            end
            mob:setLocalVar("Howl", howlNum + 1)
        elseif howlNum == 4 then
            mob:useMobAbility(1789) -- Magma Hoplon
            mob:setLocalVar("Howl", howlNum + 1)
        else
            mob:useMobAbility(1892) -- Howl
        end
    end
end

function onMobSkillFinished(mob, target, skill)
    if skill:getID() == 1892 and mob:getLocalVar("Howl") == 5 then
        mob:setLocalVar("Howl", 0)
        mob:setLocalVar("HowlTime", os.time() + math.random(60,180))
        mob:setMod(tpz.mod.STUNRES, 0)
        -- maybe don't set these until he's acted on again?
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:SetMagicCastingEnabled(true)
    end
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.MEVA, 95)
    mob:setMod(tpz.mod.MDEF, 30)
    mob:setMod(tpz.mod.SILENCERES, 20)
    mob:setMod(tpz.mod.GRAVITYRES, 20)
    mob:setMod(tpz.mod.LULLABYRES, 30)
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

function onMobDisengage(mob)
    mob:setAggressive(0)
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local useChainspell = false
    local howlNum = mob:getLocalVar("Howl")

    if howlNum > 0 then
        if os.time() >= mob:getLocalVar("HowlTime") and mob:actionQueueEmpty() then
            howlSequence(mob)
        end
    else
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
            end
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
