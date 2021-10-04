-----------------------------------------
--  ID: 17566
--  Treat staff
--  Chance to transport the user to their Home Point on hit
-----------------------------------------
require("scripts/globals/events/harvest_festivals")

function onAdditionalEffect(player, target, damage)
    local totd = VanadielTOTD()
    local warp = math.random() < 0.15

    if warp and (isHalloweenEnabled() ~= 0 or (VanadielDayOfTheWeek() == tpz.day.DARKSDAY and IsMoonFull() and (totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT))) then
        player:warp()
    end
end
