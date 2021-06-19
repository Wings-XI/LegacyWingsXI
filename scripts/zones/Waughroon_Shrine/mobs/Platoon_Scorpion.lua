-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Platoon Scorpion
-- BCNM: Operation Desert Swarm
-----------------------------------

local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/status")

function canForceTPMove(mob)
    if mob == nil or not mob:isAlive() or mob:hasStatusEffect(tpz.effect.STUN) or mob:hasStatusEffect(tpz.effect.TERROR)
    or mob:hasStatusEffect(tpz.effect.LULLABY) or mob:hasStatusEffect(tpz.effect.SLEEP_I) or mob:hasStatusEffect(tpz.effect.SLEEP_II)
    or mob:hasStatusEffect(tpz.effect.AMNESIA) or mob:hasStatusEffect(tpz.effect.PETRIFICATION) then return false end
    return true
end

function onMobInitialize(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "SCORP_MIMIC_START", function(mob, skillID)
        if mob:getLocalVar('[ODS]mimic') ~= 1 then -- make sure we aren't infinitely looping through scorps
            local bf = mob:getBattlefield():getArea()
            for _, allyId in ipairs(ID.operationDesertSwarm[bf]) do
                if mob:getID() ~= allyId then
                    local potential_mimic = GetMobByID(allyId)
                    if potential_mimic ~= nil and mob:checkDistance(potential_mimic) < 15 and potential_mimic:getLocalVar('[ODS]LastAbilityMimic') + 6 < os.time() and canForceTPMove(potential_mimic) then
                        potential_mimic:setLocalVar('[ODS]mimic', 1) -- set flag to prevent infinite loops
                        potential_mimic:setLocalVar('[ODS]LastAbilityMimic', os.time())
                        if skillID == 354 or skillID == 355 then potential_mimic:useMobAbility(skillID) end
                    end
                end
            end
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "SCORP_MIMIC_STOP", function(mob, skillID)
        mob:setLocalVar('[ODS]mimic', 0) -- reset infinite loop flag

        -- wiki: sometimes Wild Rage self stuns and sometimes Earth Pounder self binds
        if skillID == 354 and math.random() < 0.35 then -- Wild Rage
            mob:showText(mob,ID.text.SCORPION_IS_STUNNED)
            mob:addStatusEffect(tpz.effect.STUN,0,0,math.random(8,11))
        elseif skillID == 355 and math.random() < 0.55 then -- Earth Pounder
            mob:showText(mob,ID.text.SCORPION_IS_BOUND)
            mob:addStatusEffect(tpz.effect.BIND,0,0,math.random(10,15))
        end
    end)
end

function onMobWeaponSkillPrepare(mob, target)
    if math.random() < 0.65 then return 354 else return 355 end -- prefer wild rage
end

function onMobSpawn(mob)
    -- wiki: They cannot be feasibly slept after the 3rd or 4th Sleep... By the 9th cast [of Lullaby] it wears off immediately.
    mob:setLocalVar('WildRagePercent', 100)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 25)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 15)
end

function onMobDeath(mob, player, isKiller)
    if mob:getLocalVar('HasTriggeredDeathScriptOnce') == 0 then
        mob:setLocalVar('HasTriggeredDeathScriptOnce', 1)
        for _, allyId in ipairs(ID.operationDesertSwarm[mob:getBattlefield():getArea()]) do
            local scorp = GetMobByID(allyId)
            if scorp ~= nil and scorp:isAlive() then
                scorp:setLocalVar('WildRagePercent', scorp:getLocalVar('WildRagePercent') + 40) -- see wild_rage.lua... wiki: wild rage on the last scorp alive did 600+ damage to a BLU with protect *and* cocoon
                mob:setMod(tpz.mod.RESBUILD_SLEEP, mob:getMod(tpz.mod.RESBUILD_SLEEP) + 12) -- wiki: Their Sleep resistance increases drastically when only few of them are left.
                mob:setMod(tpz.mod.RESBUILD_LULLABY, mob:getMod(tpz.mod.RESBUILD_LULLABY) + 12)
            end
            
        end 
    end
end
