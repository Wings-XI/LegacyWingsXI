-----------------------------------
-- Area: The Ashu Talif
--   NM: Swiftwinged Gekko
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_REST, 1)
end


function onMobFight(mob, target)
    local mobPos = mob:getPos()

    if mobPos.x == 5.5 and mobPos.y == -31 and mobPos.z == 47 then
        mob:hideName(true)
        mob:untargetable(true)
        mob:setUnkillable(true)
        mob:setStatus(tpz.status.INVISIBLE)
        mob:disengage()
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:setPos(0.000, -22.500, 18.000)

        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)
    end
end

function onCastStarting(mob, spell)
    mob:setUnkillable(false)
    mob:SetMagicCastingEnabled(false)
    mob:pathTo(5.500, -31.000, 47.000)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

function onMobDeath(mob, player, isKiller)
end
