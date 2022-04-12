-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Shantotto
-- ASA 13 Project: Shantottofication
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
-----------------------------------

local nukes = {144, 154, 164}
local aoe   = {174, 184, 194}

function onMobSpawn(mob)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:setMod(tpz.mod.LIGHTRES, 100)
    mob:setMod(tpz.mod.UDMGMAGIC, -80)
    mob:setMod(tpz.mod.FIRERES, 100)
    mob:setMod(tpz.mod.WINDRES, 100)
    mob:setMod(tpz.mod.THUNDERRES, 100)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.FASTCAST, 45)
    mob:setLocalVar("multiSpell", 0)
    mob:setLocalVar("spellNum", 0)
    mob:setLocalVar("malisonTime", 0)
    mob:setLocalVar("skillchainTime", 0)
    mob:setLocalVar("malisonFirst", 0)
    mob:setLocalVar("delay", 0)
    mob:setLocalVar("canMeteor", 0)
end

function onMobEngage(mob, target)
    mob:showText(mob, ID.text.SHANTOTTO_ENGAGE)
end

function onMobFight(mob, target)
    local multiSpell = mob:getLocalVar("multiSpell")
    local spellNum = mob:getLocalVar("spellNum")
    local partner = GetMobByID(mob:getID() + 1)

    if mob:getHPP() <= 75 and multiSpell == 0 and spellNum == 0 and utils.canUseAbility(mob) == true then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:showText(mob, ID.text.SHANTOTTO_75)
        mob:setLocalVar("multiSpell", 1)
        mob:setLocalVar("spellNum", 7)
    elseif mob:getHPP() <= 50 and multiSpell == 1 and spellNum == 0 and utils.canUseAbility(mob) == true then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:showText(mob, ID.text.SHANTOTTO_50)
        mob:setLocalVar("multiSpell", 2)
        mob:setLocalVar("spellNum", 7)
    elseif mob:getHPP() <= 25 and multiSpell == 2 and spellNum == 0 and utils.canUseAbility(mob) == true then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:showText(mob, ID.text.SHANTOTTO_25)
        mob:setLocalVar("multiSpell", 3)
        mob:setLocalVar("spellNum", 7)
    elseif mob:getHPP() <= 10 and multiSpell == 3 and spellNum == 0 and utils.canUseAbility(mob) == true and partner:getHPP() > 10  then
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:useMobAbility(627)
        mob:setLocalVar("multiSpell", 4)
        mob:setLocalVar("spellNum", 7)
        mob:showText(mob, ID.text.SHANTOTTO_METEOR1)
    end

    if spellNum > 2 and utils.canUseAbility(mob) == true and multiSpell < 4 then
        mob:setSpellList(0)
        local spell = math.random(1,3)
        mob:castSpell(nukes[spell])
    elseif spellNum == 2 and utils.canUseAbility(mob) == true and multiSpell < 4 then
        mob:setMod(tpz.mod.MATT, 300)
        local spell = math.random(1,3)
        mob:castSpell(aoe[spell])
    elseif spellNum > 1 and utils.canUseAbility(mob) == true and multiSpell == 4 then
        mob:castSpell()
    elseif spellNum == 1 and multiSpell < 4 then
        mob:setMod(tpz.mod.MATT, 32)
        mob:setMod(tpz.mod.UDMGPHYS, -70)
        mob:setMod(tpz.mod.UDMGRANGE, -70)
        mob:setSpellList(533)
        mob:setLocalVar("spellNum", 0)
    elseif spellNum == 1 then
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setLocalVar("spellNum", 0)
    end


    local canMeteor = mob:getLocalVar("canMeteor")
    local meteor = mob:getLocalVar("meteor")
    if spellNum == 0 and utils.canUseAbility(mob) == true and utils.canUseAbility(partner) == true and multiSpell == 4 and os.time() > meteor and canMeteor ~= 1 then
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

    if mob:getHPP() <= 40 and partner:getLocalVar("skillchainTrigger") == 0 then
        partner:setLocalVar("skillchainTrigger", 1)
        mob:setLocalVar("malisonFirst", 1)
    end

    if partner:getLocalVar("skillchainTrigger") >= 1 and partner:isAlive() then
        local skillchainTime = partner:getLocalVar("skillchainTime")
        local delay = mob:getLocalVar("delay")
        if os.time() > skillchainTime and mob:getLocalVar("malisonFirst") == 1 and partner:getLocalVar("skillchainTrigger") == 1 then
            mob:useMobAbility(2488)
            mob:setLocalVar("malisonFirst", 0)
            partner:setLocalVar("skillchainTrigger", 2)
            partner:setLocalVar("delay", os.time() + 5)
        elseif os.time() > skillchainTime and os.time() >= delay and mob:getLocalVar("malisonFirst") == 0 and partner:getLocalVar("skillchainTrigger") == 3 then
            partner:setLocalVar("skillchainTime", os.time() + math.random(90,120))
            mob:useMobAbility(2489)
            mob:setLocalVar("malisonFirst", 1)
            partner:setLocalVar("skillchainTrigger", 1)
        end
    end

    local delay = mob:getLocalVar("delay")
    if not partner:isAlive() and os.time() > delay then
        mob:useMobAbility(2486)
        mob:setLocalVar("delay", os.time() + math.random(90,120))
    end
end

function onCastStarting(mob, spell)
    local spellNum = mob:getLocalVar("spellNum")
    if spellNum > 1 then
        mob:setLocalVar("spellNum", spellNum - 1)
        spell:castTime(0)
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
    mob:showText(mob, ID.text.SHANTOTTO_DISENGAGE)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:AnimationSub(1)
    mob:setLocalVar("laughTime", os.time() + 8)
end

function onMobDeath(mob, player, isKiller)
    mob:showText(mob, ID.text.SHANTOTTO_DEATH)
    local partner = GetMobByID(mob:getID() + 1)
    if partner:isAlive() then
        partner:setLocalVar("canMeteor", 1)
        partner:setLocalVar("delay", os.time() + 30)
    end
end
