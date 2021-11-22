-----------------------------------
-- Area: Altar Room 
-- NM: Fee Jugu The Ramfist
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
        mob:SetMobAbilityEnabled(false)
    else
        mob:SetMobAbilityEnabled(true)
    end
end

function onMobDeath(mob, player, isKiller)
end
