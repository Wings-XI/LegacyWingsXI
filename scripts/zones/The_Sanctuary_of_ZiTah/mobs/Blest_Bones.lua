-----------------------------------
-- Area: The Sanctuary of Zi'tah
--   NM: Blest Bones
--   A Shantotto Ascension NM
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGPHYS, -100)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.UDMGRANGE, -100)
    mob:setMod(tpz.mod.ICERES, 30)
    mob:setMod(tpz.mod.EARTHRES, 30)
    mob:setMod(tpz.mod.WATERRES, 30)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("Disengage", os.time()+195)
end

function onMobFight(mob, target)
    local disengage = mob:getLocalVar("Disengage")
    if os.time() > disengage then
        DespawnMob(mob:getID())
    end
end

function onMobRoam(mob)
    local hour = VanadielHour()
    if hour >= 7 and hour < 17 then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    mob:setLocalVar("respawn", os.time() + 120)
    for _, member in pairs(player:getParty()) do
        local chance = math.random(1,2)
        if chance == 1 and member:hasKeyItem(tpz.ki.LUMINOUS_BEIGE_FRAGMENT) == false and member:getCurrentMission(ASA) == tpz.mission.id.asa.SHANTOTTO_IN_CHAINS then
            member:addKeyItem(tpz.ki.LUMINOUS_BEIGE_FRAGMENT)
            member:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LUMINOUS_BEIGE_FRAGMENT)
        end
    end
end