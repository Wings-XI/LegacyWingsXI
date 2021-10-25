-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Warder (NIN, BST, WHM)
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    if mob:getMainJob() == tpz.job.NIN then
        mob:setLocalVar("BreakChance", 0) -- Nin mobs dont have a weapon to break
        mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    elseif mob:getMainJob() == tpz.job.BST then
        SpawnMob(mob:getID() +1, mob:getInstance())
        mob:addMod(tpz.mod.MAIN_DMG_RATING, 45)
        mob:setMod(tpz.mod.STR, 15)
        mob:setMod(tpz.mod.ATT, 320)
    elseif mob:getMainJob() == tpz.job.WHM then
        mob:addMod(tpz.mod.MAIN_DMG_RATING, 35)
        mob:setMod(tpz.mod.STR, 10)
        mob:setMod(tpz.mod.ATT, 270)
    end
end

function onMobFight(mob, target)
    if mob:getMainJob() == tpz.job.BST then
        local pet = GetMobByID(mob:getID() +1, mob:getInstance())
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobRoam(mob)
    if mob:getMainJob() == tpz.job.WHM then
        if mob:getCurrentAction() == tpz.act.ROAMING then
            if mob:getLocalVar("magicBuffCooldown") == 0 then
                local random = math.random(0,6)
                local randomCooldown = math.random(3,5)

                switch (random): caseof
                {
                    [0] = function() mob:castSpell(46, mob) end, -- Protect IV
                    [1] = function() mob:castSpell(51, mob) end, -- Shell IV
                    [2] = function() mob:castSpell(53, mob) end, -- Blink
                    [3] = function() mob:castSpell(54, mob) end, -- StoneSkin
                    [4] = function() mob:castSpell(55, mob) end, -- Aquaviel
                    [5] = function() mob:castSpell(57, mob) end, -- Haste
                    [6] = function() mob:castSpell(67, mob) end, -- Barblizzara
                }
                mob:setLocalVar("magicBuffCooldown", randomCooldown)
            elseif mob:getLocalVar("magicBuffCooldown") > 0 then
                mob:setLocalVar("magicBuffCooldown", mob:getLocalVar("magicBuffCooldown") - 1)
            end
        end
    end
end

function onMobSkillFinished(mob, target, skill)
    local skillId = skill:getID()
    if skillId == 1733 or skillId == 1923 or skillId == 2361 or skillId == 1736 then
        if (math.random(100) < 80) then
            local instance = mob:getInstance()
            for i, gateid in ipairs(ID.mob[IMPERIAL_AGENT_RESCUE].GATES) do
                local gate = instance:getEntity(bit.band(gateid, 0xFFF), tpz.objType.MOB)
                if gate and gate:isAlive() and mob:checkDistance(gate) <= 10 and mob:isFacing(gate) then
                    gate:hideName(false)
                    gate:timer(1, function(gate)  gate:hideName(true) end)
                    gate:timer(2000, function(gate)  gate:triggerListener("WEAPONSKILL_TAKE", gate, skillId) end)
                    return  gate:getShortID()
                end
            end
        end
    end
    return 0
end
