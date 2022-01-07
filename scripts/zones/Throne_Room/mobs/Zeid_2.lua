-----------------------------------
-- Area: Throne Room
--  Mob: Zeid (Phase 2)
-- Mission 9-2 BASTOK BCNM Fight
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setLocalVar("threshold", 0)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, hpp = math.random(20, 50)},
        },
    })
    local battlefield = mob:getBattlefield()
    if GetMobByID(ID.mob.ZEID_BCNM_OFFSET + (battlefield:getArea() - 1) * 4):isDead() then
        battlefield:setLocalVar("phaseChange", 0)
    end
end

function onMobEngaged(mob, target)
    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if v:getName() == "Volker" then
            v:addEnmity(mob, 0, 1)
        end
    end
end

function onMobFight(mob, target)
    local zeid = mob:getID()
    local shadow1 = GetMobByID(zeid + 1)
    local shadow2 = GetMobByID(zeid + 2)
    local shadowthreshold = mob:getLocalVar("threshold")

    if mob:getHPP() <= 80 and shadow1:isDead() and shadow2:isDead() and shadowthreshold == 0 then
        mob:useMobAbility(1002)
        mob:setLocalVar("threshold", 1)
    end

    if mob:getHPP() <= 45 and shadow1:isDead() and shadow2:isDead() and shadowthreshold <= 1 then
        mob:useMobAbility(1002)
        mob:setLocalVar("threshold", 2)
    end

    if mob:getHPP() <= 20 and shadow1:isDead() and shadow2:isDead() and shadowthreshold <= 2 then
        mob:useMobAbility(1002)
        mob:setLocalVar("threshold", 3)
    end

end

function onMobDeath(mob, player, isKiller)
    DespawnMob(mob:getID()+1)
    DespawnMob(mob:getID()+2)
end
