-----------------------------------
-- Area: Sealion's Den
--  Mob: Tenzen
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Sealions_Den/IDs")
require("scripts/globals/msg")
-----------------------------------

function onMobSpawn(mob)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 10)
    mob:AnimationSub(0)
    mob:SetMobSkillAttack(0)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:setUnkillable(true)
    mob:setLocalVar("skillchain", math.random(100)) -- set chance that Tenzen will use Cosmic Elucidation
    mob:setLocalVar("twohourthreshold", math.random(75, 80)) -- set HP threshold for Meikyo Shisui usage
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.TENZEN_MSG_OFFSET +1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    -- three tarus fight with tenzen
    local mobId = mob:getID()
    local offset = mobId - ID.mob.WARRIORS_PATH_OFFSET
    if (offset >= 0 and offset <= 8) then
        for i = mobId + 1, mobId + 3 do
            GetMobByID(i):updateEnmity(target)
        end
    end
end

function onMobFight(mob, target)
    -- Uses Meikyo Shisui around 75-80% Hanaikusa > Torimai > Kazakiri > Tsukikage > Cosmic Elucidation
    local hpp = mob:getHPP()
    local meikyo = mob:getLocalVar("meikyo")
    local step = mob:getLocalVar("step")
    local twohourtrigger = mob:getLocalVar("twohourtrigger")
    local twohourthreshold = mob:getLocalVar("twohourthreshold")
    if mob:getHPP() < twohourthreshold and twohourtrigger == 0 then -- first meikyo shisui usage 75-85%
        mob:AnimationSub(0)
        mob:useMobAbility(730)
        mob:setLocalVar("meikyo", 1)
        mob:setLocalVar("step", 1)
        mob:setLocalVar("twohourtrigger", 1) -- prevent tenzen from using second meikyo while first one is active
        mob:setLocalVar("twohourthreshold", math.random(45, 55)) -- set next meikyo hpp threshold
    elseif mob:getHPP() < twohourthreshold and twohourtrigger == 2 then -- second meikyo shisui usage 45-55%
        mob:useMobAbility(730)
        mob:setLocalVar("meikyo", 1)
        mob:setLocalVar("step", 1)
        mob:setLocalVar("twohourtrigger", 3)
    end

    local isBusy = false
    local act = mob:getCurrentAction()
    if act == tpz.act.MOBABILITY_START or act == tpz.act.MOBABILITY_USING or act == tpz.act.MOBABILITY_FINISH then
            isBusy = true -- is set to true if Tenzen is in any stage of using a mobskill
    end

    -- scripted sequence of weaponskills in order to potentially create the level 4 skillchain cosmic elucidation
    if mob:actionQueueEmpty() == true and not isBusy then
        local step = mob:getLocalVar("step")
        local meikyo = mob:getLocalVar("meikyo")
        local battlefield = mob:getBattlefield()
        if step == 1 and meikyo == 1 then
            mob:setMod(tpz.mod.DELAY, 0)
            mob:AnimationSub(0)
            mob:SetMobSkillAttack(0)
            mob:SetMobAbilityEnabled(false) -- we don't want tenzen to randomly use WS during this phase
            mob:SetAutoAttackEnabled(false) -- no autoattacks while skillchaining
            mob:useMobAbility(1394) -- Hanaikusa
            mob:setLocalVar("step", 2)
        elseif step == 2 then
            mob:timer(250, function(mob)
                mob:useMobAbility(1390) -- Torimai
                mob:setLocalVar("step", 3)
            end)
        elseif step == 3 then
            mob:timer(250, function(mob)
                mob:useMobAbility(1391) -- Kazakiri
                mob:setLocalVar("step", 4)
            end)
        elseif step == 4 then
            if mob:getLocalVar("skillchain") > 75 then -- 25% chance to trigger skillchain
                mob:timer(250, function(mob)
                    if mob:getLocalVar("skillchain") > 75 then
                        mob:useMobAbility(1395) -- Tsukikage
                        mob:setLocalVar("step", 5)
                    end
                end)
            else
                mob:setLocalVar("changeTime", mob:getBattleTime()) -- don't go back to bow form right away
                mob:setLocalVar("step", 0)
                mob:setLocalVar("meikyo", 0) -- reset for next meikyo and allow tenzen to now swap to bow form
                mob:setLocalVar("skillchain", math.random(100)) -- calculate next skillchain success chance
                mob:SetMobAbilityEnabled(true)
                mob:SetAutoAttackEnabled(true)
                if mob:getLocalVar("twohourtrigger") == 1 then
                    mob:setLocalVar("twohourtrigger", 2) -- prevent tenzen from using second meikyo while first one is active
                end
            end
        elseif step == 5 then
            mob:useMobAbility(1399) -- Cosmic Elucidation
            mob:setLocalVar("step", 6)
            mob:timer(3000, function(mob, target)
                battlefield:setLocalVar("gameover", battlefield:getRemainingTime()) -- initiate loss condition trigger & record the time remaining
                mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                mob:showText(target, ID.text.TENZEN_MSG_OFFSET +1)
            end)
        end
    end

    local changeTime = mob:getLocalVar("changeTime")
    local battleTime = mob:getBattleTime()
    local random = math.random(5, 6)
    if mob:getLocalVar("meikyo") == 0 then
        if (mob:AnimationSub() == 0 and battleTime - changeTime > 60) then
            mob:AnimationSub(5) -- 5 lowered bow mode (1033 animation) 6 is raised bow mode (1034 animation)
            mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
            mob:SetMobSkillAttack(1169)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            if mob:AnimationSub() == 5 then -- need to sheath his great katana before pulling out bow
                mob:timer(1000, function(mob)
                    mob:setMod(tpz.mod.DELAY, 2400) -- attacks more frequently while bow is drawn
                    mob:AnimationSub(6)
                end)
            end
        elseif (mob:AnimationSub() == 6 and battleTime - changeTime > 30) then
            mob:AnimationSub(0)
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
            mob:SetMobSkillAttack(0)
            mob:setMod(tpz.mod.DELAY, 0) -- attack slower back to great katana
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end

    -- win condition set
    local battlefield = mob:getBattlefield()
    if (battlefield:getID() == 993 and mob:getHPP() <= 15) then -- Tenzen gives up at 15% - win
        mob:showText(target, ID.text.TENZEN_MSG_OFFSET +2)
        mob:AnimationSub(5)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        battlefield:win()
        return
    end

    if mob:actionQueueEmpty() == true and not isBusy then
        if mob:getHPP() <= 70 and mob:getLocalVar("riceball") == 0 then
            if mob:getLocalVar("gameover") ~= 1 then
                mob:showText(target, ID.text.TENZEN_MSG_OFFSET +3)
                mob:useMobAbility(1398)
                mob:addMod(tpz.mod.ATT, 50)
                mob:addMod(tpz.mod.DEF, 30)
                mob:setMod(tpz.mod.DOUBLE_ATTACK, 5)
                mob:addMod(tpz.mod.DEX, 4)
                mob:addMod(tpz.mod.VIT, 4)
                mob:addMod(tpz.mod.CHR, 4)
                mob:setLocalVar("riceball", 1)
            end
        end
    end

    if mob:getHPP() > 35 then 
        mob:setMod(tpz.mod.REGAIN, 30)
    else
        mob:setMod(tpz.mod.REGAIN, 70)
    end
end

function onMobDeath(mob, player, isKiller)
end
