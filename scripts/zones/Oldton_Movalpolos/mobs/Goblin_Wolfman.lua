-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Goblin Wolfman
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.ACC, 70) -- Lower lvl NM but it hits as if it were VT to a 75
end

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) == true then
        mob:setMod(tpz.mod.DELAY, 1500)
        mob:setMod(tpz.mod.ATTP, 140)
    else
        mob:setMod(tpz.mod.DELAY, 0)
        mob:setMod(tpz.mod.ATTP, 0)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 245)
end
