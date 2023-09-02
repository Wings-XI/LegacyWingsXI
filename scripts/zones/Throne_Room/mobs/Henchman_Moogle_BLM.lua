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
    local absorb_offset = mob:getID() % 6
    local sdt_strong_offset = absorb_offset + 1
    if sdt_strong_offset > 5 then
        sdt_strong_offset = 0
    end
    mob:setMod(tpz.mod.FIRE_ABSORB + absorb_offset, 100)
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

