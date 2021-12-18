-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Tartaruga Gigante
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------

-- Removes any possible debuff when it goes into shell and we have no function that exists for this
local removables = {tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.MAX_HP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.PARALYSIS, tpz.effect.POISON,
                    tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND,
                    tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN,
                    tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
                    tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN,
                    tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN,
                    tpz.effect.MAGIC_DEF_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.SILENCE}

function onMobSpawn(mob)
    mob:AnimationSub(2)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 13)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:addMod(tpz.mod.DMGMAGIC,-40)
    mob:SetMagicCastingEnabled(false) -- will not cast until it goes into shell
    outOfShell(mob)
end

function onMobEngaged(mob, target)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    local changeHP = mob:getHP() - (mob:getHP() * .05)
    mob:setLocalVar("changeHP", changeHP)
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local changeHP = mob:getLocalVar("changeHP")
    local act = mob:getCurrentAction()
    if mob:getHP() < changeHP then -- will go in and out of shell after being brought down 5% hp
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
    for i, effect in ipairs(removables) do
        if (mob:hasStatusEffect(effect)) then
            mob:delStatusEffect(effect)
        end
    end

    mob:SetMobAbilityEnabled(false)
    local chance = math.random(5,10)
    local changeHP = mob:getLocalVar("changeHP")
    if mob:getHPP() < changeHP then
        local changeHP = changeHP - chance
        mob:setLocalVar("changeHP", changeHP) -- record HP going into shell
    end
    mob:setLocalVar("changeTime", os.time() + 90) -- Time to come out of shell
    mob:AnimationSub(1)
    mob:setMod(tpz.mod.REGEN, 400)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(true)
    mob:setMod(tpz.mod.UDMGRANGE, -95)
    mob:setMod(tpz.mod.UDMGPHYS, -95)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
end

function outOfShell(mob)
    mob:SetMobAbilityEnabled(true)
    local chance = math.random(5,10)
    local changeHP = mob:getLocalVar("changeHP")
    local changeHP = changeHP - chance
    mob:setLocalVar("changeHP", changeHP) -- record HP coming out of shell
    if mob:AnimationSub() == 1 then
        mob:AnimationSub(2)
    else
        mob:AnimationSub(0)
    end
    mob:setMod(tpz.mod.REGEN, 0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(false)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
end

function onMobDeath(mob, player, isKiller)
end
