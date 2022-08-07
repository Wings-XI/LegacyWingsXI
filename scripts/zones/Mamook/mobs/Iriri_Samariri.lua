-----------------------------------
-- Area: Mamook
--   NM: Iriri Samariri (T2 ZNM)
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UFASTCAST, 75) -- Appears to have 75% FC from capture.
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20) -- Sets recast time in line with capture.
    mob:setLocalVar("CheerCounter", 0)
end

function onMobWeaponSkillPrepare(mob, target)
    local CheerCounter = mob:getLocalVar("CheerCounter") -- controls frog cheer
    if mob:getHPP() <= 50 and math.random(1,5) <= 4 and CheerCounter == 0 then   -- Weighted to favor cheer under 50%
        return 1960
    elseif mob:getHPP() <= 30 and math.random(1,5) <= 2 then
        return 1962 --- Includes Frog Chorus to possible skills. 
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local r = mob:getRotPos()

    for i = mobId + 1, mobId + 4 do
        local pet = GetMobByID(i) 
        if skill:getID() == 1960 then -- (Frog Cheer)
            pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2), r)
            pet:spawn()
            mob:setLocalVar("CheerCounter", 1)
        end
    end
end

function onMobFight( mob, target )
    local mobId = mob:getID()
    -- make sure minions have a target
    for i = mobId + 1, mobId + 4 do
        local pet = GetMobByID(i)
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobDisengage(mob)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        DespawnMob(i)
        mob:setLocalVar("CheerCounter", 0)
    end
end

function onMobDespawn( mob )
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        DespawnMob(i)
        mob:setLocalVar("CheerCounter", 0)
    end
end

function onMobDeath(mob, player, isKiller)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        DespawnMob(i)
        mob:setLocalVar("CheerCounter", 0)
    end
end
