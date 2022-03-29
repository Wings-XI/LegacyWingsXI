-----------------------------------
-- Area: Gustav Tunnel (212)
--  Mob: Gorattz Clones
--  Involved in Mission: Enemy of the Empire (II) - A Shantotto Ascension
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 8)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setUnkillable(true)
    mob:setSpellList(0)
end

function onMobFight(mob, target)
    if mob:getHP() == 1 then
        DespawnMob(mob:getID())
        for _, member in pairs(target:getAlliance()) do
            member:messageSpecial(ID.text.ASA_SHADOW_DEATH, 1)
        end
    end
end

function onMobDespawn(mob)
    local renfred = GetMobByID(ID.mob.RENFRED)
    local deadCount = renfred:getLocalVar("clonesDead")
    renfred:setLocalVar("clonesDead", deadCount + 1)
end

function onMobDeath(mob, player, isKiller)
end