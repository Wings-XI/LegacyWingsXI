-----------------------------------
-- Area: RoMaeve
--   NM: Steely Weapon
--   A Shantotto Ascension NM
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/RoMaeve/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGPHYS, -100)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    mob:setMod(tpz.mod.UDMGBREATH, -100)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
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

function onMobDeath(mob, player, isKiller)
    for _, member in pairs(player:getParty()) do
        local chance = math.random(1,2)
        if chance == 1 and member:hasKeyItem(tpz.ki.LUMINOUS_YELLOW_FRAGMENT) == false and member:getCurrentMission(ASA) == tpz.mission.id.asa.SHANTOTTO_IN_CHAINS then
            member:addKeyItem(tpz.ki.LUMINOUS_YELLOW_FRAGMENT)
            member:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LUMINOUS_YELLOW_FRAGMENT)
        end
    end
end