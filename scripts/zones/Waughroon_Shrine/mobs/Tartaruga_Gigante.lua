-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Tartaruga Gigante
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    mob:AnimationSub(2)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 13)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:SetMagicCastingEnabled(false) -- will not cast until it goes into shell
end

function onMobEngaged(mob, target)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:setLocalVar("changeHP", mob:getHP()/1000)
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local currentHP = mob:getHP()/1000
    local changeHP = mob:getLocalVar("changeHP")
    local act = mob:getCurrentAction()
    if changeHP - mob:getHP()/1000 >= 2 then -- will go in and out of shell after being brought down 5% hp
        if mob:AnimationSub() == 2 then
            intoShell(mob)
        elseif mob:AnimationSub() == 1 and act ~= tpz.act.MAGIC_START or act ~= tpz.act.MAGIC_CASTING then
            outOfShell(mob)
        end
    elseif hpp == 100 and mob:AnimationSub() == 1 then
        outOfShell(mob)
    end
end

function intoShell(mob)
    mob:delStatusEffect(tpz.effect.SILENCE)
    mob:SetMobAbilityEnabled(false)
    mob:setLocalVar("changeHP", mob:getHP()/1000) -- record HP going into shell
    mob:AnimationSub(1)
    mob:addMod(tpz.mod.REGEN, 750)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(true)
    mob:addMod(tpz.mod.DMGPHYS, -50)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
end

function outOfShell(mob)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("changeHP", mob:getHP()/1000) -- record HP coming out of shell
    mob:AnimationSub(2)
    mob:delMod(tpz.mod.REGEN, 750)
    mob:setTP(3000) -- immediately uses tp move when coming out of shell
    mob:SetMagicCastingEnabled(false)
    mob:delMod(tpz.mod.DMGPHYS, -50)
    mob:SetAutoAttackEnabled(true)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
end

function onMobDeath(mob, player, isKiller)
end
