-----------------------------------
-- Area: Horlais Peak
--  Mob: Chlevnik
-- KSNM99
-----------------------------------

require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:AnimationSub(3)
    mob:setUnkillable(true)
    mob:addMod(tpz.mod.DEFP, 20)
    mob:addMod(tpz.mod.ATTP, 10)
    mob:addMod(tpz.mod.STUNRESTRAIT, 99)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 99)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.MDEF, -20)
    mob:setTP(3000) -- opens fight with a skill
    mob:addListener("TAKE_DAMAGE", "CHLEVNIK_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if amount >= mob:getHP() then

            forceTPMove(mob)
            
        end
    end)
end

function onMobFight(mob, target)
    if mob:getHPP() > 25 then
        mob:setMod(tpz.mod.REGAIN, 80)
    else
        mob:setMod(tpz.mod.REGAIN, 50)
    end
    
    local delay = mob:getLocalVar("delay")
        if (delay > 75) then -- Use Meteor every 30s, based on capture
                mob:castSpell(218) -- meteor
                mob:setLocalVar("delay", 0)
            else
                mob:setLocalVar("delay", delay+1)
        end

    if mob:getLocalVar("Meteor") == 1 then
        if mob:checkDistance(target) > 40 then
            mob:resetEnmity(target)
        else
            mob:useMobAbility(634) -- Final Meteor
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {power = math.random(7, 8), chance = 20}) --based on captures
end

 function onMobWeaponSkill(target, mob, skill)
    local tick = mob:getLocalVar("tick") 
    
    if skill:getID() == 634 then   
            mob:setUnkillable(false)
            mob:setLocalVar("Meteor", 0)
            mob:setHP(0)
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
            mob:AnimationSub(1)      
    end


 end

function onSpellPrecast(mob, spell)
    if spell:getID() == 218 then
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

function forceTPMove(mob, target)
    mob:setUnkillable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:setLocalVar("Meteor", 1)
end

function onMobDeath(mob, player, isKiller)

end