-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/status")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DEF, 400)
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    mob:useMobAbility(626) -- 2hr animation since wynavs aren't spawned via CallWyvern Ability
    for i = ID.mob.WYNAV_START, ID.mob.WYNAV_END do
        local wynav = GetMobByID(i)
        wynav:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
        wynav:spawn()
    end
end

function onMobEngaged(mob, target)
    mob:setLocalVar("changeTime", 0)
    for i = ID.mob.WYNAV_START, ID.mob.WYNAV_END do -- Wynavs share hate with Ix'DRG
        GetMobByID(i):updateEnmity(target)
    end
end

function onMobFight(mob, target)

    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    for i = ID.mob.WYNAV_START, ID.mob.WYNAV_END do
        local wynav = GetMobByID(i)
        if not wynav:isSpawned() and utils.canUseAbility(mob) == true then
            local repopWynavs = wynav:getLocalVar("repop") -- see Wynav script
            if mob:getBattleTime() - repopWynavs > 10 then
                wynav:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
                mob:useMobAbility(626) -- 2hr animation since wynavs aren't spawned via CallWyvern Ability
                wynav:spawn()
                wynav:updateEnmity(target)
            end
        end
    end

    local changeTime = mob:getLocalVar("changeTime")
    local battleTime = mob:getBattleTime()
    if mob:AnimationSub() <= 1 and (battleTime - changeTime > 60) then -- goes into bracer mode for 30 seconds, every 60 seconds.
        mob:AnimationSub(2) -- bracer mode
        mob:setMod(tpz.mod.DELAY, 1000) -- increase speed in bracer mode
        mob:addMod(tpz.mod.ATTP, 25)
        mob:setLocalVar("changeTime", battleTime)
    elseif mob:AnimationSub() == 2 and (battleTime - changeTime > 30) then
        mob:AnimationSub(1)
        mob:setMod(tpz.mod.DELAY, 0) -- back to normal attack speed
        mob:delMod(tpz.mod.ATTP, 25)
        mob:setLocalVar("changeTime", battleTime)
    end

end

function onMobWeaponSkill(target, mob, skill)
    local skill = skill:getID()
    local breaths = { 900, 901, 902, 903, 904 }
    local randBreath = (breaths[math.random(#breaths)])
    if (skill >= 1378 and skill <= 1382) or skill == 1386 then
        for i = ID.mob.WYNAV_START, ID.mob.WYNAV_END do
            local pet = GetMobByID(i)
            if pet:isAlive() and pet:checkDistance(pet:getTarget()) <= 7 and utils.canUseAbility(pet) == true then
                pet:useMobAbility(randBreath) -- Wynavs will use breath attacks whenever Ix'DRG uses a weaponskill.
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
    -- despawn pets
    local mobId = mob:getID()
    for i = ID.mob.WYNAV_START, ID.mob.WYNAV_END do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

function onMobDespawn(mob)
    -- despawn pets
    local mobId = mob:getID()
    for i = ID.mob.WYNAV_START, ID.mob.WYNAV_END do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end

    -- Pick a new PH for Ix'Aern (DRG)
    local groups = ID.mob.AWAERN_DRG_GROUPS
    SetServerVariable("[SEA]IxAernDRG_PH", groups[math.random(1, #groups)] + math.random(0, 2))
end
