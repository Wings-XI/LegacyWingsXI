-----------------------------------
-- Area: Gustav Tunnel (212)
--  Mob: Bompupu
--  Involved in Mission: Enemy of the Empire (II) - A Shantotto Ascension
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
end



function onMobFight(mob, target)
end

function onMobRoam(mob, target)
end

-- function onMobRoam(mob, target)
--     local shouldUtsu = mob:getLocalVar("UtsuSpam")


--     if shouldUtsu > 0 then
--         -- print("triggered")
--         mob:castSpell(339)
--         -- print(shouldUtsu)
--     elseif shouldUtsu == 0 then
--         -- mob:SetMagicCastingEnabled(false)
--     end
-- end

-- function onCastStarting(mob, spell)
--     local shouldUtsu = mob:getLocalVar("UtsuSpam")
--     print(spell:getID())

--     if spell:getID() == 339 and mob:getStatus() == tpz.status.NORMAL then
--         mob:setLocalVar("UtsuSpam", shouldUtsu - 1)
--     end
-- end

function onMobDeath(mob, player, isKiller)
    -- if mob:getID() == 17645818 then
    --     mob:showText(ID.text.ASA_BOMPUPU_DEATH)
    -- else
    --     for _, member in pairs(player:getParty()) do
    --         member:messageSpecial(ID.text.ASA_SHADOW_DEATH, 1)
    --     end
    -- end
end
