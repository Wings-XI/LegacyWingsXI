require("scripts/globals/mixins")
require("scripts/globals/utils")

g_mixins = g_mixins or {}

g_mixins.pixie_hate = function(mob)
    mob:addListener("DEATH", "PIXIE_HATE_DEATH", function(mob, player)
        -- Decrease global server amity
        local amity = GetServerVariable("PixieAmity")
        if amity > -255 then
            amity = amity - 1
            SetServerVariable("PixieAmity", amity)
        end
        -- Increase individual player hate
        if player then
            for _, member in pairs(player:getAlliance()) do
                if member:getZoneID() == player:getZoneID() then
                    local hate = member:getCharVar("PIXIE_HATE")
                    local adj = mob:getLocalVar("pixieHateAdj")
                    local decrease = mob:getLocalVar("pixieHateDecrease")
                    if adj == 0 then
                        adj = 1 -- default
                    end
                    if decrease ~= 0 then
                        hate = hate - adj
                    else
                        hate = hate + adj
                    end
                    member:setPixieHate(utils.clamp(hate, 0, 60))
                end
            end
        end
    end)
end

return g_mixins.pixie_hate
