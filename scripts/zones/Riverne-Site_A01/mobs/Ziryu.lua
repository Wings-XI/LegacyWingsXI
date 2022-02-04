-----------------------------------
-- Area: Riverne-Site_A01
-- Notes: Assists Ouryu in Ouryu Cometh
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/mobs")
-----------------------------------

local Ziryu1 = {
    { 46.836, 76.828, -758.276 },
    { 26.248, 76.607, -750.256 },
    { 42.179, 76.290, -752.683 },
    { 26.127, 76.550, -767.194 },
    { 35.687, 76.152, -757,707 },
    { 48.250, 76.524, -766.964 },
    { 50.825, 76.781, -756.612 },
    { 38.753, 76.809, -771.376 },
}

local Ziryu2 = {
    { -5.680, 76.098, -753.375 },
    { -7.673, 76.109, -753.720 },
    { -5.063, 76.632, -769.115 },
    { 5.228, 76.399, -767.280 },
    { 5.263, 76.308, -757.192 },
    { -4.365, 76.112, -750.562 },
    { -0.636, 76.000, -763.672 },
}

local Ziryu3 = {
    { 0.744, 76.462, -712.730  },
    { 3.663, 76.234, -710.823  },
    { 0.834, 76.032, -721.327  },
    { 9.013, 76.413, -722.767  },
    { -2.091, 76.000, -718.037 },
    { 10.238, 76.550, -724.555 },
}

local Ziryu4 = {
    { 10.129, 65.914, -736.797 },
    { 9.715, 76.785, -744.8561 },
    { 22.027, 76.512, -730.651 },
    { 36.108, 76.590, -710.141 },
    { 49.704, 76.034, -722.611 },
}

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(30, 180)) -- Respawns every 1 minute
    local randspawn1 = Ziryu1[math.random((1), (8))]
    local randspawn2 = Ziryu2[math.random((1), (7))]
    local randspawn3 = Ziryu3[math.random((1), (6))]
    local randspawn4 = Ziryu4[math.random((1), (5))]
    
    if mob:getID() == 16900315 then
        mob:setSpawn(randspawn1)
    elseif mob:getID() == 16900316 then
        mob:setSpawn(randspawn2)
    elseif mob:getID() == 16900317 then
        mob:setSpawn(randspawn3)
    elseif mob:getID() == 16900318 then
        mob:setSpawn(randspawn4)
    end


end