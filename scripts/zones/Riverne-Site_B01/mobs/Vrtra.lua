-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Vrtra summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
-----------------------------------

local offsets = {7, 9, 11, 8, 10, 12}

function onMobSpawn(mob)
    mob:addMod(tpz.mod.SLEEPRES, 100)
    mob:addMod(tpz.mod.LULLABYRES, 100)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(tpz.mobMod.SIGHT_ANGLE, 90)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 75)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DMGMAGIC, -50)
    mob:setMod(tpz.mod.DEF, 500)
    mob:setMod(tpz.mod.MATT, 75)
end

function onMobEngaged(mob, target)
    mob:resetLocalVars()
end

function onMobFight(mob, target)
    local spawnTime = mob:getLocalVar("spawnTime")
    local twohourTime = mob:getLocalVar("twohourTime")
    local fifteenBlock = mob:getBattleTime() / 3

    if twohourTime == 0 then
        twohourTime = math.random(1, 2)
        mob:setLocalVar("twohourTime", twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar("spawnTime", spawnTime)
    end

    if fifteenBlock > twohourTime then -- Spams Charm in bv2 version every 5s
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", fifteenBlock + math.random(1, 2))
    elseif fifteenBlock > spawnTime + 10 then       
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

end

function onMobDeath(mob, player, isKiller)
    -- Despawn adds when Vrtra dies
    for i, offset in ipairs(offsets) do
        DespawnMob(mob:getID()+offset)
    end
end

function onMobDespawn(mob)
end

function SpawnAdd(mob)

end