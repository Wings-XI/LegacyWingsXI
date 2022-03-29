-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: King Behemoth
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/magic")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 60)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    if LandKingSystem_NQ > 0 or LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(tpz.status.DISAPPEAR)
    end

    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:addMod(tpz.mod.ATT, -50)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 10)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 99)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.MDEF, -20)
end

function onAdditionalEffect(mob, target, damage)
    local params = {}
    params.chance = 20
    params.duration = math.random(4, 8) -- Based on captures
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, params)
end

function onMobFight(mob, target)
    if mob:getHPP() >= 50 then
        mob:setMod(tpz.mod.REGAIN, 160)
     elseif mob:getHPP() < 50 and mob:getHPP() > 25 then
         mob:setMod(tpz.mod.REGAIN, 100)
    else
        mob:setMod(tpz.mod.REGAIN, 80)
    end

    local delay = mob:getLocalVar("delay")
    if (delay > 98) then -- Use Meteor every 40s, based on capture
            mob:castSpell(218) -- meteor
            mob:setLocalVar("delay", 0)
        else
            mob:setLocalVar("delay", delay+1)
    end

    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() > -180 and target:getZPos() > 53) and os.time() > drawInWait then -- North Tunnel Draw In
        local rot = target:getRotPos()
        target:setPos(-182.19,-19.83,58.34,rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getXPos() > -230 and target:getZPos() < 5) and os.time() > drawInWait then -- South Tunnel Draw In
        local rot = target:getRotPos()
        target:setPos(-235.35,-20.01,-4.47,rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

function onSpellPrecast(mob, spell)
    if spell:getID() == 218 then
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.BEHEMOTH_DETHRONER)
end

function onMobDespawn(mob)
    -- Set King_Behemoth's Window Open Time
    if LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]King_Behemoth", os.time() + wait) -- 3 days
        if LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Behemoth's spawnpoint and respawn time (21-24 hours)
    if LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]King_Behemoth", 0)
        DisallowRespawn(ID.mob.BEHEMOTH, false)
        UpdateNMSpawnPoint(ID.mob.BEHEMOTH)
        GetMobByID(ID.mob.BEHEMOTH):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
end
