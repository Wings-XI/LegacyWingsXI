-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'ghrah
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobSpawn(mob)
    -- Forms: 1 Humainoid(PLD) 2 Spider(WAR) 3 Bird(THF)
    -- Set core Skin and mob elemental resist/weakness; other elements set to 0.
    -- Set to non aggro.
    mob:AnimationSub(0)
    mob:setAggressive(0)
    mob:setMod(tpz.mod.MDEF, 10)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 60)
    mob:setLocalVar("roamTime", os.time())
    if mob:getXPos() > 0 then
        mob:setLocalVar("form2", 2)
    else
        mob:setLocalVar("form2", 3)
    end

    local skin = math.random(1161, 1168)
    local mobSkin = mob:getModelId()
    mob:setModelId(skin)

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

function onMobRoam(mob)
    local roamTime = mob:getLocalVar("roamTime")
    if (mob:AnimationSub() == 0 and os.time() - roamTime > 60) then
        mob:AnimationSub(mob:getLocalVar("form2"))
        mob:setLocalVar("roamTime", os.time())
        mob:setAggressive(1)
    elseif (mob:AnimationSub() == mob:getLocalVar("form2") and os.time() - roamTime > 60) then
        mob:AnimationSub(0)
        mob:setAggressive(0)
        mob:setLocalVar("roamTime", os.time())
    end
end

function onMobEngaged(mob, target)
    mob:setLocalVar("changeTime", 0)
end

function onMobFight(mob, target)

    local changeTime = mob:getLocalVar("changeTime")

    if (mob:AnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
        mob:AnimationSub(mob:getLocalVar("form2"))
        mob:setAggressive(1)
        mob:setLocalVar("changeTime", mob:getBattleTime())
        if mob:AnimationSub() == 2 then
            mob:addMod(tpz.mod.ATTP, 50) -- spider form hits harder
        end
    elseif (mob:AnimationSub() == mob:getLocalVar("form2") and mob:getBattleTime() - changeTime > 60) then
        mob:AnimationSub(0)
        mob:setAggressive(0)
        mob:delMod(tpz.mod.ATTP, 0)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

function onMobDeath(mob, player, isKiller)
end
