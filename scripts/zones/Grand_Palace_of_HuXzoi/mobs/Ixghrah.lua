-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/missions")
-----------------------------------

function onMobSpawn(mob)
    if (mob:getMod(tpz.mod.SLASHRES)) then mob:setMod(tpz.mod.SLASHRES, 1000); end
    if (mob:getMod(tpz.mod.PIERCERES)) then mob:setMod(tpz.mod.PIERCERES, 1000); end
    if (mob:getMod(tpz.mod.IMPACTRES)) then mob:setMod(tpz.mod.IMPACTRES, 1000); end
    if (mob:getMod(tpz.mod.H2HRES)) then mob:setMod(tpz.mod.H2HRES, 1000); end

    mob:setLocalVar("twoHourPer", 50)
    mob:setLocalVar("canTwoHour", 0)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
    mob:setModelId(1167)

    local DayOfTheWeek = VanadielDayOfTheWeek()
    mob:setLocalVar("skin", DayOfTheWeek + 1161)

    if skin == 1161 then -- Fire
        mob:setSpellList(470)
        mob:setMod(tpz.mod.ICEDEF, 180)
        mob:setMod(tpz.mod.ICERES, 80)
        mob:setMod(tpz.mod.PARALYZERES, 99)
        mob:setMod(tpz.mod.BINDRES, 99)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.FIRERES, 100)
        mob:setMod(tpz.mod.WATERRES, -27)
    elseif skin == 1162 then -- Ice
        mob:setSpellList(465)
        mob:setMod(tpz.mod.WINDDEF, 180)
        mob:setMod(tpz.mod.WINDRES, 80)
        mob:setMod(tpz.mod.GRAVITYRES, 99)
        mob:setMod(tpz.mod.SILENCERES, 99)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.ICERES, 100)
        mob:setMod(tpz.mod.PARALYZERES, 100)
        mob:setMod(tpz.mod.BINDRES, 100)
        mob:setMod(tpz.mod.FIRERES, -27)
    elseif skin == 1163 then -- Wind
        mob:setSpellList(466)
        mob:setMod(tpz.mod.EARTHDEF, 180)
        mob:setMod(tpz.mod.SLOWRES, 99)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.WINDRES, 100)
        mob:setMod(tpz.mod.GRAVITYRES, 100)
        mob:setMod(tpz.mod.SILENCERES, 100)
        mob:setMod(tpz.mod.ICERES, -27)
    elseif skin == 1164 then -- Earth
        mob:setSpellList(467)
        mob:setMod(tpz.mod.THUNDERDEF, 180)
        mob:setMod(tpz.mod.THUNDERRES, 80)
        mob:setMod(tpz.mod.STUNRES, 99)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.EARTHRES, 100)
        mob:setMod(tpz.mod.SLOWRES, 100)
        mob:setMod(tpz.mod.WINDRES, -27)
    elseif skin == 1165 then -- Lightning
        mob:setSpellList(468)
        mob:setMod(tpz.mod.WATERDEF, 180)
        mob:setMod(tpz.mod.WATERRES, 80)
        mob:setMod(tpz.mod.POISONRES, 99)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.THUNDERRES, 100)
        mob:setMod(tpz.mod.STUNRES, 100)
        mob:setMod(tpz.mod.EARTHRES, -27)
    elseif skin == 1166 then -- Water
        mob:setSpellList(469)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.FIRERES, 80)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.WATERRES, 100)
        mob:setMod(tpz.mod.POISONRES, 100)
        mob:setMod(tpz.mod.THUNDERRES, -27)
    elseif skin == 1167 then -- Light
        mob:setSpellList(464)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.LIGHTRES, 100)
        mob:setMod(tpz.mod.LULLABYRES, 100)
        mob:setMod(tpz.mod.DARKRES, -27)
    elseif skin == 1168 then -- Dark
        mob:setSpellList(463)
        mob:setMod(tpz.mod.DARKDEF, 256)
        mob:setMod(tpz.mod.DARKRES, 100)
        mob:setMod(tpz.mod.SLEEPRES, 100)
        mob:setMod(tpz.mod.LIGHTRES, -27)
    end
end

function onMobFight(mob, target)
    local changeTime = mob:getLocalVar("changeTime")
    local canTwoHour = mob:getLocalVar("canTwoHour")
    local delay = mob:getLocalVar("delay")
    local state = mob:getLocalVar("state")
    local twoHourPer = mob:getLocalVar("twoHourPer")

    if (mob:getBattleTime() - changeTime > 30) then
        mob:setLocalVar("state", math.random(0, 3))
        mob:AnimationSub(state)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end


    if mob:getLocalVar("canTwoHour") == 0 and mob:getHPP() < twoHourPer then
        if mob:getLocalVar("state") == 1 then
            mob:useMobAbility(694) --invincible
        elseif mob:getLocalVar("state") == 2 then
            mob:useMobAbility(688) -- mighty strikes
        elseif mob:getLocalVar("state") == 0 then
            mob:useMobAbility(691) -- manafont
            local skin = mob:getLocalVar("skin")
            if skin == 1161 then -- Fire
                mob:setSpellList(483)
            elseif skin == 1162 then --Earth
                mob:setSpellList(480)
            elseif skin == 1163 then -- Water
                mob:setSpellList(482)
            elseif skin == 1164 then -- Wind
                mob:setSpellList(479)
            elseif skin == 1165 then --Ice
                mob:setSpellList(478)
            elseif skin == 1166 then --Lightning
                mob:setSpellList(481)
            elseif skin == 1167 then --Light
                mob:setSpellList(477)
            elseif skin == 1168 then --Dark
                mob:setSpellList(476)
            end
            mob:setLocalVar("delay", mob:getBattleTime())
            mob:setMobMod(tpz.mobMod.MAGIC_COOL, 0)
        elseif mob:getLocalVar("state") == 3 then
            mob:useMobAbility(693) -- perfect dodge
        end
        mob:setLocalVar("canTwoHour", 1)
    end

    if not mob:hasStatusEffect(tpz.effect.MANAFONT) and mob:getLocalVar("canTwoHour") == 1 and (mob:getBattleTime() - mob:getLocalVar("delay") > 15) and mob:getLocalVar("checker2") == 0 then
        local skin = mob:getLocalVar("skin")
        if skin == 1161 then -- Fire
            mob:setSpellList(470)
        elseif skin == 1162 then --Earth
            mob:setSpellList(467)
        elseif skin == 1163 then -- Water
            mob:setSpellList(469)
        elseif skin == 1164 then -- Wind
            mob:setSpellList(466)
        elseif skin == 1165 then --Ice
            mob:setSpellList(465)
        elseif skin == 1166 then --Lightning
            mob:setSpellList(468)
        elseif skin == 1167 then --Light
            mob:setSpellList(464)
        elseif skin == 1168 then --Dark
            mob:setSpellList(463)
        end

        mob:setLocalVar("checker2", 1)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 30)
    end
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.A_FATE_DECIDED  and player:getCharVar("PromathiaStatus")==1) then
        player:setCharVar("PromathiaStatus", 2)
    end
end
