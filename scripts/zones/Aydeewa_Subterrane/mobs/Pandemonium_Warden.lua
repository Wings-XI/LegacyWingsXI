-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Pandemonium Warden
--
-- !pos 200 33 -140 68
-- Spawn with Pandemonium key: !additembyid 2572
-- Wiki: https://ffxiclopedia.fandom.com/wiki/Pandemonium_Warden
-- Videos: https://youtu.be/oOCCjH8isiA
--      https://www.youtube.com/watch?v=T_Us2Tmlm-E
-- Notes: Lamia uses eagle eye shot, safe to say each phase has the respective 2hr?
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")

-- Pet Arrays, we'll alternate between phases
local petIDs = {}
petIDs[0] = {ID.mob.PANDEMONIUM_WARDEN +1, ID.mob.PANDEMONIUM_WARDEN +2, ID.mob.PANDEMONIUM_WARDEN +3, ID.mob.PANDEMONIUM_WARDEN +4, ID.mob.PANDEMONIUM_WARDEN +5, ID.mob.PANDEMONIUM_WARDEN +6, ID.mob.PANDEMONIUM_WARDEN +7, ID.mob.PANDEMONIUM_WARDEN +8}
petIDs[1] = {ID.mob.PANDEMONIUM_WARDEN +9, ID.mob.PANDEMONIUM_WARDEN +10, ID.mob.PANDEMONIUM_WARDEN +11, ID.mob.PANDEMONIUM_WARDEN +12, ID.mob.PANDEMONIUM_WARDEN +13, ID.mob.PANDEMONIUM_WARDEN +14, ID.mob.PANDEMONIUM_WARDEN +15, ID.mob.PANDEMONIUM_WARDEN +16}

-- Phase Arrays       Dverg, Char1,  Dverg, Char2,  Dverg, Char3,  Dverg,  Char4,  Dverg,   Mamo,  Dverg,  Lamia,  Dverg,  Troll,  Dverg,   Khim,  Dverg,  Hydra,  Dverg,   Cerb,  Dverg
--                        1      2       3      4       5      6       7       8       9      10      11      12      13      14      15      16      17      18      19      20      21
local triggerHPP = {     95,     2,     95,     2,     95,     2,     95,      2,     95,      2,     95,      2,     95,      2,     95,      2,     95,      2,     95,      2}
local mobHP =      { 147000, 10000, 147000, 10000, 147000, 10000, 147000,  10000, 147000,  15000, 147000,  15000, 147000,  15000, 147000,  20000, 147000,  20000, 147000,  20000, 147000}
local mobModelID = {   1840,  1825,   1840,  1825,   1840,  1825,   1840,   1825,   1840,   1863,   1840,   1865,   1840,   1867,   1840,   1805,   1840,   1796,   1840,   1793,   1840}
local mobSkillID = {   5308,  1000,   5308,  1001,   5308,  1002,   5308,   1003,   5308,    285,   5308,    725,   5308,    326,   5308,    168,   5308,    164,   5308,     62,    316}
-- local mobSpellID = {    316,  1000,    316,  1001,    316,  1002,    316,   1003,    316,    285,    316,    725,    316,    326,    316,     62,    316,    164,    316,    168,    316}
local petModelID = {   1841,  1820,   1841,  1820,   1841,  1820,   1841,   1820,   1841,   1639,   1841,   1643,   1841,   1680,   1841,   1746,   1841,    421,   1841,    281,   1839}
-- local petSkillID = {   1841,  1823,   1841,  1821,   1841,  1825,   1841,   1824,   1841,   1639,   1841,   1643,   1841,   1680,   1841,    281,   1841,    421,   1841,   1746,   1839}
-- local petSpellID = {   1841,  1823,   1841,  1821,   1841,  1825,   1841,   1824,   1841,   1639,   1841,   1643,   1841,   1680,   1841,    281,   1841,    421,   1841,   1746,   1839}
--[[
    Their (pet's) form varies depending on what mob the Warden is currently mimicking:
        Chariots - Archaic Gears
        Gulool Ja Ja - Mamool Ja
        Medusa - Lamiae
        Gurfurlur the Menacing - Trolls
        Hydra - Dahaks
        Khimaira - Puks
        Cerberus - Bombs
        Dvergr - Miniature Dvergr
]]

function onMobSpawn(mob)

    mob:setMod(tpz.mod.DEF, 450)
    mob:setMod(tpz.mod.MEVA, 380)
    mob:setMod(tpz.mod.MDEF, 50)
    mob:setMobMod(tpz.mobMod.NO_REST, 1) -- will still regen HP when roaming unless it has a DoT
    -- Make sure model is reset back to start
    mob:setModelId(1840)
    -- Prevent death and hide HP until final phase
    mob:setUnkillable(true)
    mob:hideHP(true)

    -- 2.5 hours to forced depop
    mob:setLocalVar("PWDespawnTime", os.time() + 9000)
    mob:setLocalVar("[rage]timer", 7200) -- 2 hours
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)

    mob:setLocalVar("phase", 1)
    mob:setLocalVar("astralFlow", 1)

    phaseChange(mob)
end

function onMobDisengage(mob)
    despawnPets()
end

function onMobRoam(mob)
    local phase = mob:getLocalVar("phase")

    -- Reset phases (but not despawn timer) when rested to "full" from deaggro
    if phase ~= 1 and mob:getHP() >= mobHP[phase] then
        -- Prevent death and hide HP until final phase
        mob:setUnkillable(true)
        mob:hideHP(true)

        mob:setLocalVar("phase", 1)
        mob:setLocalVar("astralFlow", 1)

        phaseChange(mob)
    end
end

function onMobEngaged(mob, target)
    popPets(mob, target)

    local phase = mob:getLocalVar("phase")

    if phase % 2 == 1 then
        mob:useMobAbility()
    end
end

function onMobWeaponSkillPrepare(mob, target)

end

function onMobWeaponSkill(target, mob, skill)

end

function onMobSkillFinished(mob, target, skill)
    local phase = mob:getLocalVar("phase")
    if phase ~= 21 and (phase % 2) == 1 and mob:getLocalVar("phaseChange") ~= 1 then
        -- transitional Dvergar stage, uses cackle, then hellsnap, then changes again
        if skill:getName() == "Cackle" then
            mob:timer(2000, function(mobArg)
                mobArg:useMobAbility(2113) -- hellsnap
            end)
        else
            mob:setLocalVar("phaseChange", 1)
        end
    end
end

function onMobFight(mob, target)

    -- Init Vars
    local mobHPP = mob:getHPP()
    local depopTime = mob:getLocalVar("PWDespawnTime")
    local phase = mob:getLocalVar("phase")
    local astral = mob:getLocalVar("astralFlow")

    -- Check for phase change
    if (phase < 21 and mobHPP <= triggerHPP[phase]) and mob:getLocalVar("phaseChange") ~= 1 then
        mob:setLocalVar("phaseChange", 1)
    end

    if mob:getLocalVar("phaseChange") == 1 then
        mob:setLocalVar("phaseChange", 0)

        -- Increment phase
        -- phase = mob:getLocalVar("phase") + 1
        mob:setLocalVar("phase", mob:getLocalVar("phase") + 1)

        phaseChange(mob)

    -- Or, check for Astral Flow
    elseif (phase == 21 and astral < 4 and mobHPP <= (99 - 25 * astral)) then

        mob:setLocalVar("astralFlow", astral + 1)

        -- ensure pets are there
        popPets(mob)
        -- "All avatars are summoned at once, and with them plus the lamps up, its hard to move your character."
        -- "You will probably get locked in place and die from game mechanics alone."
        for i = 1, 8 do
            -- during last phase, pets are always index 1 and astral flows are always index 0
            newPet = GetMobByID(petIDs[0][i])
            oldPet = GetMobByID(petIDs[1][i])
            handlePet(mob, newPet, oldPet, target, 790 +i)
            newPet:setUnkillable(true)
            newPet:SetAutoAttackEnabled(false)
            newPet:SetMagicCastingEnabled(false)
            newPet:SetMobAbilityEnabled(false)
        end

    -- Or, at least make sure pets weren't dragged off...
    else
        for i = 0, 1 do
            for j = 1, 8 do
                local pet = GetMobByID(petIDs[i][j])
                if pet:isAlive() and not pet:isEngaged() then
                    pet:updateEnmity(target)
                end
            end
        end
    end

    -- Check for time limit, too
    if (os.time() > depopTime and mob:actionQueueEmpty() == true) then
        DespawnMob(ID.mob.PANDEMONIUM_WARDEN)
    --  printf("Timer expired at %i. Despawning Pandemonium Warden.", depopTime)
    end
end

function onMobDeath(mob, player, isKiller)

    if player ~= nil then
        player:addTitle(tpz.title.PANDEMONIUM_QUELLER)
        player:messageSpecial(ID.text.PW_END_OF_NOTHING)
    end

    despawnPets()
end

function onMobDespawn(mob)
    despawnPets()
end

function phaseChange(mob)
    local phase = mob:getLocalVar("phase")

    if (phase == 21) then -- Prepare for death
        mob:hideHP(false)
        mob:setUnkillable(false)
    end

    -- Change phase

    if phase > 1 then
        mob:setStatus(tpz.status.DISAPPEAR)
        -- mob:setStatus(tpz.status.INVISIBLE)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)

        mob:timer(4000, function(mob)
            mob:setStatus(tpz.status.UPDATE)
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
        end)

        if phase % 2 == 1 then
            mob:timer(5000, function(mob)
                mob:useMobAbility()  -- Cackle unless final phase (some other skill will be chosen)
            end)
        end

        despawnPets()
        mob:timer(6000, function(mob)
            popPets(mob)
        end)
    end
    mob:setTP(0)

    mob:setModelId(mobModelID[phase])
    mob:setHP(mobHP[phase])
    mob:setSkillList(mobSkillID[phase])
end

function popPets(mob)
    local phase = mob:getLocalVar("phase")

    despawnPets(phase % 2)
    local target = mob:getTarget()

    if target ~= nil then
        -- Handle pets
        for i = 1, 8 do
            local newPet = GetMobByID(petIDs[phase % 2][i])
            local oldPet = GetMobByID(petIDs[(phase - 1) % 2][i])
            newPet:setMobMod(tpz.mobMod.MAGIC_DELAY, 4)
            handlePet(mob, newPet, oldPet, target, petModelID[phase])
        end
    end
end

function handlePet(mob, newPet, oldPet, target, modelId)
    newPet:disengage()
    newPet:setModelId(modelId)
    if modelId == 1820 then
        newPet:AnimationSub(2)
    else
        newPet:AnimationSub(0)
    end
    newPet:spawn()
    newPet:setPos(mob:getXPos() + math.random(-2, 2), mob:getYPos(), mob:getZPos() + math.random(-2, 2))
    newPet:updateEnmity(target)

    newPet:SetAutoAttackEnabled(true)
    newPet:SetMagicCastingEnabled(true)
    newPet:SetMobAbilityEnabled(true)

    newPet:setUnkillable(false)
end

function despawnPets(modulo)
    -- Despawn pets
    for i = 0, 1 do
        if modulo == nil or modulo ~= i then
            for j = 1, 8 do
                if GetMobByID(petIDs[i][j]):isSpawned() then
                    DespawnMob(petIDs[i][j])
                end
            end
        end
    end
end