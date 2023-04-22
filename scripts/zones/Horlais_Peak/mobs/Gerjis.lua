-----------------------------------
-- Area: Horlais Peak
--  Mob: Gerjis
-- BCNM: Eye of the Tiger
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.EVA, 50)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    local chance = 15

    if
        damage > 0 and
        chance >= math.random(100)
    then
        local dispelables = {}
        for i, effect in ipairs(target:getStatusEffects()) do
            if bit.band(effect:getFlag(), tpz.effectFlag.DISPELABLE) == tpz.effectFlag.DISPELABLE then
                table.insert(dispelables, effect)
            end
        end
        if #dispelables > 0 then
            local randomEffect = dispelables[math.random(#dispelables)]:getType()
            target:delStatusEffect(randomEffect)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
