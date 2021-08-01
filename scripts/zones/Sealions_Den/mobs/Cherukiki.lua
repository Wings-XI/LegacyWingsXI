-----------------------------------
-- Area: Sealion's Den
--  Mob: Cherukiki
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Sealions_Den/IDs")
mixins = {require("scripts/mixins/warriors_path_taru")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 60) -- cherukiki casts magic aproximately every 25 seconds
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:addMod(tpz.mod.UDMGPHYS, -100)
    mob:addMod(tpz.mod.UDMGMAGIC, -100)
    mob:addMod(tpz.mod.UDMGRANGE, -100)
    mob:addMod(tpz.mod.UDMGBREATH, -100)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setLocalVar("cheru", 1)
end

function onMobInitialize(mob)
end

function onMobEngaged(mob, target)
    mob:entityAnimationPacket("ouen") -- each taru will use this animation at the start of the fight
    mob:setMobMod(tpz.mobMod.NO_LINK, 0)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 0)
    mob:AnimationSub(1)
end

function onMobFight(mob, target)
    local bfID  = mob:getBattlefield():getArea()
    local tenzen_id = GetMobByID(ID.aWarriorsPath[bfID].TENZEN_ID)
    if tenzen_id:getHPP() <= 70 then
        if mob:getLocalVar("cooldown") == 0 then
            mob:castSpell(4, GetMobByID(ID.aWarriorsPath[bfID].TENZEN_ID))
            mob:setLocalVar("cooldown", 70) -- every 30 seconds Cherukiki will cast Cure IV on tenzen
        end
    else
        mob:setLocalVar("cooldown", 70)
    end
    if mob:getLocalVar("cooldown") > 0 then
        mob:setLocalVar("cooldown", mob:getLocalVar("cooldown") - 1)
    end
end

function onMobDisengage(mob, target)
    mob:AnimationSub(2) -- laughing pose
end

function onMobDeath(mob, player, isKiller)
end