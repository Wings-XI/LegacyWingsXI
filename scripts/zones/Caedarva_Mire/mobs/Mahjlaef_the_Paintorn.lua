-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Mahjlaef the Paintorn
-- !pos 698 -7.453 520 79
-----------------------------------
--Spell list 550 base, 551 2shield, 552 1shield
--TODO: Needs a listener if mind purge is stunned. It will still use it after the stun.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end 

function onMobSpawn(mob)
    mob:setLocalVar("Shielded", 0)
end

function onMobWeaponSkillPrepare(mob, target)
    return 0
end

function onMobWeaponSkill(mob, target, skill)
local Shielded = mob:getLocalVar("Shielded")
    if skill:getID() == 1965 then -- Immortal Shield
        mob:setLocalVar("Shielded", 1)
    end
end

function onMobFight(mob, target)
local Shielded = mob:getLocalVar("Shielded")
local hpp = mob:getHPP()
local useImmortalShield = false

    if (mob:getMod(tpz.mod.RAMPART_STONESKIN) == 0 and Shielded == 1 and hpp <= 30) then
        mob:useMobAbility(1969) -- AoE Dispely thing
        mob:setLocalVar("Shielded", 0)
    elseif (mob:getMod(tpz.mod.RAMPART_STONESKIN) == 0 and Shielded == 1) then
        mob:useMobAbility(1966) -- Dispely thing
        mob:setLocalVar("Shielded", 0)
    end

    if hpp < 90 and mob:getLocalVar("Shield89") == 0 then
        mob:setLocalVar("Shield89", 1)
        useImmortalShield = true
    elseif hpp < 70 and mob:getLocalVar("Shield69") == 0 then
        mob:setLocalVar("Shield69", 1)
        useImmortalShield = true
    elseif hpp < 50 and mob:getLocalVar("Shield49") == 0 then
        mob:setLocalVar("Shield49", 1)
        useImmortalShield = true
    elseif hpp < 30 and mob:getLocalVar("Shield29") == 0 then
        mob:setLocalVar("Shield29", 1)
        useImmortalShield = true
    elseif hpp < 10 and mob:getLocalVar("Shield9") == 0 then
        mob:setLocalVar("Shield9", 1)
        useImmortalShield = true
    end

    if useImmortalShield then
        mob:useMobAbility(1965)
    end

    -- Immortal Shield should also reduce physical damage
    if (mob:getMod(tpz.mod.RAMPART_STONESKIN) >= 1001) then
        mob:AnimationSub(2)
        mob:setSpellList(551)
    elseif (mob:getMod(tpz.mod.RAMPART_STONESKIN) >= 1) then
        mob:AnimationSub(1)
        mob:setSpellList(552)
    else
        mob:AnimationSub(0)
        mob:setSpellList(550)
    end
end

function onMobDeath(mob, player, isKiller)
end