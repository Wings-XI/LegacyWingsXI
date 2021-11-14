-----------------------------------
-- Area: Jade Sepulcher
--  Mob: Lancelord Gaheel Ja
-- To Do: Needs 2nd Skill list for under 25% and replace Fire Angon with Blazing Angon
-----------------------------------
local ID = require("scripts/zones/Jade_Sepulcher/IDs")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.SLOWRESTRAIT, 80)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 80)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 80)
    mob:setMod(tpz.mod.DMGMAGIC, 20)
    mob:setMod(tpz.mod.ATTP, 0)
end


function onMobSpawn(mob)
    mob:addStatusEffect(tpz.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(tpz.effect.SHELL, 24, 0, 1800)
end

function onMobFight(mob, target)
    
    local delay = mob:getLocalVar("delay")
        if (delay > 45) then -- Use Ranged Attack every 15s, based on capture
                mob:useMobAbility(272) -- Spear Ranged Attack
                mob:setLocalVar("delay", 0)
                mob:wait(1000)
            else
                mob:setLocalVar("delay", delay+1)
        end
    
    if mob:getHPP() < 50 and mob:getHPP() > 25 then
         mob:setMod(tpz.mod.REGAIN, 100)
    elseif mob:getHPP() < 25 then
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMod(tpz.mod.ATT, 200)
        mob:setMod(tpz.mod.ATTP, 100)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 60)
    end
end

function onMonsterMagicPrepare(mob, target)
    return 261
end

function onMobDeath(mob, player, isKiller)
end