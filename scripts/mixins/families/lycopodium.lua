require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.lycopodium = tpz.mix.lycopodium or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.lycopodium = function(mob)
    mob:addListener("SPAWN", "LYCOPODIUM_SPAWN", function(mob)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end)

    mob:addListener("ROAM_TICK", "LYCOPODIUM_RTICK", function(mob)
        -- Goes back to a passive state if roaming and reset completely.
        if mob:getHPP() == 100 then
            mob:SetAutoAttackEnabled(false)
            mob:SetMobAbilityEnabled(false)
        end
    end)

    mob:addListener("DISENGAGE", "LYCOPODIUM_DISENGAGE", function(mob, target)
        if not mob:isAlly() then
            mob:SetAutoAttackEnabled(false)
            mob:SetMobAbilityEnabled(false)
        end
    end)

    mob:addListener("ENGAGE", "LYCOPODIUM_ENGAGE", function(mob, target)
        mob:setLocalVar("[lycopodium]disengageTime",  mob:getBattleTime() + 45)
        if mob:isAlly() then
            mob:SetAutoAttackEnabled(true)
            mob:SetMobAbilityEnabled(true)
        end
    end)

    mob:addListener("COMBAT_TICK", "LYCOPODIUM_CTICK", function(mob)
        if mob:isAlly() then
            mob:SetAutoAttackEnabled(true)
            mob:SetMobAbilityEnabled(true)
        else
            local disengageTime = mob:getLocalVar("[lycopodium]disengageTime")

            if mob:getHP() < mob:getMaxHP() then
                mob:SetAutoAttackEnabled(true)
                mob:SetMobAbilityEnabled(true)
            elseif disengageTime > 0 and mob:getBattleTime() > disengageTime then
                mob:setLocalVar("[lycopodium]disengageTime",  0)
                mob:disengage()
            end
        end
    end)

    mob:addListener("TAKE_DAMAGE", "LYCOPODIUM_DAMAGE", function(mob)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
    end)
end

return g_mixins.families.lycopodium