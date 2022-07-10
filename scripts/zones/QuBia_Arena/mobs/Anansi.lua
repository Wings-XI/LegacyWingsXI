-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Anansi
-- BCNM: Come Into My Parlor
-----------------------------------

local function SpawnSon(mob)
    local baseID = mob:getID()
    local offset = mob:getLocalVar("sonOffset")
    local sonID = baseID + offset + 1
    local son = GetMobByID(sonID)

    -- "enable" son (already spawned but invisible)
    son:setPos(mob:getXPos() + math.random(-2, 2) * 0.5, mob:getYPos(), mob:getZPos() + math.random(-2, 2) * 0.5)
    son:setMobMod(tpz.mobMod.NO_AGGRO, 0)
    son:setMobMod(tpz.mobMod.NO_LINK, 0)
    son:setMobMod(tpz.mobMod.NO_MOVE, 0)
    son:untargetable(false)
    son:setStatus(tpz.status.UPDATE)
    son:stun(500)

    -- look for a target, build a list of potential target in the bcnm
    local targets = {}
    for _, player in pairs(mob:getBattlefield():getPlayers()) do
        -- will aggro anyone in the bcnm that's not sneaked regardless of distance
        if player:getZoneID() == mob:getZoneID() and player:isAlive() and not player:hasStatusEffect(tpz.effect.SNEAK) then
            table.insert(targets, player)
        end
    end

    -- introduce some chaos (pick a random target)
    if #targets > 0 then
        local target = targets[math.random(#targets)]
        son:updateEnmity(target)
    end

    -- recursively spawn
    if offset < 8 then
        mob:setLocalVar("sonOffset", offset + 1)
        mob:timer(math.random(1, 3) * 500, function(mob)
            SpawnSon(mob)
        end)
    end
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 25)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    -- keep track of the adds we're going to pop later
    mob:setLocalVar("sonOffset", 1)

    -- will be enabling the sons upon death
    mob:addListener("DEATH", "ANANSI_DEATH", function(mob, killer)
        mob:removeListener("ANANSI_DEATH")
        mob:timer(5000, function(mob) SpawnSon(mob) end)
    end)
end

function onAdditionalEffect(mob, target, damage)
    -- 25% chances to poison for 60 seconds at 50 per tick
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, { power = 50, duration = 60, chance = 25 })
end

function onMobDeath(mob, killer)
end