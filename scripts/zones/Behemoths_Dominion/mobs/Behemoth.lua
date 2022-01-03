-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: Behemoth
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
    if LandKingSystem_NQ > 0 or LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(tpz.status.DISAPPEAR)
    end
    if LandKingSystem_HQ == 0 then
        SetDropRate(270, 3342, 0) -- do not drop savory_shank
    end

    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    mob:addMod(tpz.mod.DEF, -80)
    mob:addMod(tpz.mod.EVA, -40)
    mob:addMod(tpz.mod.ACC, -20)
    mob:addMod(tpz.mod.ATTP, -65)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 90)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 10)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 5)
    mob:setMod(tpz.mod.MDEF, -30)
end

function onMobFight(mob, target)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() > -180 and target:getZPos() > 53) and os.time() > drawInWait then -- North Tunnel Draw In
        local rot = target:getRotPos()
        target:setPos(-182.19,-19.83,58.34,rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getXPos() > -230 and target:getZPos() < 5) and os.time() > drawInWait then  -- South Tunnel Draw In
        local rot = target:getRotPos()
        target:setPos(-235.35,-20.01,-4.47,rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.BEHEMOTHS_BANE)
end

function onMobDespawn(mob)
    local ToD = GetServerVariable("[POP]King_Behemoth")
    local kills = GetServerVariable("[PH]King_Behemoth")
    local popNow = (math.random(1, 5) == 3 or kills > 6)

    if LandKingSystem_HQ ~= 1 and ToD <= os.time() and popNow then
        -- 0 = timed spawn, 1 = force pop only, 2 = BOTH
        if LandKingSystem_NQ == 0 then
            DisallowRespawn(ID.mob.BEHEMOTH, true)
        end

        DisallowRespawn(ID.mob.KING_BEHEMOTH, false)
        UpdateNMSpawnPoint(ID.mob.KING_BEHEMOTH)
        GetMobByID(ID.mob.KING_BEHEMOTH):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    else
        if LandKingSystem_NQ ~= 1 then
            UpdateNMSpawnPoint(ID.mob.BEHEMOTH)
            GetMobByID(ID.mob.BEHEMOTH):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
            SetServerVariable("[PH]King_Behemoth", kills + 1)
        end
    end
end
