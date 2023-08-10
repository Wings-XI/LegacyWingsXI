-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Bopa Greso
-- BCNM: Roar! A Cat Burglar Bares Her Fangs
-- TODO: Shared hate with nanaa, add specific spells to blm mithra, add flavor texts
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobEngaged(mob, target)
    target:showText(mob, ID.text.BOPA_SCRATCHING_POST)
    mob:useMobAbility(math.random(24,25))
end

function onMobFight(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    target:showText(mob, ID.text.THIS_WONT_HURT_MUCH)
end

function onMobDeath(mob, player, isKiller)
end
