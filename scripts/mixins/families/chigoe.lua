-- Chigoe family mixin

require("scripts/globals/mixins")
require("scripts/globals/toau")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chigoe = function(mob)
    -- hideName/untargetable true conditions now handled in core
    mob:addListener("ENGAGE", "CHIGOE_ENGAGE", function(mob, target)
        mob:hideName(false)
        mob:untargetable(false)
    end)

    tpz.toau.mobSpecialHook("CHIGOE", mob, 100, function(mob)
        if mob:getHP() > 0 and not mob:isNM()then
            mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
            mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
            mob:setHP(0)
        end
    end)
end

return g_mixins.families.chigoe
