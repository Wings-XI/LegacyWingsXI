-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Cha_Lebagta
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
    target:showText(mob, ID.text.YA_RANG_BOSS)
    mob:useMobAbility(25)
end

function onMobFight(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller)
end
