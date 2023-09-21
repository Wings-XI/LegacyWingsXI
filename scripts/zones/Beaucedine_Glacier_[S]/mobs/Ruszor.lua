-----------------------------------
-- Area: Beaucedine Glacier [S]
--  Mob: Ruszor
-----------------------------------
mixins = { require("scripts/mixins/families/ruszor") }
-----------------------------------

function onMobFight(mob, target)
    -- If target changes and the new target is behind, use sub-zero smash (with some restrictions)
    if
        target ~= nil and
        mob:getTP() > 2000 * mob:getHPP() / 100 and
        mob:getLocalVar('lastSmash') < os.time() and
        target:isBehind(mob, 48)
    then
        mob:setLocalVar('nextSmash', os.time() + 15)
        mob:useMobAbility(2436)
    end
end

function onMobDeath(mob, player, isKiller)
end