--[[
Mobs that enter rage mode after a specified amount of time in combat. Controlled by following vars that can be set onMobSpawn:

localVar    default     description
--------    -------     -----------
rageTimer   1200        seconds into combat at which point the mob will rage.

https://ffxiclopedia.fandom.com/wiki/Rage
--]]

require("scripts/globals/mixins")
require("scripts/globals/status")

g_mixins = g_mixins or {}

g_mixins.rage = function(mob)
    
    mob:addListener("SPAWN", "RAGE_SPAWN", function(mob)
        mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
    end)

    mob:addListener("ENGAGE", "RAGE_ENGAGE", function(mob)
        if mob:getLocalVar("[rage]at") == 0 then
        mob:setLocalVar("[rage]at", os.time() + mob:getLocalVar("[rage]timer"))
        end
    end)

    mob:addListener("COMBAT_TICK", "RAGE_CTICK", function(mob)
        if mob:getLocalVar("[rage]started") == 0 and os.time() > mob:getLocalVar("[rage]at") then
            mob:setLocalVar("[rage]started", 1)

            -- boost stats
            for i = tpz.mod.STR, tpz.mod.CHR do
                local amt = math.ceil(mob:getStat(i) * 9)
                mob:setLocalVar("[rage]mod_" .. i, amt)
                mob:addMod(i, amt)
            end

            -- TODO: ATT, DEF, MACC, MATT, EVA, attack speed all increase
            mob:addMod(tpz.mod.DELAY, 2600)
            mob:addMod(tpz.mod.ATTP, 60)
            mob:addMod(tpz.mod.ACC, 500)
            mob:addMod(tpz.mod.MAIN_DMG_RATING, 75)
            mob:addMod(tpz.mod.CRITHITRATE, 30)
            mob:addMod(tpz.mod.MEVA, 500)
            mob:addMod(tpz.mod.LULLABYRESTRAIT, 100)
            mob:addMod(tpz.mod.SLEEPRESTRAIT, 100)
            mob:addMod(tpz.mod.BINDRESTRAIT, 100)
            mob:addMod(tpz.mod.GRAVITYRESTRAIT, 100)
            
            mob:delStatusEffect(tpz.effect.SLEEP_I)
            mob:delStatusEffect(tpz.effect.PARALYSIS)
            mob:delStatusEffect(tpz.effect.BLINDNESS)
            mob:delStatusEffect(tpz.effect.SILENCE)
            mob:delStatusEffect(tpz.effect.PETRIFICATION)
            mob:delStatusEffect(tpz.effect.CURSE_I)
            mob:delStatusEffect(tpz.effect.BIND)
            mob:delStatusEffect(tpz.effect.WEIGHT)
            mob:delStatusEffect(tpz.effect.SLOW)
            mob:delStatusEffect(tpz.effect.CHARM_I)
            mob:delStatusEffect(tpz.effect.AMNESIA)
            mob:delStatusEffect(tpz.effect.CHARM_II)
            mob:delStatusEffect(tpz.effect.SLEEP_II)
            mob:delStatusEffect(tpz.effect.CURSE_II)
            mob:delStatusEffect(tpz.effect.GRADUAL_PETRIFICATION)
            mob:delStatusEffect(tpz.effect.TERROR)
            mob:delStatusEffect(tpz.effect.MUTE)
            mob:delStatusEffect(tpz.effect.LULLABY)
            mob:delStatusEffect(tpz.effect.ELEGY)
            mob:delStatusEffect(tpz.effect.THRENODY)
        end
    end)

    mob:addListener("DISENGAGE", "RAGE_DISENGAGE", function(mob)
        mob:setLocalVar("current_hp", mob:getHPP())
    end)

    mob:addListener("ROAM_TICK", "RAGE_ROAM_TICK", function(mob)        

        if mob:getHPP() > mob:getLocalVar("current_hp") or mob:getHPP() == 100 then
            mob:setLocalVar("[rage]at", 0)
            if mob:getLocalVar("[rage]started") == 1 then                
                mob:setLocalVar("[rage]started", 0)
                
                -- unboost stats
                for i = tpz.mod.STR, tpz.mod.CHR do
                    local amt = mob:getLocalVar("[rage]mod_" .. i)
                    mob:delMod(i, amt)
                end

                -- TODO: ATT, DEF, MACC, MATT, EVA, attack speed all decrease
                mob:delMod(tpz.mod.DELAY, 2600)
                mob:delMod(tpz.mod.ATTP, 60)
                mob:delMod(tpz.mod.ACC, 500)
                mob:delMod(tpz.mod.MAIN_DMG_RATING, 75)
                mob:delMod(tpz.mod.CRITHITRATE, 30)
                mob:delMod(tpz.mod.MEVA, 500)
                mob:delMod(tpz.mod.LULLABYRESTRAIT, 100)
                mob:delMod(tpz.mod.SLEEPRESTRAIT, 100)
                mob:delMod(tpz.mod.BINDRESTRAIT, 100)
                mob:delMod(tpz.mod.GRAVITYRESTRAIT, 100)
            end
        end
    end)
end

return g_mixins.rage
