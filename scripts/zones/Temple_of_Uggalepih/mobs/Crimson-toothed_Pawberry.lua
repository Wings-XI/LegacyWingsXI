-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Crimson-toothed Pawberry
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 392)
end


function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 18000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 28000)
    -- Special Attacks: Summons a "Tonberry's Avatar" (Carbuncle) and uses Astral Flow (Searing Light) immediately on spawning and multiple times subsequently
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW, hpp = 100},
            {id = tpz.jsa.ASTRAL_FLOW, hpp = 50},
            {id = tpz.jsa.ASTRAL_FLOW, hpp = 20},
        },
    })
end

function onMobDespawn(mob)
    -- ensure astral flow pet is not spawned stuck somewhere
    DespawnMob(mob:getID() + 1)
    DespawnMob(mob:getID() + 2)
end