-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'aern MNK
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.DEF, 550)
    mob:setMod(tpz.mod.DMGMAGIC, 65)

    -- adjust drops based on number of HQ Aern Organs traded to QM
    local qm = GetNPCByID(ID.npc.IXAERN_MNK_QM)
    local chance = qm:getLocalVar("[SEA]IxAern_DropRate")
    if (math.random(0, 1) > 0) then
        SetDropRate(4398, 1851, chance * 10) -- Deed Of Placidity
        SetDropRate(4398, 1901, 0)
    else
        SetDropRate(4398, 1851, 0)
        SetDropRate(4398, 1901, chance * 10) -- Vice of Antipathy
    end
    qm:setLocalVar("[SEA]IxAern_DropRate", 0)

    mob:AnimationSub(1) -- Reset the subanim - otherwise it will respawn with bracers on. Note that Aerns are never actually supposed to be in subanim 0.
    mob:setLocalVar("BracerMode", 0)
    mob:setLocalVar("canTwoHour", 1)
    mob:setLocalVar("canBracer", 1)
end

function onMobEngaged(mob, target)
    for i = 1, 2 do -- pets reaggro if attacked from completely idle
        local minion = GetMobByID(mob:getID() + i)
        minion:updateEnmity(target)
    end
end

function onMobFight(mob, target)
    -- The mob gains a huge boost when it 2hours to attack speed and attack.
    -- It forces the minions to 2hour as well. Wiki says 50% but all videos show 60%.

    if mob:getHPP() < 50 or GetMobByID(16916816):getHPP() < 50 or GetMobByID(16916817):getHPP() < 50 then -- If any of the three mobs gets below 50% then all three gain bracelets
        mob:setLocalVar("BracerMode", 1)
        mob:setLocalVar("delay", mob:getBattleTime())
    end

    if mob:getHPP() < math.random(50, 60) and mob:getLocalVar("canTwoHour") == 1 then  --Syncing mobs to two hour if ix'mnk two hours
        mob:setLocalVar("delay", mob:getBattleTime()) -- setting delay so mob can't two hour and add bracers effect at same time
        mob:useMobAbility(690) -- Hundred Fists
        -- Force minions to 2hour
        mob:setLocalVar("canTwoHour", 0)
        for i = 1, 2 do
            local minion = GetMobByID(mob:getID() + i)

            local abil = 0

            if i == 1 then
                abil = 0
            else
                abil = -3
            end

            if (minion:getCurrentAction() ~= tpz.act.NONE) then
                if minion:isSpawned() then
                    minion:useMobAbility(692 + abil) -- Chainspell or Benediction
                end
            end
        end
    end

    if (mob:getLocalVar("BracerMode") == 1) then --Go into bracer mode
        if mob:getLocalVar("canBracer") == 1 then
            mob:AnimationSub(2)
            mob:addMod(tpz.mod.ATT, 200)

            if not mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) and (mob:getBattleTime() - mob:getLocalVar("delay") > 3) then
                mob:setMod(tpz.mod.DELAY, 1700)
            end

            local mobID = mob:getID()
            for i = mobID+1, mobID+2 do
                local m = GetMobByID(i)
                if m:isSpawned() then
                    m:AnimationSub(2)
                    m:addMod(tpz.mod.ATT, 200)
                    m:setMod(tpz.mod.DELAY, 2100)
                end
            end
            mob:setLocalVar("canBracer", 0)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    local mobID = mob:getID()
    for i = mobID+1, mobID+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end
end

function onMobDespawn(mob)
    local mobID = mob:getID()
    for i = mobID+1, mobID+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    local qm = GetNPCByID(ID.npc.IXAERN_MNK_QM)
    if (math.random(0, 1) == 1) then
        qm:setPos(380, 0, 540, 0) -- G-7
    else
        qm:setPos(460, 0, 540, 0) -- I-7
    end
    qm:updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME)
end