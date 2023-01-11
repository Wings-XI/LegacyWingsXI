-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Dummy worm. Used to not give away antlion on minimap
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland"),
        require("scripts/mixins/families/antlion_ambush")}

require("scripts/globals/dynamis")
-----------------------------------

local zone = 42

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMobStats(mob)

    -- mob:AnimationSub(1)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    mob:setHP(0)
end
