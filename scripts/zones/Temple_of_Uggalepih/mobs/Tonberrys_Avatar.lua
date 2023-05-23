-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Tonberry's Avatar
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
mixins = {require("scripts/mixins/families/avatar")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobSpawn(mob)
    if mob:getID() == ID.mob.CRIMSON_TOOTHED_PAWBERRY + 2 then
        mob:setModelId(791) -- Carbuncle
    end
end
