-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Decurio
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/globals/regimes")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------

function onMobSpawn(mob)
    onPath(mob)
end

function onPath(mob)
        local centurio = GetMobByID(ID.mob.CENTURIO_XII_I)
        if centurio:isSpawned() then
            local mobId = mob:getID()
            switch (mobId): caseof {
                [17244373] = function() mob:pathTo(centurio:getXPos() + 3, centurio:getYPos(), centurio:getZPos() + 3) end,
            }
        end
end


function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 112, 1, tpz.regime.type.FIELDS)
end
