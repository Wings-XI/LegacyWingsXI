-----------------------------------
-- Area: Arrapago Reef
--   NM: Merrow No. 5
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.STUNRES, 100)
    mob:setMod(tpz.mod.SILENCERES, 100)
end

function onMobSpawn(mob)
    mob:setLocalVar("TwoHour", 0)
end

function onAdditionalEffect(mob, target, damage)
end

function onMobDeath(mob, player, isKiller)
end

function onMonsterMagicPrepare(mob, target)
    -- ffxi wiki:
    -- paeon can be used only when <15% HP
    if mob:getHPP() < 15 and math.random() < 0.1 then
        return 382 -- Army's Paeon V
    end

    -- ffo wiki: 
    -- It is worth mentioning that "Virley of the Maiden", which is considered to be
    -- the most mysterious song among the curse songs, is repeated with a high probability.
    local rand = math.random()
    if rand < 0.4 then 
        return 466 -- Maiden's Virelai
    elseif rand < 0.48 then
        return 422 -- Carnage Elegy
    elseif rand < 0.56 then
        return 373 -- Foe Requiem VI
    elseif rand < 0.64 then
        return 376 -- Horde Lullaby
    elseif rand < 0.72 then
        return 392 -- Knight's Minne IV
    elseif rand < 0.80 then
        return 397 -- Valor Minuet IV
    elseif rand < 0.88 then
        return 420 -- Victory March
    elseif rand < 0.92 then
        return  432 -- Uncanny Etude
    elseif rand < 0.96 then
        return 434 -- Swift Etude
    else
        return 442 -- Lightning Carol
    end 
end

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.SOUL_VOICE) == false and mob:actionQueueEmpty() == true then
        local twoHour = mob:getLocalVar("twoHour")
        local battleTime = mob:getBattleTime()
        if twoHour == 0 and battleTime % 10 == 0 then
            local rand = math.random()
            if rand < 0.3 then
                mob:setLocalVar("twoHour", 1)
                mob:useMobAbility(696)
            end
        end
    elseif mob:hasStatusEffect(tpz.effect.SOUL_VOICE) == true then
        mob:setLocalVar("twoHour", 0)
    end
end

function onMobDespawn(mob)
    local respawn = math.random(172800, 259200)
    mob:setRespawnTime(respawn) -- 48-72 hours
    SetServerVariable("Merrow_No5_Respawn", (os.time() + respawn))
end
