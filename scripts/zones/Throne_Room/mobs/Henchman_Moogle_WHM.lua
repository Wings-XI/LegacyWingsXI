-----------------------------------
-- Area: Throne Room
--  Mob: Henchman Moogle (WHM)
-- AMK14 - Smash! A Malevolent Menace
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMod(tpz.mod.REFRESH, 10)
    mob:setMod(tpz.mod.CURE_POTENCY, 25)
end

function onMobEngaged(mob)
    mob:setMod(tpz.mod.REGAIN, 400)
end

function onMobFight(mob, target)
    local bfArea = mob:getBattlefield():getArea()
    local rikoID = ID.mob.RIKO_KUPENREICH_OFFSET + (10 * (bfArea - 1))
    local lastCast = mob:getLocalVar("lastCast")
    if lastCast < os.time() then
        mob:castSpell(tpz.magic.spell.CURE_V, GetMobByID(rikoID))
        mob:setLocalVar("lastCast", os.time() + 8)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end

