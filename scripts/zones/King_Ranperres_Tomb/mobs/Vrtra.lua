-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Vrtra
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
-----------------------------------

local offsets = {1, 3, 5, 2, 4, 6}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 0)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 30)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(tpz.mobMod.SIGHT_ANGLE, 90)

    mob:setMobMod(tpz.mobMod.DRAW_IN, 30)

    mob:setMod(tpz.mod.MDEF, 125)
    mob:setMod(tpz.mod.DEF, 665)
    mob:setMod(tpz.mod.MATT, 50)
    mob:setMod(tpz.mod.VIT, 30)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
end

function onMobEngaged(mob, target)
    mob:resetLocalVars()
end

function onMobFight(mob, target)
    local spawnTime = mob:getLocalVar("spawnTime")
    local twohourTime = mob:getLocalVar("twohourTime")
    local fifteenBlock = mob:getBattleTime() / 15

    if twohourTime == 0 then
        twohourTime = math.random(4, 6)
        mob:setLocalVar("twohourTime", twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar("spawnTime", spawnTime)
    end

    if fifteenBlock > twohourTime and mob:getHPP() < 86 then -- 85% or less charm
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", fifteenBlock + math.random(4, 6))
    elseif fifteenBlock > spawnTime then
        local mobId = mob:getID()

        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)

            if not pet:isSpawned() then
                pet:spawn(60)
                local pos = mob:getPos()
                pet:setPos(pos.x, pos.y, pos.z)
                pet:updateEnmity(target)
                break
            end
        end
        mob:setLocalVar("spawnTime", fifteenBlock + 4)
    end
end

function onMobDisengage(mob, weather)
    for i, offset in ipairs(offsets) do
        DespawnMob(mob:getID()+offset)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.VRTRA_VANQUISHER)
end

function onSpellPrecast(mob, spell)
    spell:setMPCost(1)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(172800, 259200) -- 48 to 72 hours.
    mob:setRespawnTime(respawn)
	SetServerVariable("VrtraRespawn",(os.time() + respawn))
end

