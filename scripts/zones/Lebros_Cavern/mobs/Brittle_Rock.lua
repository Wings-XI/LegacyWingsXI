-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
-- Mob: Brittle Rock
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MIN, -1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 0)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(tpz.mod.UDMGPHYS,-85)
    mob:setMod(tpz.mod.UDMGBREATH,-95)
    mob:setMod(tpz.mod.UDMGRANGE,-95)
    mob:setMod(tpz.mod.UDMGMAGIC, -90)
    mob:setMod(tpz.mod.POISONRES, 100)
    mob:setMod(tpz.mod.DMGPHYS, 15)
    mob:setMod(tpz.mod.DMGPHYS_II, 15)
    mob:setMod(tpz.mod.DMGMAGIC, 10)
    mob:setMod(tpz.mod.DMGMAGIC_II, 10)
    mob:setMod(tpz.mod.DMGBREATH, 5)
    mob:setMod(tpz.mod.DMGRANGE, 5)
    mob:setMod(tpz.mod.EVA, 0)

    mob:addListener("WEAPONSKILL_TAKE", "BRITTLE_ROCK_WEAPONSKILL_TAKE", function(mob, wsid)
        if wsid == 1838 then
           mob:setHP(0)
       end
    end)
end

function onMobSpawn(mob)
    --mob:setMod(tpz.mod.NO_DROPS, 1)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    if mob:getID() == ID.mob[21].MOBS_START.BRITTLE_ROCK1 then
        instance:getEntity(bit.band(ID.npc._1rx, 0xFFF), tpz.objType.NPC):setAnimation(8)
    elseif mob:getID() == ID.mob[21].MOBS_START.BRITTLE_ROCK2 then
        instance:getEntity(bit.band(ID.npc._1ry, 0xFFF), tpz.objType.NPC):setAnimation(8)
    elseif mob:getID() == ID.mob[21].MOBS_START.BRITTLE_ROCK3 then
        instance:getEntity(bit.band(ID.npc._1rz, 0xFFF), tpz.objType.NPC):setAnimation(8)
    elseif mob:getID() == ID.mob[21].MOBS_START.BRITTLE_ROCK4 then
        instance:getEntity(bit.band(ID.npc._jr0, 0xFFF), tpz.objType.NPC):setAnimation(8)
    elseif mob:getID() == ID.mob[21].MOBS_START.BRITTLE_ROCK5 then
        instance:getEntity(bit.band(ID.npc._jr1, 0xFFF), tpz.objType.NPC):setAnimation(8)
    end

    if mob:getLocalVar("Killed") == 0 then
        instance:setProgress(instance:getProgress() + 1)
        mob:setLocalVar("Killed", 1)
    end
end

function onMobDespawn(mob)
end
