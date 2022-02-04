-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------
require("scripts/globals/utils")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.TELEPORT_CD, 30)
    mob:setMobMod(tpz.mobMod.TELEPORT_START, 988)
    mob:setMobMod(tpz.mobMod.TELEPORT_END, 989)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.MACC, 50)
    mob:addMod(tpz.mod.UFASTCAST, 60)
    mob:addMod(tpz.mod.UDMGMAGIC, -95)
    mob:addMod(tpz.mod.UDMGPHYS, -40)
    mob:addMod(tpz.mod.EVA, 50)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 25)
    mob:addStatusEffect(tpz.effect.REFRESH, 100, 1, 0)
end

function onMobFight(mob, target)
    if os.time() > mob:getLocalVar("nextTeleport") then
        mob:setLocalVar("currentTP", mob:getTP())
        mob:useMobAbility(989) -- Warp Out
        mob:setLocalVar("nextTeleport", os.time() + 20)
    end

    if utils.getTargetDistance(mob, target) >= 3 then
        if os.time() > mob:getLocalVar("nextSpellCast") then
            mob:castSpell()
            mob:setLocalVar("nextSpellCast", os.time() + 10)
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local skillId = skill:getID()
    if skillId == 988 or 989 then -- Warp In or Out Restore TP
        mob:setTP(mob:getLocalVar("currentTP"))
    end
end

function onMobDeath(mob, player, isKiller)
end
