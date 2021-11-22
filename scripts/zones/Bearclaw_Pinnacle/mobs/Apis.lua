-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Eldertaur
--  ENM: Brothers
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGRANGE, -100)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    mob:setMod(tpz.mod.UDMGPHYS, -100)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("colorChange" + 60)
    mob:setLocalVar("currentColor", math.random(1, 3))
end

function onMobFight(mob, target)
    local currentColor = mob:getLocalVar("currentColor")
    local abilities = { 624, 625, 627 }
    local i = 1
    for k, ability in pairs(abilities) do
        if i == currentColor and os.time() > mob:getLocalVar("colorChange") then
            mob:setLocalVar("currentColor", math.random(1, 3))
        elseif i ~= currentColor and os.time() > mob:getLocalVar("colorChange") then
            mob:useMobAbility(abilities[currentColor])
            mob:setLocalVar("currentColor", math.random(1, 3))
            mob:setLocalVar("colorChange", os.time() + math.random(60, 90))
            mob:setLocalVar("twohour_tp", mob:getTP())
        end
        i = i + 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 624 then -- blue: High ATK, double and triple attack. High magic immunity
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 35)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 35)
        mob:setMod(tpz.mod.ATT, 2000)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, -98)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end

    if skill:getID() == 625 then -- yellow: Moderate ATK, takes lowered phys and magic damage
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
        mob:setMod(tpz.mod.ATT, 1000)
        mob:setMod(tpz.mod.UDMGRANGE, -30)
        mob:setMod(tpz.mod.UDMGMAGIC, -30)
        mob:setMod(tpz.mod.UDMGPHYS, -30)
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end

    if skill:getID() == 627 then -- green: Low ATK, High physical immune.
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
        mob:setMod(tpz.mod.ATT, 500)
        mob:setMod(tpz.mod.UDMGRANGE, -98)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGPHYS, -98)
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end
end

function onMobDeath(mob, player, isKiller)
end