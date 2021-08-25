-----------------------------------
-- Area: Monastic Cavern
--  Mob: Overlord Bakgodek
-- TODO: messages should be zone-wide
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, {chance = 35, power = math.random(95, 135)})
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 90)
    mob:setMod(tpz.mod.PARALYZERESTRAIT, 75)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 75)
    mob:setMod(tpz.mod.MAIN_DMG_RATING, 85)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.ORC_KING_ENGAGE)
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.OVERLORD_OVERTHROWER)
    if isKiller then
        mob:showText(mob, ID.text.ORC_KING_DEATH)
    end
end

function onMobDespawn(mob)
    -- reset hqnm system back to the nm placeholder
    local nqId = mob:getID() - 1
    SetServerVariable("Overlord_Bakgodek_UP", 0)
    SetServerVariable("[PH]Overlord_Bakgodek", 0)
    local wait = 72 * 3600
    SetServerVariable("[POP]Overlord_Bakgodek", os.time() + wait) -- 3 days

    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(nqId, false)
    UpdateNMSpawnPoint(nqId)
    local respawn = (75600 + ((math.random(0, 6)) * 1800)) -- 21 - 24 hours with half hour windows
    GetMobByID(nqId):setRespawnTime(respawn)
    SetServerVariable("Orcish_Overlord_Respawn",(os.time() + respawn))
end