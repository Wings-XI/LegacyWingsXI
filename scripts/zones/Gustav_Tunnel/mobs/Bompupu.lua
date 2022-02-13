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
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:untargetable(true)
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)

    mob:setPos(-140.446, -9.889, -194.232, 201)
    mob:SetMobAbilityEnabled(false)
    mob:SetAutoAttackEnabled(false)
    mob:setSpellList(523)

    mob:setLocalVar("UtsuSpam", 4)
end



function onMobFight(mob, target)
    local shouldUtsu = mob:getLocalVar("UtsuSpam")
    print(shouldUtsu)

    local shadowOne = mob:getID() + 1
    local shadowTwo = mob:getID() + 2
    local shadowThree = mob:getID() + 3

    if mob:isAlive() == false then
        SpawnMob(shadowOne)
    end

    if shouldUtsu > 0 and mob:getCurrentAction() ~= tpz.act.MAGIC_CASTING and mob:getCurrentAction() ~= tpz.act.MAGIC_START then
        print("triggered")
        mob:castSpell(339)

    elseif shouldUtsu == 0 then
        -- mob:SetMagicCastingEnabled(false)
    end
end

function onMobRoam(mob, target)
    print("bah")
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

-- function onMobDeath(mob, player, isKiller)
--     -- if mob:getID() == 17645818 then
--     --     mob:showText(ID.text.ASA_BOMPUPU_DEATH)
--     -- else
--     --     for _, member in pairs(player:getParty()) do
--     --         member:messageSpecial(ID.text.ASA_SHADOW_DEATH, 1)
--     --     end
--     -- end
-- end
