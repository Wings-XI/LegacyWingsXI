-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Sewer Syrup
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 19000)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 10)
    mob:addMod(tpz.mod.SLEEPRES, 70) -- "Resistant to Sleep" https://ffxiclopedia.fandom.com/wiki/Sewer_Syrup
    mob:addMod(tpz.mod.DMGMAGIC, 100) -- "Takes double damage from magic." https://www.bg-wiki.com/ffxi/Sewer_Syrup
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end 
