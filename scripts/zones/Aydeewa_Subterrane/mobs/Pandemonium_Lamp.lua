-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Pandemonium Warden Pet
-----------------------------------
-- mixins = {require("scripts/mixins/families/avatar")}
-----------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -101)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
end

-- cloned from apoc beast (Dyna-Bubu) astral flow workaround
function onMobEngaged(mob, target)
    -- 6:34 to 6:46 in this video: https://www.youtube.com/watch?v=T_Us2Tmlm-E
    -- shows approx 12-second delay on astral flow
    mob:timer(12000, function(mob)
        local abilityID = 0
        local modelID = mob:getModelId()
        switch (modelID) : caseof
        {
                [791] = function (x) abilityID = 919 end, -- Carbuncle
                [792] = function (x) abilityID = 839 end, -- Fenrir
                [793] = function (x) abilityID = 913 end, -- Ifrit
                [794] = function (x) abilityID = 914 end, -- Titan
                [795] = function (x) abilityID = 915 end, -- Leviathan
                [796] = function (x) abilityID = 916 end, -- Garuda
                [797] = function (x) abilityID = 917 end, -- Shiva
                [798] = function (x) abilityID = 918 end, -- Ramuh
        }
        if abilityID > 0 then
            mob:useMobAbility(abilityID)

            mob:timer(2000, function(mobArg)
                mobArg:setUnkillable(false)
                mobArg:setHP(0)
            end)
        end
    end)
end

function onMobDeath(mob, player, isKiller)
    -- cleanup quickly since spawning is blocked until mob is fully despawned
    DespawnMob(mob:getID())
end