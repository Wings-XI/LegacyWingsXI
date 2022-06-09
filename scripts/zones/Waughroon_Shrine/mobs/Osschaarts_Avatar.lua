-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Osschaart's Avatar
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
-----------------------------------

function onMobSpawn(mob)
    -- chances to use searing light
    if (math.random() < 0.15) then
        mob:timer(1000, function (mob)
            mob:useMobAbility(919)
        end)
    end
end

function onMobSkillFinished(mob, target, skill)
    -- despawn mob after astral flow
    if (skill:getID() == 919) then
        DespawnMob(mob:getID())
    end
end