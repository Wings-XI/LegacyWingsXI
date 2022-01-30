-----------------------------------
-- Area: Apollyon (Central)
--  Mob: Proto-Omega
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.COUNTER, 10) -- "Possesses a Counter trait"
    mob:setMod(tpz.mod.REGEN, 25) -- "Posseses an Auto-Regen (low to moderate)"
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:setMod(tpz.mod.UDMGPHYS, -65)
    mob:setMod(tpz.mod.UDMGRANGE, -65)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.MOVE, 100) -- "Moves at Flee Speed in Quadrupedal stance and in the Final Form"
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobFight(mob, target)
    local mobID = mob:getID()
    local formTime = mob:getLocalVar("formWait")
    local lifePercent = mob:getHPP()
    local currentForm = mob:getLocalVar("form")
    local timer = mob:getBattleTime()

    if timer > 120 and currentForm < 1 then
        currentForm = 1
        mob:setLocalVar("form", currentForm)
        formTime = os.time() + 120
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, -75)
        mob:setMod(tpz.mod.MOVE, 0)
        mob:useMobAbility(1532)
    end

    if currentForm == 1 then
        if formTime < os.time() then
            if mob:AnimationSub() == 1 then
                mob:AnimationSub(2)
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
            else
                mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
                mob:AnimationSub(1)
            end
            mob:setLocalVar("formWait", os.time() + 120)
        end        
    end

    if lifePercent < 30 and currentForm < 2 then
        if not GetMobByID(mobID + 1):isSpawned() then
            mob:setLocalVar("podTime", os.time())
            mob:useMobAbility(1532)
        end
        mob:AnimationSub(2)
        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
        mob:setMod(tpz.mod.UDMGPHYS, -50)
        mob:setMod(tpz.mod.UDMGRANGE, -50)
        mob:setMod(tpz.mod.UDMGMAGIC, -50)
        mob:setMod(tpz.mod.MOVE, 100)
        mob:addStatusEffect(tpz.effect.REGAIN,7,3,0) -- The final form has Regain,
        mob:getStatusEffect(tpz.effect.REGAIN):setFlag(tpz.effectFlag.DEATH)
        currentForm = 2
        mob:setLocalVar("form", currentForm)
    end

    if currentForm == 2 and (os.time() - mob:getLocalVar("podTime")) >= 300 then
        if not GetMobByID(mobID + 1):isSpawned() then
            mob:setLocalVar("podTime", os.time() + 300)
            mob:useMobAbility(1532)
        end
    end

end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player then
        player:addTitle(tpz.title.APOLLYON_RAVAGER)
    end
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_CENTRAL_CRATE):setStatus(tpz.status.NORMAL)
    end
end

