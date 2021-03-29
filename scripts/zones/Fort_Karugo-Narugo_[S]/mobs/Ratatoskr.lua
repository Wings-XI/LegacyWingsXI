------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Ratatoskr
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/utils")
require("scripts/globals/mobs")
------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.SLEEPRES, 50)
end

function onMobFight(mob, target)
    -- Possesses enhanced TP gain as HP declines.
    local TP = (100 - mob:getHPP()) * 0.5
    if mob:getMod(tpz.mod.REGAIN) ~= utils.clamp(TP, 1, 100) then
        mob:setMod(tpz.mod.REGAIN, utils.clamp(TP, 1, 100))
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 522)
end
