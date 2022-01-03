-----------------------------------
-- Area: Batallia Downs
--  Mob: Vegnix Greenthumb
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
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
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = 50}
        }
    })
end

function onMobDeath(mob, player, isKiller)
    if player:hasKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and not player:hasKeyItem(tpz.ki.SEEDSPALL_ROSEUM) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) then
        player:addKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
        player:delKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_ROSEUM)
    end
end