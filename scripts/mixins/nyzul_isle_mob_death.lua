-- Nyzul Isle Mob Death Mixin
require("scripts/globals/status")
require("scripts/globals/mixins")
require("scripts/globals/nyzul_isle_armoury_crates")


g_mixins = g_mixins or {}

---------------------------------------------------------
-- Amoury Crate check  (may expand to push instance progress)
---------------------------------------------------------
g_mixins.nyzul_isle_mob_death = function(mob)
    mob:addListener("DEATH", "DEATH_NYZUL_ISLE", function(mob, player, isKiller)
        local mobPos = mob:getPos()

        if mob:getMaster() ~= nil then
            local master = mob:getMaster()
            if master:isMob() then -- sanity check, ensuring the mob killed is not a player's pet.
                tpz.nyzul_isle_armoury_crates.spawnArmouryCrateOnMobDeath(mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            end
        else
            tpz.nyzul_isle_armoury_crates.spawnArmouryCrateOnMobDeath(mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
        end
    end)
end

return g_mixins.nyzul_isle_mob_death
