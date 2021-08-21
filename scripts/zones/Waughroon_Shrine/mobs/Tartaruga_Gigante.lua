-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Tartaruga Gigante
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
-- AnimationSub 0 = outside shell AnimationSub 1 = inside shell AnimaitonSub 2 = inside > outside shell slowly
function onMobSpawn(mob)
    mob:AnimationSub(2)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 13)
    mob:setMod(tpz.mod.MOVE, 10)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:SetMagicCastingEnabled(false) -- will not cast until it goes into shell
end

function onMobEngaged(mob, target)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:setLocalVar("HPP", mob:getHPP())
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local triggerHPP = mob:getLocalVar("HPP")
    if triggerHPP - hpp >= 6 then
        if mob:AnimationSub() == 2 then
            intoShell(mob)
        elseif mob:AnimationSub() == 1 then
            outOfShell(mob)
        end
    elseif hpp == 100 and mob:AnimationSub() == 1 then
        outOfShell(mob)
    end
end

function intoShell(mob)
    mob:SetMobAbilityEnabled(false)
    mob:setLocalVar("HPP", mob:getHPP()) -- record HP% going into shell
    mob:AnimationSub(1)
    mob:setMod(tpz.mod.REGEN, 750)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(true)
    mob:addMod(tpz.mod.DMGPHYS, -50)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
-- immunities slow, bind, sleep, poison, jettatura
end

function outOfShell(mob)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("HPP", mob:getHPP()) -- record HP% coming out of shell
    mob:AnimationSub(2)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:setTP(3000) -- immediately uses tp move when coming out of shell
    mob:SetMagicCastingEnabled(false)
    mob:addMod(tpz.mod.DMGPHYS, 0)
    mob:SetAutoAttackEnabled(true)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
end

function onMobDeath(mob, player, isKiller)
end
