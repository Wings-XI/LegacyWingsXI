-----------------------------------
-- Area: Mine Shaft 2716
-- CoP Mission 5-3 (A Century of Hardship)
-- NM: Bugbby
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.ATTP, -50)
end

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 300, hpp = math.random(85, 95)}, -- 5min cooldown
        },
    })
    mob:addMod(tpz.mod.DOUBLE_ATTACK, 100)
    mob:addMod(tpz.mod.TRIPLE_ATTACK, 30)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    local activeMoblins = {} -- clear list prior to checking
    local hateReset = mob:getLocalVar("hateResetTimer")
    local timeBlock = mob:getBattleTime() / 60 -- every 60 seconds, a random moblin calls for bugbby to attack their target

    if hateReset == 0 then
        hateReset = 1
        mob:setLocalVar("hateResetTimer", hateReset)
    end

    if timeBlock >= hateReset then
        local bfID = mob:getBattlefield():getArea()
        mob:setLocalVar("hateResetTimer", hateReset + 1)
        for i, v in ipairs(ID.aCenturyOfHardship[bfID].MOBLIN_IDS) do 
            local moblinAlive = GetMobByID(v)
            if moblinAlive:isAlive() then -- make sure we're not adding dead moblins into the table
                table.insert(activeMoblins, v)
            end
        end
        if (#activeMoblins > 0) then
            local randMoblin = GetMobByID(activeMoblins[math.random(#activeMoblins)]) -- choose random moblin from activeMoblins
            mob:disengage()
            mob:resetEnmity(target)
            mob:updateEnmity(randMoblin:getTarget()) -- attack the chosen random moblin's target
        end
    end
end

function onMobDeath(mob, player, isKiller)
end