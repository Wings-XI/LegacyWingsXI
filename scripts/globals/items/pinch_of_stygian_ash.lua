-----------------------------------------
-- ID: 19210
-- Item: stygian_ash
-- Notes: used to claim Dark Ixion. RACC bonus added as item mod to stay true to era
--          "Would seem to me that the ash would have a hidden effect."
--          "I accidentally threw the ash at a campaign mob and it hit. I only have 48 throwing skill... Yannibartola 00:36, 9 July 2008 (UTC)"
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onAdditionalEffect(player, target, damage)
    target:setLocalVar("StygianLanded", 1)
end
