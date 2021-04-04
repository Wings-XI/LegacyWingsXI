-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Y
-----------------------------------

function onMobFight(mob, target)
    mob:setMod(tpz.mod.REGAIN, 30)
end

function onMobDeath(mob, player, isKiller)
end
