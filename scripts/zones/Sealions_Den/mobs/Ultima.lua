-----------------------------------
-- Area: Sealions Den
--   NM: Ultima
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    local order = mob:setLocalVar("order", 0)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 30)
end


-- Ultima has a low likelyhood of using particle shield during phase 1 (Compared to his other abilities)
function onMobWeaponSkillPrepare(mob, target)
    if mob:getHPP() > 75 then
        local checker = math.random()
        if checker < 0.50 then 
            return 1259 
        elseif checker < 0.75 then
            return 1269
        else
            return 1270 
        end
    end

    if mob:getHPP() < 20 then

        local order = mob:getLocalVar("order")       
        
        if order == 0 then
            mob:setLocalVar("order", 1)
            return 1270
        elseif order == 1 then
            mob:setLocalVar("order", 2)
            return 1260    
        else
            mob:setLocalVar("order", 0)
            return 1260  
        end
    end

end

function onMobFight(mob, target)
    -- Gains regain at under 25% HP
    if mob:getHPP() < 25 and not mob:hasStatusEffect(tpz.effect.REGAIN) then
        mob:addStatusEffect(tpz.effect.REGAIN, 5, 3, 0)
        mob:getStatusEffect(tpz.effect.REGAIN):setFlag(tpz.effectFlag.DEATH)
    end

    if mob:getHPP() < 20 then
        mob:setMod(tpz.mod.REGAIN, 500)
    end


    if mob:getLocalVar("nuclearWaste") == 1 then
        local ability = math.random(1262,1267)
        mob:useMobAbility(ability)
        mob:setLocalVar("nuclearWaste", 0)
    end
    
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {duration = 60})
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.ULTIMA_UNDERTAKER)
    player:setLocalVar("[OTBF]cs", 0)
end
