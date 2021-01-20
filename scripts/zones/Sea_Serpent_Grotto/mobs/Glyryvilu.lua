-----------------------------------
-- Area: Sea Serpent Grotto
-- Mob: Glyryvilu
-- Note: Popped by qm5
-- !pos 135 -9 220 176
-- Involved in Quest: An Undying Pledge
-----------------------------------


function onMobDeath(mob, player, isKiller)
    if player:getCharVar("anUndyingPledgeCS") == 2 then
        player:setCharVar("anUndyingPledgeNM_killed", 1)
    end
end
