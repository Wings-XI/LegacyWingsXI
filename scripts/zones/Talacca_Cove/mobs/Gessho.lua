-----------------------------------
-- Area: Talacca Cove
--  Mob: Gessho
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)

end

function onMobFight(mob, target)
    if(mob:getID() == ID.mob.GESSHO) then
        local chance = math.random(1, 100)

        if (chance == 50) then
            local clones = math.random(1, 6)
            for i=1, clones, 1 do SpawnMob(mob:getID()+i) end
        end

        if (mob:getHPP() <= 15) then
            mob:getBattlefield():win()
        end
    else
        local count = mob:getLocalVar("DespawnCount")
        mob:setLocalVar("DespawnCount", count+1)

        if (count == 90) then
            DespawnMob(mob:getID())
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
