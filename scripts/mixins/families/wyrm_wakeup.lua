require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.wyrm_wakeup = function(mob)
    mob:addListener("COMBAT_TICK", "WYRM_CTICK", function(wyrm)
        if wyrm:AnimationSub() == 1 then
            wyrm:wakeUp()
        end
    end)
end

return g_mixins.families.wyrm_wakeup
