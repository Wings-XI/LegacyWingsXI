-----------------------------------
-- Area: RuAun Gardens
--  Mob: Sprinkler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 142, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 143, 1, tpz.regime.type.FIELDS)
end;

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()

    if rnd < 0.5
	then
    return 196 -- Thundaga III
    elseif rnd < 0.7 then
        return 167 -- Thunder IV
    elseif rnd < 0.8 then
        return 212 -- Burst
    else
        return 166 -- Thunder III
    end
end
