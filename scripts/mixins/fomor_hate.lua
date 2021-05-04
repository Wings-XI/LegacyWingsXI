require("scripts/globals/mixins")
require("scripts/globals/utils")

g_mixins = g_mixins or {}

g_mixins.fomor_hate = function(mob)
    mob:addListener("DEATH", "FOMOR_HATE_DEATH", function(mob, player)
        if player then
            for _, member in pairs(player:getAlliance()) do
                if member:getZoneID() == player:getZoneID() then
                    local hate = member:getCharVar("FOMOR_HATE")
                    local adj = mob:getLocalVar("fomorHateAdj")
                    local decrease = mob:getLocalVar("fomorHateDecrease")
                    if adj == 0 then
                        adj = 2 -- default: most fomor add 2 hate
                    end
                    if decrease ~= 0 then
                        hate = hate - adj
                    else
                        hate = hate + adj
                    end
                    member:setFomorHate(utils.clamp(hate, 0, 60))
                end
            end
        end
    end)
end

return g_mixins.fomor_hate
