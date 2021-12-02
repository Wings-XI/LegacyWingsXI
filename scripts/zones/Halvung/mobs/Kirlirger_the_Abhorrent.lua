-----------------------------------
-- Area: Halvung
--  Mob: Kirlirger the Abhorrent
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.CRITHITRATE, 0)
end


function onMobFight(mob, target)

    if mob:AnimationSub() == 1 then
        mob:setMod(tpz.mod.CRITHITRATE, 100)
    end
end

function onAdditionalEffect(mob, target, damage)
    if mob:AnimationSub() == 0 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 100, duration = math.random(2, 5)})
    end
end

function onMobDeath(mob, player, isKiller)
end
