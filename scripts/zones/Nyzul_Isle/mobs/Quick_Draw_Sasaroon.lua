------------------------------------------
-- Quick Draw Sasaroon
-- Nyzul Isle
-- Ranger type Qiqirn
-- No capture - this forum posts claims that Quick Draw acts just like the others
-- https://www.ffxionline.com/forum/ffxi-game-related/general-ffxi-discussion/72143-nyzul-isle#post1112089
-- However wikiwikijp claims its just faze spam https://wikiwiki.jp/taxta/Enemy%20Data
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.ACC, 100) -- extra accurate
end

function onMobWeaponSkillPrepare(mob, target)
    return 1728 -- faze
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