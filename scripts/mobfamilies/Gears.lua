--------------------------------------------------------------
--  Family: Gears
--  Behavior: Updates the animation sub and mob skill list of Gears based on loss of hp 
--------------------------------------------------------------
require("scripts/globals/status")
--------------------------------------------------------------
--[[
    Gears
    AnimationSub(0) = 3 Gears
    AnimationSub(1) = 2 Gears
    AnimationSub(2) = 1 Gear

    Gears lose a gear at 50% and another at 25%
    Restoral can cause a Gears to regain a gear
    Gears TP moves are different depending on the number of Gears
    More Gears "alive" = More powerful TP moves

    Need to
        - catch hp falling through threasholds (take_damage)
        - catch hp raising (WEAPONSKILL_USE)  Could I make restoral take negative damage?
        - Swap skill lists and AnimationSubs


]]

function onMobFamilyInitialize(mob)
    mob:addListener("COMBAT_TICK", "GEARS_CTICK", function(mob)
        local mobHPP = mob:getHPP()
        if (mobHPP >= 26 and mobHPP <= 49) then
            if mob:AnimationSub() ~= 1 then
                mob:AnimationSub(1) -- double gear
                mob:setMobMod(tpz.mobMod.SKILL_LIST, 151)
            end
        if mob:getLocalVar("Def1") == 0 then
            mob:delMod(tpz.mod.MDEF, 10)
            mob:delMod(tpz.mod.DEF, 20)
            mob:setLocalVar("Def1", 1)
        end
        elseif mobHPP <= 25 then
            if mob:AnimationSub() ~= 2 then
                mob:AnimationSub(2) -- single gear
                mob:setMobMod(tpz.mobMod.SKILL_LIST, 152)
            end
            if mob:getLocalVar("Def2") == 0 then
                mob:delMod(tpz.mod.MDEF, 10)
                mob:delMod(tpz.mod.DEF, 20)
                mob:setLocalVar("Def2", 1)
            end
        elseif mobHPP > 50 then
            if mob:AnimationSub() ~= 0 then
                mob:AnimationSub(0) -- tripple gear
                mob:setMobMod(tpz.mobMod.SKILL_LIST, 150)
            end
        end

    end)
end