-----------------------------------
-- Area: Horlais Peak
--  Mob: Fighting Sheep
-- BCNM: Hostile Herbivores
-- Note: melee attacks cause knockback. This is handled as a mobskill substitution.
-----------------------------------
require("scripts/globals/status")
-----------------------------------


function onMobInitialize(mob)
    mob:setMod(tpz.mod.ICERES, 75)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
end

function onAdditionalEffect(mob, target, damage)
    -- uses sheep charge for zero dmg to apply knockback
    mob:setLocalVar("skill_tp", mob:getTP())
    mob:useMobAbility(274, target)
end

function onMobSpawn(mob)
    -- mob:SetMobSkillAttack(701)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.HASTE_GEAR, 5000) -- 50% haste
end


function onMobDeath(mob, player, isKiller)
end

function onMobWeaponSkill(target, mob, skill)
    -- logic from lsb upstream
    if skill:getID() == 274 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end