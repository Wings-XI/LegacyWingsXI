-----------------------------------
-- Area: Waughroon Shrine
--  MOB: queen_jelly
-- Author: Setzor
-----------------------------------

require("scripts/globals/pathfind");


function onMobInitialize(mob)
    mob:addMod(tpz.mod.REGAIN, 200)
    mob:addMod(tpz.mod.ACC, 100)
    mob:addMod(tpz.mod.FASTCAST,30);

    mob:setMobMod(tpz.mobMod.MP_BASE, 300)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 15)

    mob:setMod(tpz.mod.SPELLINTERRUPT, 25)

end

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function onMobSpawn(mob)
    mob:speed(60);
end;

function onMobRoam(mob)
end;


function onMobFight(mob, target)

end;

function onMonsterMagicPrepare(caster, target)
    local spell = math.random(1,2)
    if spell == 1 then
        return 199  -- waterga
    else
        return 174  -- firaga
    end
    return 0
end

-----------------------------------
-- onMobDeath Action
-----------------------------------

function onMobDeath(mob, player, isKiller)
end;
