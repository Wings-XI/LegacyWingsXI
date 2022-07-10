------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Boompadu
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.FIREDEF, 200)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.WINDDEF, 200)
    mob:setMod(tpz.mod.EARTHDEF, 200)
    mob:setMod(tpz.mod.THUNDERDEF, 200)
    mob:setMod(tpz.mod.LIGHTDEF, 200)
    mob:setMod(tpz.mod.DARKDEF, 200)
    mob:setMod(tpz.mod.GRAVITYRES, 95)
    mob:setMod(tpz.mod.BINDRES, 95)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENTHUNDER)
end

function onMobFight(mob, target)
    if mob:getHPP() <= 20 then
        mob:setMod(tpz.mod.STORETP, 300)
        mob:setMobMod(tpz.mobMod.WEAPON_BONUS, 35)
    else
        mob:setMod(tpz.mod.STORETP, 250)
        mob:setMobMod(tpz.mobMod.WEAPON_BONUS, 0)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getHPP() <= 15 then
        return 2072
    else
        return 0
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 476)
end

function onMobDespawn(mob)
    local respawn = math.random(7200, 9000) -- 2 to 2.5 hours
    mob:setRespawnTime(respawn) 
    SetServerVariable("BoompaduRespawn", (os.time() + respawn))
end
