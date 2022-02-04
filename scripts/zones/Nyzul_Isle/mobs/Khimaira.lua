------------------------------------------
-- Khimaira in Nyzul Isle
------------------------------------------
require("scripts/globals/nyzul_isle_data")
------------------------------------------
function onMobDeath(mob, player, isKiller)
    -- gating this to be called only once - as there should only be one killer per mob
    if (isKiller) then
        local instance = mob:getInstance()
        local floor = instance:getStage()
        local lootPool = 0

        -- can only spawn on 60 or 80 or 100
        if (floor == 60 or floor == 61) then
            lootPool = 164
        elseif (floor == 80 or floor == 81) then
            lootPool = 181
        else -- floor 100
            lootPool = 303
            local forcedVigilWeapon = tpz.nyzul_isle_data.jobToVigilWeaponMap[instance:getLocalVar("Nyzul_DiscUserJob")]
            if (forcedVigilWeapon and forcedVigilWeapon > 0) then
                player:addTreasure(forcedVigilWeapon, mob)
            end
        end

        mob:setDropID(lootPool)
    end
end