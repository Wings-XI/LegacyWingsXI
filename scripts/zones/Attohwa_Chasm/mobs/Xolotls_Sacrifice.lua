-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Sacrifice
-- Note: Pet for Xolotl
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/world")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.RESBUILD_LULLABY,33) --"Will quickly build resistance to Lullaby."
    mob:setMod(tpz.mod.RESBUILD_BIND,10)    --"Will build resistance (after about 10 casts) to Gravity and Bind."
    mob:setMod(tpz.mod.RESBUILD_GRAVITY,10)
end

function onMobRoam(mob)
    local totd = VanadielTOTD()

    if totd ~= tpz.time.NIGHT and totd ~= tpz.time.MIDNIGHT then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
end