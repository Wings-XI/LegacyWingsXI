-----------------------------------
--   Area: Caedarva Mire
--    Mob: T3 ZNM - Mahjlaef the Paintorn
-- Author: Spaceballs / Chiefy
-----------------------------------

mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")}

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 16) 
end


function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                 -- 90 minutes
    mob:setLocalVar("Shields", 0)                   
    mob:SetAutoAttackEnabled(true)   
    mob:setSpellList(000) -- Basic single target T3s
    mob:setMod(tpz.mod.DMGPHYS, 0)
end   

function onMobFight(mob, target)
    local shields = mob:getLocalVar("Shields")
    
    if mob:hasStatusEffect(tpz.effect.MAGIC_SHIELD) == 0 and shields = 2 then  -- Just lost first shield
        mob:setMod(tpz.mod.RAMPART_STONESKIN, 2000)
        mob:AnimationSub(1)
        mob:setSpellList(111) -- Ga2s, AM1
        mob:setLocalVar("Shields", 1)
    elseif mob:hasStatusEffect(tpz.effect.MAGIC_SHIELD) == 0 and shields = 1 then  -- Just lost second shield
        local hpp = mob:getHPP()
        mob:setSpellList(000) -- Basic single target T3s 
        mob:SetAutoAttackEnabled(true) 
        mob:setMod(tpz.mod.DMGPHYS, 0)
        mob:setLocalVar("Shields", 0)
        mob:AnimationSub(0)
        mob:setTP(0)
        
        if hpp < 25
            mob:useMobAbility(1111) -- ASCAR Reprobation
        else
            mob:useMobAbility(2222) -- MINDPURGE
        end
    end
end


function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 0000 then -- Immortal Shield
        mob:setLocalVar("Shields", 2)
        mob:SetAutoAttackEnabled(false)  
        mob:setSpellList(222) -- AM2, Ga3
        mob:setMod(tpz.mod.DMGPHYS, 85)
    end
end


function onMobDeath(mob)
end