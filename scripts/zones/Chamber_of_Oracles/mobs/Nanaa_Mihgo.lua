-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Nanaa Mihgo
-- BCNM: Roar! A Cat Burglar Bares Her Fangs
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        chance = 100,
        specials =
        {
            { id = tpz.jsa.PERFECT_DODGE, hpp = math.random(35, 65) },
        },
    })
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 10)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 10)
    mob:setMod(tpz.mod.RESBUILD_STUN, 10)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 10)
    mob:setLocalVar("hpCheck", 90)
end

function onMobEngaged(mob, target)
    target:showText(mob, ID.text.CAT_BURGLAR)
    mob:setMod(tpz.mod.REGEN, 100)
    mob:setLocalVar("hpCheck", 90)
end

function onMobFight(mob, target)
    local check = mob:getLocalVar("hpCheck")
    if mob:getHPP() <= check then
        for i = 1, 2 do
            if math.random(3) == 1 then
                newmobid = mob:getID() + i
                newmob = GetMobByID(newmobid)
                newmob:setSpawn(mob:getXPos()+math.random(-2,2), mob:getYPos()-0.3, mob:getZPos()+math.random(-2,2), mob:getRotPos())
                SpawnMob(newmobid)
            end
        end
        mob:setLocalVar("hpCheck", check - 5)
    end
end

function onAdditionalEffect(mob, target, damage)
    local effects = { -- Custom buffed values for "potent Additional Effects"
        { ae = tpz.mob.ae.PARALYZE, params = { power = 40 } },
        { ae = tpz.mob.ae.POISON,   params = { power = 15 } },
        { ae = tpz.mob.ae.SILENCE,  params = { power = 1  } },
        { ae = tpz.mob.ae.STUN,     params = { duration = 10, minDuration = 3, maxDuration = 12 } },
    }
    local effect = effects[math.random(#effects)]
    return tpz.mob.onAddEffect(mob, target, damage, effect.ae, effect.params)
end

function onMobDeath(mob, player, isKiller)
    player:showText(mob, ID.text.EARNED_MY_PAY)
end
