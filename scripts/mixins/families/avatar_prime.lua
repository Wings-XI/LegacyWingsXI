
--[[ -----------------------------
Prime Avatars special abilities.

params is a table that can contain the following keys:
    between    : Number of seconds betwen using any specials. Only matters if mob has multiple specials.
    chance     : Percent chance that a mob will use a special at all during engagement. (0 to 100)
    delay      : Grace period at start of fight, during which a mob not use any special, regardless of HPP. Min-clamped at 2 to avoid insta-flow. (2 to any)
    specials   : Table of job specials, with each entry a table that can contain the following keys:
      id       : the job ability ID (see tpz.jobSpecialAbility definition in scripts/globals/status.lua). Required.
      cooldown : cooldown in seconds for this special. Optional. Default 7200.
      duration : duration in seconds for specials that apply a status effect for a non-standard number of seconds.  Optional.  No default. (1 to any)
      hpp      : mob must be below this HP percent to use this special.  Optional.  Default random 40 to 60. (0 to 100)
      begCode  : callback function before the mob uses its special.
      endCode  : callback function after the mob uses its special.

---------------------------------------------------------------- --]]
require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/utils")
----------------------------------

a_mixins = a_mixins or {}
a_mixins.flow_ability = a_mixins.flow_ability or {}

a_mixins.flow_ability.config = function(mob, params)
    if params.between and type(params.between) == "number" then
        mob:setLocalVar("[jobSpecial]between", utils.clamp(params.between, 0))
    end

    if params.chance and type(params.chance) == "number" then
        mob:setLocalVar("[jobSpecial]chance", utils.clamp(params.chance, 0, 100))
    end

    if params.delay and type(params.delay) == "number" then
        mob:setLocalVar("[jobSpecial]delayInitial", utils.clamp(params.delay, 2))
    end

    if params.specials and type(params.specials) == "table" then
        local specials = params.specials
        local i = 0

        for _, v in pairs(specials) do
            if v.id and type(v.id) == "number" then
                i = i + 1
                mob:setLocalVar("[jobSpecial]ability_" .. i, v.id)

                if v.cooldown and type(v.cooldown) == "number" then
                    mob:setLocalVar("[jobSpecial]between_" .. i, utils.clamp(v.cooldown, 0))
                else
                    mob:setLocalVar("[jobSpecial]between_" .. i, 7200)
                end

                if v.duration and type(v.duration) == "number" then
                    mob:setLocalVar("[jobSpecial]duration_" .. i, utils.clamp(v.duration, 1))
                end

                if v.hpp and type(v.hpp) == "number" then
                    mob:setLocalVar("[jobSpecial]hpp_" .. i, utils.clamp(v.hpp, 0, 100))
                else
                    mob:setLocalVar("[jobSpecial]hpp_" .. i, math.random(40, 60))
                end

                if type(v.begCode) == "function" then
                    mob:setLocalVar("[jobSpecial]begCode_" .. i, 1)
                    mob:removeListener("JOB_SPECIAL_BEG_" .. i)
                    mob:addListener("JOB_SPECIAL_BEG_" .. i, "JOB_SPECIAL_BEG_" .. i, v.begCode)
                end

                if type(v.endCode) == "function" then
                    mob:setLocalVar("[jobSpecial]endCode_" .. i, 1)
                    mob:removeListener("JOB_SPECIAL_END_" .. i)
                    mob:addListener("JOB_SPECIAL_END_" .. i, "JOB_SPECIAL_END_" .. i, v.endCode)
                end
            end
        end

        mob:setLocalVar("[jobSpecial]numAbilities", i)
    end
end

--[[ ----------------------------------------------------------------
    return table of abilities mob is ready to use
---------------------------------------------------------------- --]]

local abilitiesReady = function(mob)
    local abilities = {}
    local now = os.time()
    local readyTime = mob:getLocalVar("[jobSpecial]readyInitial")

    if readyTime > 0 and now > readyTime and now > mob:getLocalVar("[jobSpecial]cooldown") then
        local numAbilities = mob:getLocalVar("[jobSpecial]numAbilities")

        for i = 1, numAbilities do
            if now > mob:getLocalVar("[jobSpecial]cooldown_" .. i) and mob:getHPP() <= mob:getLocalVar("[jobSpecial]hpp_" .. i)  then
                table.insert(abilities, i)
            end
        end
    end

    return abilities
end


--[[ ----------------------------------------------------------------
    mob listeners
---------------------------------------------------------------- --]]

a_mixins.flow_ability = function(mob)

    -- at spawn, give avatar its astral flow ability, which it'll use at 40-60% HP.
    -- these defaults can be overwritten by using tpz.mix.jobSpecial.config() in onMobSpawn.
    mob:addListener("SPAWN", "JOB_SPECIAL_SPAWN", function(mob)
        local ability = nil
        local modelID = mob:getModelId()

        switch (modelID) : caseof
        {
                [791] = function (x) ability = 912 end, -- Carbuncle: Searing Light
                [792] = function (x) ability = 838 end, -- Fenrir: Howling Moon
                [793] = function (x) ability = 848 end, -- Ifrit: Inferno
                [794] = function (x) ability = 857 end, -- Titan: Earthen Fury
                [795] = function (x) ability = 866 end, -- Leviathan: Tidal Wave
                [796] = function (x) ability = 875 end, -- Garuda: Aerial Blast
                [797] = function (x) ability = 884 end, -- Shiva: Diamond Dust
                [798] = function (x) ability = 893 end, -- Ramuh: Judgment Bolt
                [1145] = function (x) ability = 1911 end, -- Diabolos: Ruinous Omen
        }

        if ability then
            mob:setLocalVar("[jobSpecial]numAbilities", 1)
            mob:setLocalVar("[jobSpecial]ability_1", ability)
            mob:setLocalVar("[jobSpecial]hpp_1", math.random(40, 60))
            mob:setLocalVar("[jobSpecial]between_1", 7200)
        end

        mob:setLocalVar("[jobSpecial]chance", 100)     -- chance that mob will use any special at all during engagement
        mob:setLocalVar("[jobSpecial]delayInitial", 2) -- default wait until mob can use its first special (prevents insta-flow)
    end)

    mob:addListener("ENGAGE", "JOB_SPECIAL_ENGAGE", function(mob)
        if math.random(100) <= mob:getLocalVar("[jobSpecial]chance") then
            mob:setLocalVar("[jobSpecial]readyInitial", os.time() + mob:getLocalVar("[jobSpecial]delayInitial"))
        end
    end)

    mob:addListener("COMBAT_TICK", "JOB_SPECIAL_CTICK", function(mob)
        local abilities = abilitiesReady(mob)

        if #abilities > 0 then
            local i = abilities[math.random(#abilities)]
            local ability = mob:getLocalVar("[jobSpecial]ability_" .. i)
            local now = os.time()

            if mob:getLocalVar("[jobSpecial]begCode_" .. i) == 1 then
                mob:triggerListener("JOB_SPECIAL_BEG_" .. i, mob)
            end

            mob:useMobAbility(ability)

            if mob:getLocalVar("[jobSpecial]endCode_" .. i) == 1 then
                mob:triggerListener("JOB_SPECIAL_END_" .. i, mob)
            end

            mob:setLocalVar("[jobSpecial]cooldown_" .. i, now + mob:getLocalVar("[jobSpecial]between_" .. i)) -- set ability cooldown (wait to use this particular special again)
            mob:setLocalVar("[jobSpecial]cooldown", now + mob:getLocalVar("[jobSpecial]between")) -- set global cooldown (wait between using any specials)
        end
    end)
end

return a_mixins.flow_ability