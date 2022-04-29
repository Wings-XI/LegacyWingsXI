-----------------------------------
-- Area: Carpenters_Landing
--  Mob: Overgrown Ivy
-----------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.REGAIN, 50)
end

function onMobFight(mob, target)
    -- Capture shows Ivy uses 5x bad breath when it falls below 20% then resumes normal attacks and TP moves
    local BadBreaths = mob:getLocalVar("BadBreaths")

    if mob:getCurrentAction() == tpz.act.ATTACK then
        if BadBreaths == 0 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("BadBreaths", BadBreaths + 1)
        elseif BadBreaths == 1 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("BadBreaths", BadBreaths + 1)
        elseif BadBreaths == 2 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("BadBreaths", BadBreaths + 1)
        elseif BadBreaths == 3 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("BadBreaths", BadBreaths + 1)
        elseif BadBreaths == 4 and mob:getHPP() <= 20 then
            mob:setLocalVar("BadBreaths", BadBreaths + 1)
            mob:useMobAbility(319)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("EMERALD_WATERS_Status") == 4) then
        player:setCharVar("EMERALD_WATERS_Status", 5)
    end
end
