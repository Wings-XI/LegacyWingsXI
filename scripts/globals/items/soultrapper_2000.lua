-----------------------------------
-- Soultrapper 2000 (18724)
-----------------------------------
require("scripts/globals/znm")
-----------------------------------

function onItemCheck(target, param, user, item)
    return tpz.znm.soultrapper.onItemCheck(target, user)
end

function onItemUse(target, item, user)
    tpz.znm.soultrapper.onItemUse(target, item, user)
end
