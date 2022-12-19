require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/status")

g_mixins = g_mixins or {}

g_mixins.pixie_hate = function(mob)
    mob:addListener("DEATH", "PIXIE_HATE_DEATH", function(mob, target)
        -- Decrease global server amity
        local amity = GetServerVariable("PixieAmity")
        if amity > -255 then
            amity = amity - 1
            SetServerVariable("PixieAmity", amity)
        end
        if target then
            local player = target
            if target:isPet() then player = target:getMaster() end
            -- Increase individual player hate
            if player and player:getObjType() == tpz.objType.PC then
                for _, member in pairs(player:getAlliance()) do
                    if member:getZoneID() == player:getZoneID() then
                        local hate = member:getCharVar("PIXIE_HATE")
                        local adj = mob:getLocalVar("pixieHateAdj") -- how much personal pixie hate each player in party gets by killing this mob
                        local decrease = mob:getLocalVar("pixieHateDecrease") -- set to one to reduce personal pixie hate when killing this mob
                        if adj == 0 then
                            adj = 8 -- default: only takes a few kills for player to not get heals and a few more to aggro pixies
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
        end
    end)

    -- WINGSCUSTOM - Pixies get very strong when pixie hate is worse
    mob:addListener("ENGAGE", "PIXIE_ENGAGE", function(mob, target)
        local totalAllianceHate = 0
        if target then
            local player = target
            if target:isPet() then player = target:getMaster() end
            if player and player:getObjType() == tpz.objType.PC then
                -- add one pixie hate everytime you engage combat with a pixie
                if mob:getLocalVar("pixieHateDecrease") == 0 then
                    player:setPixieHate(utils.clamp(player:getCharVar("PIXIE_HATE") + 1, 0, 60))
                end
                for _, member in pairs(player:getAlliance()) do
                    if member:getZoneID() == player:getZoneID() then
                        local hate = member:getCharVar("PIXIE_HATE")
                        local adj = mob:getLocalVar("pixieHateAdj")
                        totalAllianceHate = totalAllianceHate + hate
                    end
                end
            end
        end

        -- amity ranges from -255 to 255, -255 is max server "hate", meaning few pixies spawn, 255 pixies are super happy
        -- shift amity left 255 so now we range -510 to 0, then make that a percentage and negate it
        -- ranges between 0 (full pixie server happiness) and 100 (capped at 90) (full pixie server hate)
        local amityBonus = utils.clamp((-100 * (GetServerVariable("PixieAmity") - 255) / 510), 0, 90)
        -- also add total alliance hate to build a percent increase in pixie phys and magic attack
        mob:setMod(tpz.mod.ATTP, amityBonus + totalAllianceHate)
        mob:setMod(tpz.mod.MAGIC_DAMAGE, amityBonus + totalAllianceHate)
        -- shift the amityBonus (between 0 and 90) left 45 and negate then double to generate a range of -90 (full pixie server hate) and 90 (full pixie happiness)
        local amityDmgMod = -2 * (amityBonus - 45)
        mob:setMod(tpz.mod.UDMGPHYS, amityDmgMod)
        mob:setMod(tpz.mod.UDMGBREATH, amityDmgMod)
        mob:setMod(tpz.mod.UDMGMAGIC, amityDmgMod)
        mob:setMod(tpz.mod.UDMGRANGE, amityDmgMod)
        -- net result of the above is this: pixies hit harder and take less dmg when pixie hate is worse
    end)
end

return g_mixins.pixie_hate
