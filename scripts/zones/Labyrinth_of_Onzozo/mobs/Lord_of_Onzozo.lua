-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Lord of Onzozo
-----------------------------------
mixins =
{
    require("scripts/mixins/rage")
}
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEF, -30)
    mob:addMod(tpz.mod.ATT, 15)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()

    if rnd < 0.4 then
        return 201 -- Waterga III
    elseif rnd < 0.7 then
        return 214 -- Flood
    elseif rnd < 0.9 then
        return 361 -- Blindga
    else
        return 172 -- Water IV
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 774, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end