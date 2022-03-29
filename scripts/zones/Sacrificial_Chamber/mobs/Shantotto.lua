-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Shantotto
-- ASA 13 Project: Shantottofication
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.LIGHTRES, 100)
    mob:setMod(tpz.mod.FASTCAST, 50)
    mob:setLocalVar("multiSpell", 0)
    mob:setLocalVar("spellNum", 0)
    mob:setLocalVar("malisonTime", 0)
    mob:setLocalVar("skillchainTime", 0)
    mob:setLocalVar("malisonFirst", 0)
end

function onMobEngage(mob, target)
    -- mob:showText(mob, ID.text.SHANTOTTO_ENGAGE)
end

function onMobFight(mob, target)
    local multiSpell = mob:getLocalVar("multiSpell")
    local spellNum = mob:getLocalVar("spellNum")

    if mob:getHPP() <= 75 and multiSpell == 0 and spellNum == 0 then
        mob:useMobAbility(627)
        -- mob:showText(mob, ID.text.SHANTOTTO_75)
        mob:setLocalVar("multiSpell", 1)
        mob:setLocalVar("spellNum", 5)
        mob:setSpellList(534)
    elseif mob:getHPP() <= 50 and multiSpell == 1 and spellNum == 0 then
        mob:useMobAbility(627)
        -- mob:showText(mob, ID.text.SHANTOTTO_50)
        mob:setLocalVar("multiSpell", 2)
        mob:setLocalVar("spellNum", 5)
        mob:setSpellList(534)
    elseif mob:getHPP() <= 25 and multiSpell == 2 and spellNum == 0 then
        mob:useMobAbility(627)
        -- mob:showText(mob, ID.text.SHANTOTTO_25)
        mob:setLocalVar("multiSpell", 3)
        mob:setLocalVar("spellNum", 5)
        mob:setSpellList(534)
    end

    if spellNum > 0 then
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, -30)
        mob:setLocalVar("spellNum", spellNum - 1)
    elseif spellNum == 0 then
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
        mob:setSpellList(533)
    end

    local partner = GetMobByID(mob:getID() + 1)
    if mob:getHPP() <= 60 and partner:getLocalVar("skillchainTrigger") == 0 then
        partner:setLocalVar("skillchainTrigger", 1)
        mob:setLocalVar("malisonFirst", 1)
    end

    if partner:getLocalVar("skillchainTrigger") == 1 then
        -- print("belleTrue")
        local skillchainTime = mob:getLocalVar("skillchainTime")
        local malisonFirst = mob:getLocalVar("malisonFirst")
        local delay = partner:getLocalVar("delay")
        -- print(malisonFirst)
        if os.time() > skillchainTime and utils.canUseAbility(mob) == true and malisonFirst == 1 then
            print("malisonfirst")
            mob:useMobAbility(2488)
            mob:setLocalVar("delay", os.time() + 5)
            mob:setLocalVar("malisonFirst", 0)
        elseif os.time() > skillchainTime and utils.canUseAbility(mob) == true and malisonFirst == 0 and os.time() < delay then
            print("belleTrue")
            mob:setLocalVar("skillchainTime", os.time() + math.random(30,60))
            mob:useMobAbility(2488)
            mob:setLocalVar("malisonFirst", 1)
        end
    end
end

function onMonsterMagicPrepare(mob, target)
    local spellNum = mob:getLocalVar("spellNum")
    if spellNum > 0 then
        mob:setLocalVar("spellNum", spellNum - 1)
    end

    local chance = math.random(1,10)
    if mob:getHPP() <= 10 and chance == 1 and spellNum == 0 then
        return 218
    end
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)
    -- mob:showText(mob, ID.text.SHANTOTTO_DISENGAGE)
end

function onMobDeath(mob, player, isKiller)
end
