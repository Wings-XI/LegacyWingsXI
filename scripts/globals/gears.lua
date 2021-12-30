---------------------------------------
-- Gears helper functions
---------------------------------------
require("scripts/globals/status")
---------------------------------------
tpz = tpz or {}
tpz.gears = tpz.gears or {}

----------------------------------------------------------
-- Updates the number of gears remaining for the gears mob
-- Params:
--      mob - the gears mob
--      animationSub - the animationSub to be set
----------------------------------------------------------
tpz.gears.updateNumberOfGears = function(mob, animationSub)
    printf("called with animationSub %s", animationSub)
    if (animationSub == 0) then
        -- 3 Gears
        mob:AnimationSub(0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 150)
    elseif (animationSub == 1) then
        -- 2 Gears
        mob:AnimationSub(1)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 151)
    elseif (animationSub == 2) then
        -- 1 Gear
        mob:AnimationSub(2)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 152)
    end
end