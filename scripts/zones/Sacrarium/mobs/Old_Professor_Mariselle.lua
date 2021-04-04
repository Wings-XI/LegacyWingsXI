-----------------------------------
-- Area: Sacrarium
--  Mob: Old Professor Mariselle
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 0)
    mob:setMobMod(tpz.mobMod.SPAWN_LEASH, 0)
end

function onMobFight(mob, target)

    local OP_Mariselle = mob:getID()

    -- TODO: Casting animation for summons. When he spawns them isn't retail accurate.
    if (mob:getBattleTime() % 30 < 3 and mob:getBattleTime() > 3) then

        mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
        mob:setMobMod(tpz.mobMod.SPAWN_LEASH, 2)

        local X = mob:getXPos()
        local Y = mob:getYPos()
        local Z = mob:getZPos()

        for i = OP_Mariselle+1, OP_Mariselle+2 do
            local m = GetMobByID(i)
            if not m:isSpawned() then
                m:spawn()
                m:updateEnmity(target)
                m:setPos(X + 1, Y, Z + 1) -- Set pupil x and z position +1 from Mariselle
                m:setMobMod(tpz.mobMod.TELEPORT_TYPE, 0)
                m:setMobMod(tpz.mobMod.SPAWN_LEASH, 0)
                return
            else
                m:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
                m:setMobMod(tpz.mobMod.SPAWN_LEASH, 2)
            end
        end
    else
        mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 0)
        mob:setMobMod(tpz.mobMod.SPAWN_LEASH, 0)
    end
end

function onMobDeath(mob, player, isKiller)

    local OP_Mariselle = mob:getID()

    for i = OP_Mariselle+1, OP_Mariselle+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and player:getCharVar("PromathiaStatus") == 3 and  player:hasKeyItem(tpz.ki.RELIQUIARIUM_KEY)==false) then
        player:setCharVar("PromathiaStatus", 4)
    end

    -- Set random variable for determining Old Prof. Mariselle's next spawn location
    local rand = math.random((2), (7))
    SetServerVariable("Old_Prof_Spawn_Location", rand)

end

function onMobDespawn( mob )

    local OP_Mariselle = mob:getID()

    for i = OP_Mariselle+1, OP_Mariselle+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    -- Set random variable for determining Old Prof. Mariselle's next spawn location
    local rand = math.random((2), (7))
    SetServerVariable("Old_Prof_Spawn_Location", rand)

end
