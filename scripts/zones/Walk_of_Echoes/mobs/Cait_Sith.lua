-----------------------------------
-- Area: Walk of Echoes
--  Mob: Cait Sith
-----------------------------------
mixins = {require("scripts/mixins/families/avatar_prime")}
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setModelId(28) -- copied modelid from cait sith pet since db value has bunk animations

    -- resistances: https://www.bg-wiki.com/ffxi/Cait_Sith_Prime
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMod(tpz.mod.UDMGBREATH, -50)
    mob:setMod(tpz.mod.SDT_FIRE, 50)
    mob:setMod(tpz.mod.SDT_ICE, 30)
    mob:setMod(tpz.mod.SDT_WIND, 50)
    mob:setMod(tpz.mod.SDT_EARTH, 30)
    mob:setMod(tpz.mod.SDT_THUNDER, 50)
    mob:setMod(tpz.mod.SDT_WATER, 30)
    mob:setMod(tpz.mod.SDT_LIGHT, -100) -- immune
    mob:setMod(tpz.mod.SDT_DARK, 30)

    -- status resistances: https://ffxiclopedia.fandom.com/wiki/Champion_of_the_Dawn
    mob:setMod(tpz.mod.STUNRES, -10)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.SILENCERES, 100)
end

function onMobEngaged(mob, player)
    mob:messageName(ID.text.CAIT_ENGAGE, mob)
end

function onMobFight(mob, player)
end

function onMobDeath(mob, player, isKiller)
    if player then
        player:messageSpecial(ID.text.CAIT_DEAD)
    end
end
