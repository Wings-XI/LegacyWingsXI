-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Custom Cardian
-- 5-20 spawned for AMK mission 6
-- TODO: Figure out how to use MAGIC_DELAY mobMod correctly to replace janky silence removal timers
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 5)
    mob:SetMagicCastingEnabled(false)
    local silenceWear = math.random(5, 15)
    mob:timer(silenceWear * 1000, function(mob)
        mob:SetMagicCastingEnabled(true)
    end)

    -- "Appears to take +50% damage from all sources, assuming the appropriate orb is obtained"
    -- "Possess poor accuracy and attack" -- https://ffxiclopedia.fandom.com/wiki/Custom_Cardian?oldid=1073908
    mob:setMod(tpz.mod.DMG, 50)
    mob:setMod(tpz.mod.ATT, -50)
    mob:setMod(tpz.mod.MATT, -50)
    mob:setMod(tpz.mod.ACC, -50)
    mob:setMod(tpz.mod.MACC, -50)

    -- Resistances based on orbs traded
    mob:setMod(tpz.mod.SLASHRES, 0)
    mob:setMod(tpz.mod.PIERCERES, 0)
    mob:setMod(tpz.mod.IMPACTRES, 0)
    mob:setMod(tpz.mod.HTHRES, 0)
    mob:setMod(tpz.mod.H2HRES, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)

    local npc = GetNPCByID(ID.npc.QM1)

    if npc:getLocalVar("[AMK]5_orb_swords") == 1 then
        mob:setMod(tpz.mod.SLASHRES, 1000)
    end
    if npc:getLocalVar("[AMK]5_orb_cups") == 1 then
        mob:setMod(tpz.mod.PIERCERES, 1000)
    end
    if npc:getLocalVar("[AMK]5_orb_batons") == 1 then
        mob:setMod(tpz.mod.IMPACTRES, 1000)
        mob:setMod(tpz.mod.HTHRES, 1000)
        mob:setMod(tpz.mod.H2HRES, 1000)
    end
    if npc:getLocalVar("[AMK]5_orb_coins") == 1 then
        mob:setMod(tpz.mod.UDMGMAGIC, -25)
    end
end

-- Force the encounter to fail if disengaged (hide, chain of raises, etc.)
function onMobDisengage(mob)
    local npc = GetNPCByID(ID.npc.QM1)
    npc:setLocalVar("[AMK]forceFail", 1)
    DespawnMob(mob:getID())
end

function onMobRoam(mob)
    local npc = GetNPCByID(ID.npc.QM1)
    npc:setLocalVar("[AMK]forceFail", 1)
    DespawnMob(mob:getID())
end

function onMobFight(mob, player)
end

function onMobDeath(mob, player, isKiller)
end
