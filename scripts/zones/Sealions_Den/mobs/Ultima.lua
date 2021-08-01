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
end

function onMobFight(mob, target)
    -- Gains regain at under 25% HP
    if mob:getHPP() < 25 and not mob:hasStatusEffect(tpz.effect.REGAIN) then
        mob:addStatusEffect(tpz.effect.REGAIN, 5, 3, 0)
        mob:getStatusEffect(tpz.effect.REGAIN):setFlag(tpz.effectFlag.DEATH)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {duration = 60})
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.ULTIMA_UNDERTAKER)
    player:setLocalVar("[OTBF]cs", 0)
end
