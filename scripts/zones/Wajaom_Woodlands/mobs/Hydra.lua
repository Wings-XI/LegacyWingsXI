-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Hydra
-- !pos -282 -24 -1 51
-----------------------------------
require("scripts/globals/titles")
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
-----------------------------------

local drawInPos =
{
    {-280.20, -23.88,  -5.94},
    {-272.08, -23.75,  -1.73},
    {-276.90, -24.00,   2.09},
    {-268.59, -23.96, -16.00},
    {-285.57, -24.20,  -0.56},
    {-282.16, -24.00,   1.95},
    {-271.35, -23.66,  -5.46},
    {-272.75, -23.55, -11.25},
}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setMod(tpz.mod.DEF, 450)
    mob:setMod(tpz.mod.ATT, 350)
    mob:setMod(tpz.mod.PIERCERES, 250) -- 25% piercing resistance
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.MEVA, 400)
    mob:setMod(tpz.mod.WATERDEF, 200)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.FIREDEF, 200)
end

function onMobRoam(mob)
    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar("headgrow")
    local broken = mob:AnimationSub()

    if (headgrow < battletime and broken > 0) then
        mob:AnimationSub(broken - 1)
    end
end

function onMobFight(mob, target)

    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar("headgrow")
    local broken = mob:AnimationSub()
    local headthreshold = mob:getLocalVar("headthreshold")

    if (headgrow < battletime and broken > 0) then
        mob:AnimationSub(broken - 1)
        mob:setLocalVar("headgrow", battletime + math.random(60, 120))
        mob:setTP(3000)
    end

    if broken == 0 then
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMod(tpz.mod.REGEN, 165) -- 1% per 14s
    elseif broken == 1 then
        mob:setMod(tpz.mod.REGAIN, 90)
        mob:setMod(tpz.mod.REGEN, 70) -- 1% per 33s
    elseif broken == 2 then
        mob:setMod(tpz.mod.REGAIN, 80)
        mob:setMod(tpz.mod.REGEN, 10) -- 1% per 240s
    end

    if mob:getHPP() == 100 then
        mob:setLocalVar("headthreshold", 0)
    elseif mob:getHPP() < 75 and headthreshold == 0 then
        mob:setLocalVar("headgrow", headgrow - 240)
        mob:setLocalVar("headthreshold", 1)
    elseif mob:getHPP() < 50 and headthreshold == 1 then
        mob:setLocalVar("headgrow", headgrow - math.random(150, 180))
        mob:setLocalVar("headthreshold", 2)
    elseif mob:getHPP() < 25 and headthreshold == 2 then
        mob:setLocalVar("headgrow", headgrow - math.random(50, 90))
        mob:setLocalVar("headthreshold", 3)
    end

    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() < -295 or target:getXPos() > -260) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getZPos() < -25 or target:getZPos() > 13) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

function onMobDrawIn(mob, target)
    mob:setTP(3000)
end

function onCriticalHit(mob)

    local rand = math.random()
    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar("headgrow")
    local broken = mob:AnimationSub()

    if mob:getHPP() > 75 then
        if (rand <= 0.15 and broken < 2) then
            mob:AnimationSub(broken + 1)
            mob:setLocalVar("headgrow", battletime + math.random(480, 600))
        end
    elseif mob:getHPP() > 50 then
        if (rand <= 0.1 and broken < 2) then
            mob:AnimationSub(broken + 1)
            mob:setLocalVar("headgrow", battletime + math.random(240, 360))
        end
    elseif mob:getHPP() > 25 then
        if (rand <= 0.1 and broken < 2) then
            mob:AnimationSub(broken + 1)
            mob:setLocalVar("headgrow", battletime + math.random(90, 180))
        end
    elseif mob:getHPP() < 25 then
        if (rand <= 0.1 and broken < 2) then
            mob:AnimationSub(broken + 1)
            mob:setLocalVar("headgrow", battletime + math.random(40, 90))
        end
    end

end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.HYDRA_HEADHUNTER)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(48,72)*3600 -- 48 to 72 hours in 60min windows
    mob:setRespawnTime(respawn)
	SetServerVariable("HydraRespawn",(os.time() + respawn))
end

