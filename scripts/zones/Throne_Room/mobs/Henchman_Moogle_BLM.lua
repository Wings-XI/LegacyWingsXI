-----------------------------------
-- Area: Throne Room
--  Mob: Henchman Moogle (BLM)
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
    -- "During this fight, most sources will inflict roughly threefold damage to all targets"
    mob:setMod(tpz.mod.UDMGPHYS, 200)
    mob:setMod(tpz.mod.UDMGBREATH, 200)
    mob:setMod(tpz.mod.UDMGMAGIC, 200)
    mob:setMod(tpz.mod.UDMGRANGE, 200)

    -- Set up resistances specific to each moogle
    -- To counteract the blms always having the same set of weaknesses which could be gamed
    -- Add a randomizer set on Riko's spawn

    local bfArea = mob:getBattlefield():getArea()
    local riko = GetMobByID(ID.mob.RIKO_KUPENREICH_OFFSET + (10 * (bfArea - 1)))
    local randomizer = riko:getLocalVar("henchmen_blm_randomizer")
    local immunity_offset = (mob:getID() + randomizer) % 6
    local sdt_strong_offset = immunity_offset + 1
    if sdt_strong_offset > 5 then
        sdt_strong_offset = 0
    end
    mob:setMod(tpz.mod.FIRE_ABSORB + immunity_offset, 100)
    mob:setMod(tpz.mod.FIRERES + immunity_offset, 1000)
    mob:setMod(tpz.mod.SDT_FIRE + sdt_strong_offset, -75)
end

function onMobEngaged(mob)
    mob:setMod(tpz.mod.REGAIN, 100)
end

function onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, player)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end
