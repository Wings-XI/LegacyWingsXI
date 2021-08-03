-----------------------------------
-- Area: Bibiki Bay
--   NM: Dalham
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.WATER_ABSORB, 100)
end

function onMobEngaged(mob, target)
    mob:resetLocalVars()
end

function onMobFight(mob, target)
    -- "Increases swings per attack round as its HP lowers. At 15-20% swings like Charybdis giving the illusion of Hundred Fists."
    local animation = mob:getLocalVar("animation")
    local hpp = mob:getHPP()
    local swings = 1 + math.floor((100 - mob:getHPP()) / 18)
    mob:setMobMod(tpz.mobMod.MULTI_HIT, swings)

    -- every 25% Dalham will use a 2 hour animation and begin to attack faster.
    if hpp < 75 and animation == 0 then
        mob:useMobAbility(626)
        mob:setLocalVar("animation", 1)
    elseif hpp < 50 and animation == 1 then
        mob:useMobAbility(626)
        mob:setLocalVar("animation", 2)
    elseif hpp < 25 and animation == 2 then
        mob:useMobAbility(626)
        mob:setLocalVar("animation", 3)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER, {power = 21})
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("COP_Dalham_KILL") == 0) then
        player:setCharVar("COP_Dalham_KILL", 1)
    end
end
