-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Hope
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setSpellList(0) -- If it dies with the ability to cast spells, the next spawn would be able to cast from the start.
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20) -- This gives around 6 - 15 seconds between casts. Doesn't seem to work anywhere except in this function.
    mob:AnimationSub(5)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setMod(tpz.mod.MATT, 75)
    mob:setMod(tpz.mod.INT, 4)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 90, hpp = math.random(85, 95)}, -- "May use Mighty Strikes multiple times."
        },
    })
end

function onMobEngaged(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    mob:AnimationSub(6)
    mob:resetLocalVars()
end

function onMobFight(mob, target)
    if mob:getLocalVar("spellTime") < os.time() and mob:getLocalVar("spellTime") ~= 0 then -- Checks for it being 0 because it gets set to 0 to avoid setting the spell list repeatedly
        mob:setSpellList(0)
        mob:setLocalVar("spellTime", 0)
    end
end

function onSpellPrecast(mob, spell)
    if spell:getID() == 196 or 213 then
        spell:setMPCost(1)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    local rnd = math.random()
    if rnd < 0.5 then -- uses Aerial Collision 50%~ of the time
        return 1353 -- Aerial Collision
    elseif rnd < 0.65 then
        return 1355 -- Spine Lash
    elseif rnd < 0.80 then
        return 1356 -- Voiceless Storm
    else
        return 1358 -- Plasma Charge
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1358 then -- Set spell list for Burst2/Thundaga3 upon using Plasma Charge. Allow for 60 seconds.
        mob:setSpellList(140)
        mob:setLocalVar("spellTime", os.time() + 60)
    end

    local aerialCollisionCounter = mob:getLocalVar("aerialCollisionCounter")
    local aerialCollisionMax = mob:getLocalVar("aerialCollisionMax")
    if skill:getID() == 1353 then
        if aerialCollisionCounter == 0 and aerialCollisionMax == 0 then
            aerialCollisionMax = 1
            mob:setLocalVar("aerialCollisionMax", aerialCollisionMax)
        end

        aerialCollisionCounter = aerialCollisionCounter + 1
        mob:setLocalVar("aerialCollisionCounter", aerialCollisionCounter)

        if aerialCollisionCounter > aerialCollisionMax then
            mob:setLocalVar("aerialCollisionCounter", 0)
            mob:setLocalVar("aerialCollisionMax", 0)
        else
            mob:timer(3000, function(mob)
                mob:useMobAbility(1353)
            end)
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 65, duration = math.random(4, 8)})
end

function onMobDeath(mob, player, isKiller)
end
