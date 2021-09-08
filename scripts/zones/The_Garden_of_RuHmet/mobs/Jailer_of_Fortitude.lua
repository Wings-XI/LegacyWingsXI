-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Fortitude
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/settings")
require("scripts/globals/limbus")
require("scripts/globals/status")
require("scripts/globals/magic")

function onMobSpawn(mob)
    -- Change animation to humanoid w/ prismatic core
    mob:AnimationSub(1)
    mob:setModelId(1169)
    mob:setMod(tpz.mod.MDEF, 75)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("delay", 0)
    mob:setLocalVar("LAST_CAST", 0)
    mob:setLocalVar("COPY_SPELL", 0)
    mob:setLocalVar("twoHourCd", 0)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 2 do -- Kf'ghrah share hate with Jailer of Fortitude
        GetMobByID(i):updateEnmity(target)
    end
end

function onMobFight(mob, target)

    local delay = mob:getLocalVar("delay")
    local LastCast = mob:getLocalVar("LAST_CAST")
    local spell = mob:getLocalVar("COPY_SPELL")

    if (mob:getBattleTime() - LastCast > 30) then
        mob:setLocalVar("COPY_SPELL", 0)
        mob:setLocalVar("delay", 0)
    end

    if (not GetMobByID(ID.mob.KFGHRAH_WHM):isDead() or not GetMobByID(ID.mob.KFGHRAH_BLM):isDead()) then -- check for kf'ghrah
        if (spell > 0 and not mob:hasStatusEffect(tpz.effect.SILENCE)) then
            if (delay >= 3) then
                mob:castSpell(spell)
                mob:setLocalVar("COPY_SPELL", 0)
                mob:setLocalVar("delay", 0)
            else
                mob:setLocalVar("delay", delay+1)
            end
        end
    end

    -- Jailer of Fortitude does not use Invincible until he is below 50% HP and both Ghrah adds are dead.
    -- He will immediately use invincible upon both of them dying then again 3 minutes later.
    local canTwoHour = mob:getLocalVar("canTwoHour")
    local twoHourCd = mob:getLocalVar("twoHourCd")
    local battleTime = mob:getBattleTime()
    for i = ID.mob.KFGHRAH_WHM, ID.mob.KFGHRAH_BLM do
        local kfgrah = GetMobByID(i)
        if not kfgrah:isAlive() and mob:getHPP() < 50 and canTwoHour == 0 then
            mob:setLocalVar("canTwoHour", 1) -- both Kf'ghrah dead, first invincible 
        end
    end

    if mob:getLocalVar("canTwoHour") == 1 then
        if battleTime - twoHourCd > 180 then -- second invincible roughly 3 minutes after the first
            mob:setLocalVar("twoHourCd", mob:getBattleTime())
            mob:useMobAbility(694)
        end
    end
end

function onMagicHit(caster, target, spell)
    if (spell:tookEffect() and (caster:isPC() or caster:isPet()) and spell:getSpellGroup() ~= tpz.magic.spellGroup.BLUE ) then
        -- Handle mimicked spells -- TODO:Fortitude should not mimmick Enfeebling Spells, currently unable to filter them out.
        target:setLocalVar("COPY_SPELL", spell:getID())
        target:setLocalVar("LAST_CAST", target:getBattleTime())
        target:AnimationSub(1)
    end

    return 1
end

function onMobDeath(mob, player, isKiller)
    -- Despawn the pets if alive
    DespawnMob(ID.mob.KFGHRAH_WHM)
    DespawnMob(ID.mob.KFGHRAH_BLM)
end

function onMobDespawn(mob)
    -- Move QM to random location
    local pos = math.random(1, 5)
    GetNPCByID(ID.npc.JAILER_OF_FORTITUDE_QM):setPos(ID.npc.JAILER_OF_FORTITUDE_QM_POS[pos][1], ID.npc.JAILER_OF_FORTITUDE_QM_POS[pos][2], ID.npc.JAILER_OF_FORTITUDE_QM_POS[pos][3])
end
