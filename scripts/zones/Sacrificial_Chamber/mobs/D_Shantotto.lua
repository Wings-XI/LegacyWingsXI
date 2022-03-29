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
    mob:setMod(tpz.mod.DARKRES, 100)
    mob:setMod(tpz.mod.EARTHRES, 100)
    mob:setMod(tpz.mod.ICERES, 100)
    mob:setMod(tpz.mod.WATERRES, 100)
    mob:setMod(tpz.mod.FASTCAST, 50)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar("multiMove", 0)
    mob:setLocalVar("moveNum", 0)
    mob:setLocalVar("salvationFirst", 0)
    mob:setLocalVar("skillchainTrigger", 0)
    mob:setLocalVar("delay", os.time())
end

function onMobEngage(mob, target)
    -- mob:showText(mob, ID.text.DSHANTOTTO_ENGAGE)
end

function onMobFight(mob, target)
    local multiMove = mob:getLocalVar("multiMove")
    local moveNum = mob:getLocalVar("moveNum")

    if mob:getHPP() <= 75 and multiMove == 0 and utils.canUseAbility(mob) == true and moveNum == 0 then
        mob:useMobAbility(627)
        -- mob:showText(mob, ID.text.DSHANTOTTO_75)
        mob:setLocalVar("multiMove", 1)
        mob:setLocalVar("moveNum", 4)
    elseif mob:getHPP() <= 50 and multiMove == 1 and utils.canUseAbility(mob) == true and moveNum == 0 then
        mob:useMobAbility(627)
        -- mob:showText(mob, ID.text.DSHANTOTTO_50)
        mob:setLocalVar("multiMove", 2)
        mob:setLocalVar("moveNum", 4)
    elseif mob:getHPP() <= 25 and multiMove == 2 and utils.canUseAbility(mob) == true and moveNum == 0 then
        mob:useMobAbility(627)
        -- mob:showText(mob, ID.text.DSHANTOTTO_25)
        mob:setLocalVar("multiMove", 3)
        mob:setLocalVar("moveNum", 4)
    end

    if moveNum > 0 and utils.canUseAbility(mob) == true then
        local move = math.random(96,102)
        mob:useMobAbility(move)
        mob:setLocalVar("moveNum", moveNum - 1)
    end

    if mob:getHPP() <= 60 and mob:getLocalVar("skillchainTrigger") == 0 then
        mob:setLocalVar("skillchainTrigger", 1)
        mob:setLocalVar("salvationFirst", 1)
    end

    if mob:getLocalVar("skillchainTrigger") == 1 then
        local partner = GetMobByID(mob:getID() - 1)
        local skillchainTime = partner:getLocalVar("skillchainTime")
        local salvationFirst = mob:getLocalVar("salvationFirst")
        local delay = partner:getLocalVar("delay")
        -- print(partner:getID())
        -- print(delay)
        if os.time() > skillchainTime and os.time() < delay then
            print("time is okay")
        end
        if os.time() > skillchainTime and utils.canUseAbility(mob) == true and salvationFirst == 1 then
            print("true1")
            mob:useMobAbility(2486)
            mob:setLocalVar("salvationFirst", 0)
            mob:setLocalVar("delay", os.time() + 5)
        elseif os.time() > skillchainTime and utils.canUseAbility(mob) == true and salvationFirst == 0 and os.time() < delay then
            print("true2")
            partner:setLocalVar("skillchainTime", os.time() + math.random(30,60))
            mob:useMobAbility(2486)
            mob:setLocalVar("salvationFirst", 1)
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)
    -- mob:showText(mob, ID.text.DSHANTOTTO_DISENGAGE)
end

function onMobDeath(mob, player, isKiller)
end
