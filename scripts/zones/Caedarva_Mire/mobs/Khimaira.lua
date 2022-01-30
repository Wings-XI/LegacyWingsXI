-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/toau")
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------

local drawInPos =
{
    {838.88,  0.00, 358.86},
    {834.93, -0.14, 363.68},
    {840.13, -0.31, 366.46},
    {842.69,  0.00, 360.12},
    {846.15, -0.27, 360.25},
    {845.30, -0.51, 366.68},
    {850.33, -1.34, 365.43},
    {850.40, -1.45, 355.85},
}

function onMobInitialize(mob)
    tpz.toau.mobSpecialHook("KHIMAIRA", mob, 1, function(mob)
        if mob:AnimationSub() == 0 then
            mob:AnimationSub(1)
        end
    end)

    mob:addListener("EFFECT_LOSE", "KHIMAIRA_EFFECT_LOSE", function(owner, effect)
        local effectType = effect:getType()
        if effectType == tpz.effect.STUN then
            owner:addMod(tpz.mod.STUNRES, 5)
        end
    end)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.MDEF, 100) -- 385 * 1.32/2 = 254 nether blast
    mob:setMod(tpz.mod.STATUSRES, 50)
    mob:setMod(tpz.mod.PARALYZERES, 50)
    mob:setMod(tpz.mod.STUNRES, -75)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:AnimationSub(0)
end

function onMobFight(mob, target)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() < 814 or target:getXPos() > 865) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getZPos() < 345 or target:getZPos() > 377) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

function onMobEngaged(mob, target)
    if mob:getHPP() == 100 then
        mob:setMod(tpz.mod.STUNRES, -75)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.KHIMAIRA_CARVER)
end

function onMobDespawn(mob)
    local respawn = math.random(48,72)*3600 -- 48 to 72 hours in 60min windows
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(respawn)
	SetServerVariable("KhimairaRespawn",(os.time() + respawn))
end
