------------------------------
-- Area: FeiYin
--   NM: Sluagh
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 349)
end

function onMobFight(mob, target)
    --[[
        borrowing Gloom Eye's store TP increase
        Possesses a potent Store TP trait that rises as HP declines. Below 20%, it will use Grave Reel
        approximately once for every 3 damaging actions inflicted on it.

    Using formula below, mob will have:
    at 100% HP, 20 storeTP
        75% HP, 70 storeTP
        50% HP, 120 storeTP
        25% HP, 170 storeTP 
    --]]
    local power = 20 + math.floor(utils.clamp(100 - mob:getHPP(), 0, 75) * 2)
    mob:setMod(tpz.mod.STORETP, power)
end

function onMobWeaponSkillPrepare(mob, target)
    return 472 -- grave reel
end
