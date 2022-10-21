-----------------------------------
-- Area: Dyna-Bubu
--  Mob: Apoc Beast Astral Flow
-----------------------------------
-- mixins = {require("scripts/mixins/families/avatar")}
-----------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob, player, isKiller)
    mob:setModelId(math.random(791, 798))
    mob:timer(1000, function(mob)
        local abilityID = nil
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
        mob:useMobAbility(abilityID)
    end)
    mob:timer(2000, function(mob)
        mob:setUnkillable(false)
        mob:setHP(0)
    end)
end
