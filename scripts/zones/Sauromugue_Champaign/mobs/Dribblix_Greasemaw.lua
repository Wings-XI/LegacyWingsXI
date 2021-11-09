-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Dribblix Greasemaw
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
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
            {id = tpz.jsa.EES_GOBLIN, hpp = 50}
        }
    })
end

function onMobDeath(mob, player, isKiller)
    if player:hasKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB) and not player:hasKeyItem(tpz.ki.SEEDSPALL_VIRIDIS) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) then
        player:addKeyItem(tpz.ki.SEEDSPALL_VIRIDIS)
        player:delKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEEDSPALL_VIRIDIS)
    end
end
