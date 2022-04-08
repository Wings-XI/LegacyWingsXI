-- Amphiptere family mixin

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.amphiptere = function(mob)
    mob:addListener("SPAWN", "AMPHIPTERE_SPAWN", function(mob)
        mob:hideName(true)
        mob:untargetable(true)
        mob:AnimationSub(1)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:SetAutoAttackEnabled(true)
    end)
    mob:addListener("ENGAGE", "AMPHIPTERE_ENGAGE", function(mob, target)
        mob:hideName(false)
        mob:untargetable(false)
        mob:AnimationSub(0)
    end)
    mob:addListener("DISENGAGE", "AMPHIPTERE_DISENGAGE", function(mob, target)
        mob:hideName(true)
        mob:untargetable(true)
        mob:AnimationSub(1)
    end)
    mob:addListener("COMBAT_TICK", "REAVING_WIND", function(mob)
        local knockback = mob:getLocalVar("knockback")
    
        if mob:getBattleTime() < knockback then
            mob:AnimationSub(2)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
            mob:SetAutoAttackEnabled(false)
    
            local nearbyPlayers = mob:getPlayersInRange(10)
            if nearbyPlayers == nil then return end
                for _,v in ipairs(nearbyPlayers) do
                    if mob:getCurrentAction() == tpz.act.ATTACK then
                        mob:useMobAbility(2434, v)
                    end
                end        
        else
            mob:setLocalVar("knockback", 0) 
            mob:AnimationSub(0)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
            mob:SetAutoAttackEnabled(true)
        end
    end)
    mob:addListener("WEAPONSKILL_STATE_EXIT", "SET_RW_DURATION", function(mob, skillID)
        local knockback = mob:getLocalVar("knockback")
        if skillID == 2431 then
            mob:setLocalVar("knockback", mob:getBattleTime() + 20)
        end
    end)
end

return g_mixins.families.amphiptere
