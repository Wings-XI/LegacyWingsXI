-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Domina Shantotto
-- ASA 13 Project: Shantottofication
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:setMod(tpz.mod.DARKRES, 100)
    mob:setMod(tpz.mod.UDMGMAGIC, -80)
    mob:setMod(tpz.mod.EARTHRES, 100)
    mob:setMod(tpz.mod.ICERES, 100)
    mob:setMod(tpz.mod.WATERRES, 100)
    mob:setMod(tpz.mod.FASTCAST, 45)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar("multiMove", 0)
    mob:setLocalVar("moveNum", 0)
    mob:setLocalVar("salvationFirst", 0)
    mob:setLocalVar("skillchainTrigger", 0)
    mob:setLocalVar("delay", 0)
end

function onMobEngage(mob, target)
    mob:showText(mob, ID.text.DSHANTOTTO_ENGAGE)
end

function onMobFight(mob, target)
    local multiMove = mob:getLocalVar("multiMove")
    local moveNum = mob:getLocalVar("moveNum")

    local partner = GetMobByID(mob:getID() + 1)

    if mob:getHPP() <= 75 and multiMove == 0 and utils.canUseAbility(mob) == true and moveNum == 0 then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:showText(mob, ID.text.DSHANTOTTO_75)
        mob:setLocalVar("multiMove", 1)
        mob:setLocalVar("moveNum", 4)
    elseif mob:getHPP() <= 50 and multiMove == 1 and utils.canUseAbility(mob) == true and moveNum == 0 then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:showText(mob, ID.text.DSHANTOTTO_50)
        mob:setLocalVar("multiMove", 2)
        mob:setLocalVar("moveNum", 4)
    elseif mob:getHPP() <= 25 and multiMove == 2 and utils.canUseAbility(mob) == true and moveNum == 0 then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:showText(mob, ID.text.DSHANTOTTO_25)
        mob:setLocalVar("multiMove", 3)
        mob:setLocalVar("moveNum", 4)
    elseif mob:getHPP() <= 10 and multiMove == 2 and utils.canUseAbility(mob) == true and moveNum == 0 and partner:getHPP() > 10 then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:showText(mob, ID.text.SHANTOTTO_METEOR1)
        mob:setLocalVar("multiMove", 3)
        mob:setLocalVar("moveNum", 4)
    end

    if moveNum > 0 and utils.canUseAbility(mob) == true then
        local move = math.random(96,102)
        mob:useMobAbility(move)
        mob:setLocalVar("moveNum", moveNum - 1)
    elseif moveNum == 0 then
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
    end


    local canMeteor = mob:getLocalVar("canMeteor")
    local meteor = mob:getLocalVar("meteor")
    if moveNum == 0 and utils.canUseAbility(mob) == true and utils.canUseAbility(partner) == true and multiMove == 2 and os.time() > meteor and canMeteor ~= 1 then
        mob:setLocalVar("meteor", os.time() + math.random(90,120))
        mob:showText(mob, ID.text.SHANTOTTO_METEOR2)
        mob:showText(partner, ID.text.DSHANTOTTO_METEOR1)
        partner:castSpell(218, target)
        mob:entityAnimationPacket("cabk")
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:timer(4600, function(mob)
            if mob:isAlive() then
                mob:entityAnimationPacket("shbk")
                mob:SetAutoAttackEnabled(true)
                mob:SetMobAbilityEnabled(true)
                mob:SetMagicCastingEnabled(true)
            end
        end)
    end

    if mob:getHPP() <= 40 and mob:getLocalVar("skillchainTrigger") == 0 then
        mob:setLocalVar("skillchainTrigger", 1)
        mob:setLocalVar("salvationFirst", 1)
    end

    local partner = GetMobByID(mob:getID() - 1)
    if mob:getLocalVar("skillchainTrigger") >= 1 and partner:isAlive() then
        local skillchainTime = mob:getLocalVar("skillchainTime")
        local delay = mob:getLocalVar("delay")
        if os.time() > skillchainTime and mob:getLocalVar("salvationFirst") == 1 and mob:getLocalVar("skillchainTrigger") == 1 then
            mob:useMobAbility(2486)
            mob:setLocalVar("salvationFirst", 0)
            mob:setLocalVar("skillchainTrigger", 3)
            partner:setLocalVar("delay", os.time() + 5)
        elseif os.time() > skillchainTime and os.time() >= delay and mob:getLocalVar("salvationFirst") == 0 and mob:getLocalVar("skillchainTrigger") == 2 then
            mob:setLocalVar("skillchainTime", os.time() + math.random(90,120))
            mob:useMobAbility(2487)
            mob:setLocalVar("salvationFirst", 1)
            mob:setLocalVar("skillchainTrigger", 1)
        end
    end

    local delay = mob:getLocalVar("delay")
    if not partner:isAlive() and os.time() > delay then
        mob:useMobAbility(2486)
        mob:setLocalVar("delay", os.time() + math.random(90,120))
    end
end

function onMobRoam(mob)
    local laughTime = mob:getLocalVar("laughTime")
    if os.time() > laughTime then
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:AnimationSub(0)
    end
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)
    mob:showText(mob, ID.text.DSHANTOTTO_DISENGAGE)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:AnimationSub(1)
    mob:setLocalVar("laughTime", os.time() + 8)
end

function onMobDeath(mob, player, isKiller)
    local partner = GetMobByID(mob:getID() - 1)
    mob:showText(mob, ID.text.DSHANTOTTO_DEATH)
    if partner:isAlive() then
        partner:setLocalVar("canMeteor", 1)
        partner:setLocalVar("delay", os.time() + 30)
    end
end
