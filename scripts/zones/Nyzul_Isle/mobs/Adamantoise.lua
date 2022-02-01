------------------------------------------
-- Adamantoise in Nyzul Isle
------------------------------------------

function onMobDeath(mob, player, isKiller)
    -- gating this to be called only once - as there should only be one killer per mob
    if (isKiller) then
        local floor = mob:getInstance():getStage()
        local lootPool = 0
        -- can only spawn on 20 or 40
        if (floor == 20 or floor == 21) then
            lootPool = 71
        else
            lootPool = 148
        end

        mob:setDropID(lootPool)
    end
end