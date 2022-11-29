-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Troll Cuirasser
-- Author: Spaceballs
--   Note: Pet of Khromasoul Bhurborlor
-----------------------------------


mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")


function onMobSpawn(mob)
    mob:setLocalVar("clock", os.time() + math.random(10,30))
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    -- fudges souleater logic instead of messing with core for the one mob in the game that uses souleater
    if mob:hasStatusEffect(tpz.effect.SOULEATER) then
        local hpToDmg = 0
        if mob:getHP() > 20 then
            local hpToDmg = mob:getHP() * 12 / 100
            hpToDmg = math.max(hpToDmg, 20)
            mob:setHP(mob:getHP() - hpToDmg)-- Due to resistance checking, best to floor this at 20

            return tpz.mob.onAddEffect(mob, target, hpToDmg, tpz.mob.ae.ENDARK)

        else
            local hpToDmg = 0
            return tpz.mob.onAddEffect(mob, target, hpToDmg, tpz.mob.ae.ENDARK)
        end

    end
end


function onMobFight(mob, target)
    if os.time() >= mob:getLocalVar("clock") then
        mob:useMobAbility(709)
        mob:setLocalVar("clock", os.time() + math.random(65,85))
    end
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
end