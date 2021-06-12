-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-800
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:SetMagicCastingEnabled(false)
end

function onMobFight(mob, target)
    local form = mob:AnimationSub()

    -- Mammets seem to be able to change to any given form, per YouTube videos
    -- Added a random chance to change forms every 3 seconds if 60 seconds have passed, just to make things less formulaic.
        -- May be able to change forms more often.  Witnessed one at ~50 seconds, most were 60-80.
        -- Believe it or not, these changes may be too slow @ 50% chance.  Probability is a pain.
    if ((mob:getBattleTime() > mob:getLocalVar('changeTime') + 60 or mob:getLocalVar('changeTime') == 0) and math.random(0, 1) == 1
        and not mob:hasStatusEffect(tpz.effect.FOOD)) then
        changeForm(mob)
    end
end

function onMobEngaged(mob, target)
    -- This is actually called each time a mob engages from a passive stance - ensure to trigger spawn behavior once and only once
    local mobID = mob:getID()
    if mobID == 16904233 or mobID == 16904243 or mobID == 16904253 then -- If this is the initial Mammet-800 in a BCNM
        local battlefield = mob:getBattlefield()
        if mob:getLocalVar("AlreadyEngagedOnce") == 0 then
            mob:setLocalVar("AlreadyEngagedOnce", 1) -- only trigger the additional spawn logic once - or if players wipe we could respawn mammets that were killed
            local players = battlefield:getPlayers()
            local playersCount = table.getn(players)
            local spawnId = mobID
            for i = 3, playersCount, 2 do
                if i==19 then
                    break -- How did we cram more than 18 ppl into this BCNM? 
                 end
                spawnId = spawnId + 1
                SpawnMob(spawnId):updateEnmity(target)
            end
        end
    end

end

function changeForm(mob)
    local newform = math.random(0, 2)
    if (mob:AnimationSub() == newform) then
        newform = 3
    end
    -- setDamage works beautifully, but setDelay doesn't seem to be working.  Increased DMG turned off.
    if (newform == 0) then -- Hand Form, ~3s delay
        mob:SetMagicCastingEnabled(false)
        mob:setDelay(2400)
        mob:setDamage(40)
    elseif (newform == 1) then -- Sword Form, ~2s delay
        mob:SetMagicCastingEnabled(false)
        mob:setDelay(1500)
        mob:setDamage(40)
    elseif (newform == 2) then -- Polearm Form, ~3-3.5s delay
        mob:SetMagicCastingEnabled(false)
        mob:setDelay(3250)
        mob:setDamage(75)
    elseif (newform == 3) then -- Staff Form, ~4s delay, ~10 seconds between spell ends and next cast
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
        mob:SetMagicCastingEnabled(true)
        mob:setDelay(3700)
        mob:setDamage(40)
    end
    mob:AnimationSub(newform)
    mob:setLocalVar('changeTime', mob:getBattleTime())
end

function onMobDeath(mob, player, isKiller)
end
