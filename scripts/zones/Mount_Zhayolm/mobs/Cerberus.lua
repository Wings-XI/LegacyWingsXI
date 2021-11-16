-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMod(tpz.mod.STUNRES, -100) -- Need to adjust stunres so it's stunnable  
    mob:setMod(tpz.mod.MEVA, 350)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.FIREDEF, 200)
    mob:useMobAbility(1892)
end

function onMobRoam(mob)
    howl = math.random()
    if howl > .95 then
        mob:useMobAbility(1892)
    end
end

function onMobFight(mob, target)
    if mob:getHPP() <= 75 and mob:getHPP() > 50 then
        mob:setMod(tpz.mod.REGAIN, 60)
    elseif mob:getHPP() <= 50 and mob:getHPP() > 25 then
        mob:setMod(tpz.mod.REGAIN, 40)
    elseif mob:getHPP() <= 25 then
        mob:setMod(tpz.mod.REGAIN, 80)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getHPP() <= 25 and math.random() <= 0.6 then   -- Weighted to favor GoH under 25%
        return 1790
    else
        return 0
    end

end

function onMobDisengage(mob)
    mob:useMobAbility(1892)
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.CERBERUS_MUZZLER)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(48,72)*3600 -- 48 to 72 hours in 60min windows
    mob:setRespawnTime(respawn)
	SetServerVariable("CerbRespawn",(os.time() + respawn))
end
