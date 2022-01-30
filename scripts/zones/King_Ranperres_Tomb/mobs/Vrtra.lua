-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Vrtra
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/mobs")
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
-----------------------------------

local offsets = {1, 3, 5, 2, 4, 6}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(tpz.mobMod.SIGHT_ANGLE, 90)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 75)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMobMod(tpz.mobMod.DRAW_IN_FRONT, 1)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DMGMAGIC, -50)
    mob:setMod(tpz.mod.DEF, 500)
    mob:setMod(tpz.mod.MATT, 75)
    mob:setMod(tpz.mod.INT, 4)
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
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", fifteenBlock + math.random(4, 6))
    elseif fifteenBlock > spawnTime then
        mob:entityAnimationPacket("casm")
        mob:timer(3000, function(mob)
            local mobId = mob:getID()
            for i, offset in ipairs(offsets) do
                local pet = GetMobByID(mobId + offset)

                if not pet:isSpawned() then
                        mob:entityAnimationPacket("shsm")
                        pet:spawn(60)
                        local pos = mob:getPos()
                        pet:setPos(pos.x, pos.y, pos.z)
                        pet:updateEnmity(mob:getTarget())   

                    break
                end
            end
        end)
        mob:setLocalVar("spawnTime", fifteenBlock + 4)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENDARK, {power = math.random(45, 90), chance = 10})
end

function onMobWeaponSkill(target, mob, skill, action)
    local skillID = skill:getID()
    if skillID == 710 then
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
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

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(144,240)*1800 -- 3 to 5 days in 30min windows
    mob:setRespawnTime(respawn)
	SetServerVariable("VrtraRespawn",(os.time() + respawn))
end
