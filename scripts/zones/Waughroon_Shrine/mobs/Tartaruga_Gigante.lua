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

function intoShell(mob)
    for i, effect in ipairs(removables) do
        if (mob:hasStatusEffect(effect)) then
            mob:delStatusEffect(effect)
        end
    end

    mob:SetMobAbilityEnabled(false)
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
    mob:setTP(3000)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(false)
    mob:AnimationSub(2)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:SetAutoAttackEnabled(true)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
end

function onMobSpawn(mob)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(false) -- will not cast until it goes into shell
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 13)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.DMGMAGIC, -30)
    mob:setMod(tpz.mob.CURSERES, 100)

    local changeHP = mob:getHP() - (mob:getHP() * .05)
    mob:setLocalVar("changeHP", changeHP)
    mob:setLocalVar("DamageTaken", 0)
    mob:AnimationSub(2)

    mob:addListener("TAKE_DAMAGE", "TARTARUGA_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        local damageTaken = mob:getLocalVar("DamageTaken")
        local waitTime = mob:getLocalVar("waitTime")
        damageTaken = damageTaken + amount

        if damageTaken > 4000 then
            mob:setLocalVar("DamageTaken", 0)
            if mob:AnimationSub() == 1 and os.time() > waitTime then
                mob:AnimationSub(2)
                changeHP = mob:getHP() - (mob:getHP() * .05)
                mob:setLocalVar("changeHP", changeHP)
                mob:setLocalVar("waitTime", os.time() + 2)
                outOfShell(mob)
            end
        elseif os.time() > waitTime then
            mob:setLocalVar("DamageTaken", damageTaken)
        end
    end)
end

function onMobFight(mob, target)
    local changeHP = mob:getLocalVar("changeHP")
    local waitTime = mob:getLocalVar("waitTime")

    if mob:getHP() < changeHP and mob:AnimationSub() == 2 and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:AnimationSub(1)
        mob:setLocalVar("waitTime", os.time() + 2)
        intoShell(mob)
    elseif mob:getHPP() == 100 and mob:AnimationSub() == 1 and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:AnimationSub(2)
        changeHP = mob:getHP() - (mob:getHP() * .05)
        mob:setLocalVar("changeHP", changeHP)
        mob:setLocalVar("waitTime", os.time() + 2)
        outOfShell(mob)
    end
end

function onMobDespawn(mob)
    mob:resetLocalVars()
    mob:removeListener("TARTARUGA_TAKE_DAMAGE")
end
