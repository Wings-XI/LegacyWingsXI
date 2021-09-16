-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Prudence
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "PRUDENCE_MIMIC_START", function(mob, skillID)
        local pOne = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
        local pTwo = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
        local pAct = mob:getCurrentAction()
        local prudenceIDs = { 16912846, 16912847 }
        if mob:getLocalVar('[JoP]mimic') ~= 1 then
            for _, jailer in ipairs(prudenceIDs) do
                if mob:getID() ~= jailer then
                    local prudence_mimic = GetMobByID(jailer)
                    if prudence_mimic ~= nil and pAct > 0 and utils.canUseAbility(mob) == true and mob:checkDistance(prudence_mimic) <= 10 then
                        prudence_mimic:setLocalVar('[JoP]mimic', 1)
                        prudence_mimic:useMobAbility(skillID)
                        if skillID == 693 then prudence_mimic:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 30) end
                    end
                end
            end
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "PRUDENCE_MIMIC_STOP", function(mob, skillID)
        mob:setLocalVar('[JoP]mimic', 0)
    end)
end

function onMobSpawn(mob)
    mob:resetLocalVars()
    mob:AnimationSub(0) -- Mouth closed
    mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 60)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
    mob:setMod(tpz.mod.REGEN, 10)
end

function Teleport(mob, hideDuration)
    if mob:isDead() then
        return
    end
    mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 60)
    mob:hideName(true)
    mob:untargetable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:setStatus(tpz.status.INVISIBLE)

    hideDuration = hideDuration or 500

    if hideDuration < 500 then
        hideDuration = 500
    end

    mob:timer(hideDuration, function(mob)
        mob:hideName(false)
        mob:untargetable(false)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)

        if mob:isDead() then
            return
        end

        mob:setStatus(tpz.status.UPDATE)
    end)
end


function onMobFight(mob, target)
    if mob:checkDistance(mob:getTarget()) >= 12 then
        -- local targetPos = target:getPos()
        Teleport(mob, 1000)
        -- mob:setPos(targetPos.x, targetPos.y, targetPos.Z) mobs should not actually teleport, just flee quickly to target
    end

    local perfectDodgeHPP =
    {
        95, 85, 75, 65, 55, 45, 35, 25, 15, 5,
    }

    local perfectDodgeTrigger = mob:getLocalVar("perfectDodgeTrigger")
    local perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue")
    local mobHPP = mob:getHPP()
    for trigger, hpp in ipairs(perfectDodgeHPP) do
        if mobHPP < hpp and perfectDodgeTrigger < trigger then
            mob:setLocalVar("perfectDodgeTrigger", trigger)
            mob:setLocalVar("perfectDodgeQueue", perfectDodgeQueue + 1)
            break
        end
    end

    if mob:actionQueueEmpty() == true and utils.canUseAbility(mob) == true then
        local perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue")
        if perfectDodgeQueue > 0 then
            local perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue") - 1
            if not mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
                mob:setLocalVar("twohour_tp", mob:getTP())
                mob:useMobAbility(693)
                mob:setLocalVar("perfectDodgeQueue", perfectDodgeQueue)
            end
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 693 then
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local firstPrudence = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
    if (mob:getID() == ID.mob.JAILER_OF_PRUDENCE_1) then
        secondPrudence:setMobMod(tpz.mobMod.NO_DROPS, 0)
        secondPrudence:AnimationSub(3) -- Mouth Open
        secondPrudence:addMod(tpz.mod.DELAY, 500)
        secondPrudence:addMod(tpz.mod.ATTP, 100)
        secondPrudence:delMod(tpz.mod.DEFP, -50)
    else
        firstPrudence:setMobMod(tpz.mobMod.NO_DROPS, 0)
        firstPrudence:AnimationSub(3) -- Mouth Open
        firstPrudence:addMod(tpz.mod.DELAY, 500)
        firstPrudence:addMod(tpz.mod.ATTP, 100)
        firstPrudence:delMod(tpz.mod.DEFP, -50)
    end
end
