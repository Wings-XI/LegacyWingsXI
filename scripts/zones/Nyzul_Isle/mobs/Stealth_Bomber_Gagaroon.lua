------------------------------------------
-- Stealth Bomber Gagaroon
-- Nyzul Isle
-- Thf type Qiqirn
-- No capture - classic wiki claims he does not run around like Gem heister - but normal wiki says he does
-- wikiwiki.jp claims he only uses cutpurse
------------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.ACC, 100) -- extra accurate
end

function onMobWeaponSkillPrepare(mob, target)
    return 1726 -- cutpurse
end

function onMobFight(mob, target)
    local mobHPP = mob:getHPP()
    if mobHPP < 25 then
        if (mob:getMod(tpz.mod.REGAIN) ~= 250) then
            mob:setMod(tpz.mod.REGAIN, 250)
        end
    elseif mobHPP < 50 then
        if (mob:getMod(tpz.mod.REGAIN) ~= 125) then
            mob:setMod(tpz.mod.REGAIN, 125)
        end
    elseif mobHPP < 75 then
        if (mob:getMod(tpz.mod.REGAIN) ~= 75) then
            mob:setMod(tpz.mod.REGAIN, 75)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end