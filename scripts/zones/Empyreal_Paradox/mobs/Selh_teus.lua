-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Selh'teus
-- Chains of Promathia 8-4 BCNM Fight
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
-----------------------------------

function onMobInitialize(mob)
    mob:SetAutoAttackEnabled(false)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGAIN, 100)
    mob:addMod(tpz.mod.UDMGMAGIC, -40)
    mob:addMod(tpz.mod.UDMGPHYS, -70)
    -- so he can hit promathia with lance and evade a bit more
    mob:setMod(tpz.mod.RACC, 150)
    mob:setMod(tpz.mod.AGI, 150)
    mob:addMod(tpz.mod.CURE_POTENCY_RCVD, -100)
end

function onMobFight(mob, target)
    -- flies around to same relative spot to promathia's position/rotation
    if target:getHPP() > 5 and target:getTarget() and target:getTarget():getID() ~= mob:getID() then
        local targetPos = target:getPos()
        local radians = (256 - targetPos.rot) * (math.pi / 128)
        mob:pathTo(targetPos.x + math.cos(radians) * 16, targetPos.y, targetPos.z + math.sin(radians) * 16)
    end
    local lanceTime = mob:getLocalVar("lanceTime")
    local lanceOut = mob:getLocalVar("lanceOut")
    local rejuv = mob:getLocalVar("rejuv")
    if mob:getHPP() < 30 and rejuv == 0 then
        mob:messageText(mob, ID.text.SELHTEUS_TEXT + 2)
        mob:setLocalVar("rejuv", 1)
        mob:useMobAbility(1509)
    elseif lanceTime + 35 < mob:getBattleTime() and lanceOut == 0 then
        mob:entityAnimationPacket("sp00")
        mob:setLocalVar("lanceOut", 1)
    end
end

function onMobDeath(mob, player, isKiller)
    mob:messageText(mob, ID.text.SELHTEUS_TEXT)
    mob:getBattlefield():lose()
end
