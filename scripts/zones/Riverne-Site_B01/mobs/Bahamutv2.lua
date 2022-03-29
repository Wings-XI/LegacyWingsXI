-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut v2
-- BCNM: Wyrmking Descends
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setTrueDetection(3)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 50)
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 10)
    mob:addMod(tpz.mod.REGAIN, 300)
    mob:addMod(tpz.mod.REGEN, 50)
    mob:addMod(tpz.mod.MDEF, 80)
    mob:setMod(tpz.mod.ATT, 200)
    mob:setMod(tpz.mod.ATTP, 100)
    mob:addStatusEffect(tpz.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(tpz.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(tpz.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(tpz.effect.SHELL, 24, 0, 1800)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetAutoAttackEnabled(true)
    
    -- Shuffling the Wyrm table to randomize spawn order
    Wyrms = {1, 2, 3, 4}
    shuffled = {}
    for i, v in ipairs(Wyrms) do
        local pos = math.random(1, #shuffled+1)
        table.insert(shuffled, pos, v)
    end 
    y = 1
end

function onMobEngaged(mob, target)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    local MegaFlareQueue = mob:getLocalVar("MegaFlareQueue")
    local MegaFlareTrigger = mob:getLocalVar("MegaFlareTrigger")
    local GigaFlareQueue = mob:getLocalVar("GigaFlareQueue")
    local GigaFlareTrigger = mob:getLocalVar("GigaFlareTrigger")
    local FlareWait = mob:getLocalVar("FlareWait")
    local GigaFlare = mob:getLocalVar("GigaFlare")
    local TeraFlare = mob:getLocalVar("TeraFlare")
    local tauntShown = mob:getLocalVar("tauntShown")
    local mobHPP = mob:getHPP()
    local isBusy = false
    local act = mob:getCurrentAction()

    if act == tpz.act.MOBABILITY_START or act == tpz.act.MOBABILITY_USING or act == tpz.act.MOBABILITY_FINISH or act == tpz.act.MAGIC_START or act == tpz.act.MAGIC_CASTING or act == tpz.act.MAGIC_START then
        isBusy = true -- is set to true if Bahamut is in any stage of using a mobskill or casting a spell
    end

    if (mob:actionQueueEmpty() == true and isBusy == false) then
        if (mobHPP < 90 and MegaFlareTrigger < 1) then -- if Megaflare hasn't been set to be used this many times, increase the queue of Megaflares. This will allow it to use multiple Megaflares in a row if the HP is decreased quickly enough.
            mob:setLocalVar("MegaFlareTrigger", 1)
            mob:setLocalVar("MegaFlareQueue", 1)
        elseif (mobHPP < 80 and MegaFlareTrigger < 2) then
            mob:SetMobAbilityEnabled(false) mob:SetMagicCastingEnabled(false) mob:SetAutoAttackEnabled(false)
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 5)
            mob:timer(1000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 6) end)
            mob:timer(2000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 7) end)
            mob:timer(3000 , function(mob) mob:useMobAbility(1550) mob:SetMobAbilityEnabled(true) mob:SetMagicCastingEnabled(true) mob:SetAutoAttackEnabled(true) end)
            mob:setLocalVar("MegaFlareTrigger", 2)
            mob:setLocalVar("MegaFlareQueue", 1)
        elseif (mobHPP < 70 and MegaFlareTrigger < 3) then
            mob:setLocalVar("MegaFlareTrigger", 3)
            mob:setLocalVar("MegaFlareQueue", 1)
        elseif (mobHPP < 60 and GigaFlareTrigger < 1) then
            mob:SetMobAbilityEnabled(false) mob:SetMagicCastingEnabled(false) mob:SetAutoAttackEnabled(false)
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 5)
            mob:timer(1000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 6) end)
            mob:timer(2000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 7) end)
            mob:timer(3000 , function(mob) mob:useMobAbility(1550) mob:SetMobAbilityEnabled(true) mob:SetMagicCastingEnabled(true) mob:SetAutoAttackEnabled(true) end)
            mob:setLocalVar("GigaFlareTrigger", 1)
            mob:setLocalVar("GigaFlareQueue", 1)
        elseif (mobHPP < 50 and GigaFlareTrigger < 2) then
            mob:setLocalVar("GigaFlareTrigger", 2)
            mob:setLocalVar("GigaFlareQueue", 1)
        elseif (mobHPP < 40 and GigaFlareTrigger < 3) then
            mob:SetMobAbilityEnabled(false) mob:SetMagicCastingEnabled(false) mob:SetAutoAttackEnabled(false)
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 5)
            mob:timer(1000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 6) end)
            mob:timer(2000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 7) end)
            mob:timer(3000 , function(mob) mob:useMobAbility(1550) mob:SetMobAbilityEnabled(true) mob:SetMagicCastingEnabled(true) mob:SetAutoAttackEnabled(true) end)
            mob:setLocalVar("GigaFlareTrigger", 3)
            mob:setLocalVar("GigaFlareQueue", 1)
        elseif (mobHPP < 30 and GigaFlareTrigger < 4) then
            mob:setLocalVar("GigaFlareTrigger", 4)
            mob:setLocalVar("GigaFlareQueue", 1)
        elseif (mobHPP < 20 and GigaFlareTrigger < 5) then
            mob:SetMobAbilityEnabled(false) mob:SetMagicCastingEnabled(false) mob:SetAutoAttackEnabled(false)
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 5)
            mob:timer(1000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 6) end)
            mob:timer(2000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 7) end)
            mob:timer(3000 , function(mob) mob:useMobAbility(1550) mob:SetMobAbilityEnabled(true) mob:SetMagicCastingEnabled(true) mob:SetAutoAttackEnabled(true) end)
            mob:setLocalVar("GigaFlareTrigger", 5)
            mob:setLocalVar("GigaFlareQueue", 1)
        end
    end

    if (mob:actionQueueEmpty() == true and isBusy == false) then -- the last check prevents multiple Mega/Gigaflares from being called at the same time.
        if (MegaFlareQueue > 0) then -- can we add and GigaFlareQueue == 0 to skip megaflare and move onto giga's
            mob:SetMobAbilityEnabled(false) -- disable all other actions until Megaflare is used successfully
            mob:SetMagicCastingEnabled(false)
            mob:SetAutoAttackEnabled(false)
            if (FlareWait == 0 and tauntShown == 0) then -- if there is a queued Megaflare and the last Megaflare has been used successfully or if the first one hasn't been used yet.
                target:showText(mob, ID.text.BAHAMUT_TAUNT)
                mob:setLocalVar("FlareWait", mob:getBattleTime() + 2) -- second taunt happens two seconds after the first.
                mob:setLocalVar("tauntShown", 1)
            elseif (FlareWait < mob:getBattleTime() and FlareWait ~= 0 and tauntShown >= 0) then -- the wait time between the first and second taunt as passed. Checks for wait to be not 0 because it's set to 0 on successful use.
                if (tauntShown == 1) then
                    mob:setLocalVar("tauntShown", 2) -- if Megaflare gets stunned it won't show the text again, until successful use.
                    target:showText(mob, ID.text.BAHAMUT_TAUNT + 12)
                end
                if (mob:checkDistance(target) <= 15) then -- without this check if the target is out of range it will keep attemping and failing to use Megaflare. Both Megaflare and Gigaflare have range 15.
                    if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- default behaviour
                        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
                    end
                    mob:useMobAbility(1551)
                end
            end
        elseif (GigaFlareQueue > 0) then
            mob:SetMobAbilityEnabled(false) -- disable all other actions until Gigaflare is used successfully
            mob:SetMagicCastingEnabled(false)
            mob:SetAutoAttackEnabled(false)
            if (FlareWait == 0 and tauntShown == 0) then -- if there is a queued Xflare and the last Xflare has been used successfully or if the first one hasn't been used yet.
                target:showText(mob, ID.text.BAHAMUT_TAUNT + 13)
                mob:setLocalVar("FlareWait", mob:getBattleTime() + 2) -- second taunt happens two seconds after the first.
                mob:setLocalVar("tauntShown", 1)
            elseif (FlareWait < mob:getBattleTime() and FlareWait ~= 0 and tauntShown >= 0) then -- the wait time between the first and second taunt as passed. Checks for wait to be not 0 because it's set to 0 on successful use.
                if (mob:checkDistance(target) <= 15) then -- without this check if the target is out of range it will keep attemping and failing to use Megaflare. Both Megaflare and Gigaflare have range 15.
                    if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- default behaviour
                        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
                    end
                    mob:useMobAbility(1552)
                end
            end
        end
    end
        if (mobHPP < 10 and TeraFlare < 1 and mob:checkDistance(target) <= 15) then  -- All of the scripted MegaFlares and Gigaflares are to happen before Teraflare.
            if (tauntShown == 0) then
                mob:SetMobAbilityEnabled(false)
                mob:SetMagicCastingEnabled(false)
                mob:SetAutoAttackEnabled(false)
                target:showText(mob, ID.text.BAHAMUT_TAUNT + 14)
                mob:timer(1000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 15) end)
                mob:timer(2000 , function(mob, target) mob:showText(mob, ID.text.BAHAMUT_TAUNT + 16) end)
                mob:timer(3000 , function(mob) mob:SetMobAbilityEnabled(true) mob:SetMagicCastingEnabled(true) mob:SetAutoAttackEnabled(true) end)
                mob:setLocalVar("tauntShown", 3) -- again, taunt won't show again until the move is successfully used.
            end
            if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- default behaviour
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
            end
            if (mob:actionQueueEmpty() == true and isBusy == false) then 
            mob:useMobAbility(1553)
            end
        end

        -- Make sure if Wyrms deaggro that they assist Bahamut's target
        for i = ID.mob.BAHAMUT_V2 + 1, ID.mob.BAHAMUT_V2 + 4 do
            local wyrm = GetMobByID(i)
            if (wyrm:getCurrentAction() == tpz.act.ROAMING) then
                wyrm:updateEnmity(target)
            end
        end
    
end

function onMobWeaponSkill(target, mob, skill)    
    --Summon Wyrms in a random order 
    if skill:getID() == 1550 then
        mob:setLocalVar("randWyrm", shuffled[y])
        x = shuffled[y]
        y = y + 1
     end   
end

function onMobDisengage(mob)
    -- In case of wipe during Flares, this will reset Bahamut
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetAutoAttackEnabled(true)
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 17)
        mob:timer(3000 , function(mob) mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 18) end)
        mob:timer(6000 , function(mob) mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 19) end)
        mob:timer(9000 , function(mob) mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 20) end)
    end
    for i = 1, 16 do DespawnMob(ID.mob.BAHAMUT_V2 + i) end
end