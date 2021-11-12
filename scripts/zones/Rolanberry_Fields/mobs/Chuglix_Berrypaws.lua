-----------------------------------
-- Area: Rolanberry Fields
--   NM: Chuglix Berrypaws
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/keyitems")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 60)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
end

function onMobSpawn(mob)
    mob:removeListener("DEATH_SPAWN_CASKET")
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.PERFECT_DODGE, hpp = 50}
        }
    })
end

function onMobDeath(mob, player, isKiller)
    if player:hasKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE) and not player:hasKeyItem(tpz.ki.SEEDSPALL_CAERULUM) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) then
        player:addKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
        player:delKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_CAERULUM)
    end
end