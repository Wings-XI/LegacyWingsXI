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
--[[
Outline of fight:
Each phase has a starting HP amount. The even-numbered phases start low enough that low-hp mobskills are immediately available and less TP is required to use a mobskill
Odd-numbered phases are dverger form, and are hard-coded to use cackle, then hellsnap, then change phase. No damage can be inflicted. And pets do not cast spells
Each phase, PW has the job's respective 2-hour ability at 50% of the starting HP
Final phase is the "true form" and every 25% uses astral flow, which resummons all pets as well as 8 avatars.
    Everyone except tank should be prepared to get away when this happens, though there's plenty of time to run away unless you get stun locked by pet spells
        "All avatars are summoned at once, and with them plus the lamps up, its hard to move your character."
        "You will probably get locked in place and die from game mechanics alone."
During phase change:
    PW is stunned to interrupt any current action (since it's not dying, just disappearing)
    PL are despawned
    PW/PL are disappeared and model/animation sub are adjusted
    PW reappears and stun is removed
    PL are respawned
    All PW buffs are wiped
    All mobskill LUA were mostly cleared of family-specific restrictions to let this single PW LUA handle everything
        phase change sets skill and spell list for PW and PL
If full wipe happens, DoT will keep PW from regen, which will keep him in current form. If he regens past his phase HP, he resets to phase 1
In each even phase, he has access to the respective mobskills of that mob model:
   - Chariots
     - Phases 2, 4, 6, 8
	 - 10k HP each
	 - Pets: Archaic Gears
   - Gulool Ja Ja
     - Phase 10
	 - 15000 HP
	 - Pets: Mamool Ja
   - Medusa
     - Phase 12
	 - 15000 HP
	 - Pets: Lamiae
   - Gurfurlur the Menacing
     - Phase 14
	 - 15000 HP
	 - Pets: Trolls
   - Khimaira
     - Phase 16
	 - 20000 HP
	 - Pets: Puks
   - Hydra
     - Phase 18
	 - 20000 HP
	 - Pets: Dahaks
   - Cerberus
     - Phase 20
	 - 20000 HP
	 - Pets: Bombs
   - Dvergr
     - Phase 21
	 - 147000 HP
	 - Pets: Miniature Dvergr
--]]
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")

-- Pet Arrays, we'll alternate between phases
local petIDs = {}
petIDs[0] = {ID.mob.PANDEMONIUM_WARDEN +1, ID.mob.PANDEMONIUM_WARDEN +2, ID.mob.PANDEMONIUM_WARDEN +3, ID.mob.PANDEMONIUM_WARDEN +4, ID.mob.PANDEMONIUM_WARDEN +5, ID.mob.PANDEMONIUM_WARDEN +6, ID.mob.PANDEMONIUM_WARDEN +7, ID.mob.PANDEMONIUM_WARDEN +8}
petIDs[1] = {ID.mob.PANDEMONIUM_WARDEN +9, ID.mob.PANDEMONIUM_WARDEN +10, ID.mob.PANDEMONIUM_WARDEN +11, ID.mob.PANDEMONIUM_WARDEN +12, ID.mob.PANDEMONIUM_WARDEN +13, ID.mob.PANDEMONIUM_WARDEN +14, ID.mob.PANDEMONIUM_WARDEN +15, ID.mob.PANDEMONIUM_WARDEN +16}

-- Phase Arrays       Dverg, Char1,  Dverg, Char2,  Dverg, Char3,  Dverg,  Char4,  Dverg,GuloolJ,  Dverg, Medusa,  Dverg,Gurfurl,  Dverg,   Khim,  Dverg,  Hydra,  Dverg,   Cerb,  Dverg
--                             WAR            WAR            WAR             WAR             NIN,            RNG,            MNK,            WAR,            WAR,            WAR,
--                        1      2       3      4       5      6       7       8       9      10      11      12      13      14      15      16      17      18      19      20      21
local mobPhaseHP =      { 147000, 10000, 147000, 10000, 147000, 10000, 147000,  10000, 147000,  15000, 147000,  15000, 147000,  15000, 147000,  20000, 147000,  20000, 147000,  20000, 147000}
local mobModelID = {   1840,  1825,   1840,  1825,   1840,  1825,   1840,   1825,   1840,   1863,   1840,   1865,   1840,   1867,   1840,   1805,   1840,   1796,   1840,   1793,   1840}
local mobSkillID = {   5400,  1000,   5400,  1001,   5400,  1002,   5400,   1003,   5400,    285,   5400,    725,   5400,    326,   5400,    168,   5400,    164,   5400,     62,    316}
local mobSpecID  = {      0,   688,      0,   688,      0,   688,      0,    688,      0,    731,      0,    735,      0,    690,      0,    688,      0,    688,      0,    688,      0}
local mobSpellID = {      0,     0,      0,     0,      0,     0,      0,      0,      0,      7,      0,      0,      0,      0,      0,      0,      0,      0,      0,      0,      2}
-- pets          corpslight, gears, clight, gears, clight, gears, clight,  gears, clight,MamoolJ, clight, Lamiae, clight, Trolls, clight,   Puks, clight, Dahaks, clight,  Bombs,MiniDverg
local petModelID = {   1841,  1820,   1841,  1820,   1841,  1820,   1841,   1820,   1841,   1639,   1841,   1643,   1841,   1682,   1841,   1746,   1841,    421,   1841,    281,   1839}
local petSkillID = {      0,   150,      0,   150,      0,   150,      0,    150,      0,    176,      0,    171,      0,    246,      0,    198,      0,   5009,      0,    300,    316}
local petSpellID = {      0,     0,      0,     0,      0,     0,      0,      0,      0,      2,      0,      3,      0,      1,      0,      0,      0,      0,      0,      0,      2}
--[[
    Their (pet's) form varies depending on what mob the Warden is currently mimicking:
    No phases seem to use AoE elemental magic, and without reworking the core code below if phase ~= 21
        Chariots - Archaic Gears
            Melee only
        Gulool Ja Ja - Mamool Ja
            Some cast blm spells
        Medusa - Lamiae
            some cast rdm spells
        Gurfurlur the Menacing - Trolls
            some cast whm, some cast ninjutsu?
        Hydra - Dahaks
            Melee only
        Khimaira - Puks
            Melee only
        Cerberus - Bombs
            Melee only
        Dvergr - Miniature Dvergr
            All cast blm spells
]]

function onMobSpawn(mob)
    mob:setMod(tpz.mod.STATUSRES, 50)

    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 27000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 27000)
    mob:setMod(tpz.mod.DEF, 450)
    mob:setMod(tpz.mod.MEVA, 300)
    mob:setMod(tpz.mod.MDEF, 50)

    mob:setMod(tpz.mod.MATT, 100)
    mob:setMod(tpz.mod.MACC, 150)

    mob:setMobMod(tpz.mobMod.NO_REST, 1) -- will still regen HP when roaming unless it has a DoT
    -- Make sure model is reset back to start
    mob:setModelId(mobModelID[1])
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
    mob:SetMagicCastingEnabled(false)
end

function onMobDisengage(mob)
    mob:delStatusEffectSilent(tpz.effect.GEO_POISON) -- WINGSCUSTOM DoT first half of each even-numbered phase
    despawnPets()
    mob:SetMagicCastingEnabled(false)
end

function onMobRoam(mob)
    local phase = mob:getLocalVar("phase")

    -- Reset phases (but not despawn timer) when rested to "full" from deaggro
    if phase ~= 1 and mob:getHP() >= mobPhaseHP[phase] then
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
        mob:setTP(3000)
    end
    mob:timer(500, function(mobArg)
        mobArg:SetMagicCastingEnabled(true) -- ensure engages with a TP move always
    end)
    mob:SetMobAbilityEnabled(true)
end

function onMobWeaponSkillPrepare(mob, target)

end

function onMobWeaponSkill(target, mob, skill)

end

function onMobSkillFinished(mob, target, skill)
    local phase = mob:getLocalVar("phase")
    if phase ~= 21 and (phase % 2) == 1 and mob:getLocalVar("phaseChange") ~= 1 then
        -- transitional Dvergar stage, uses cackle, then hellsnap, then changes again
        local hellsnapID = 2113
        if skill:getID() ~= hellsnapID then
            mob:timer(5000, function(mobArg)
                mobArg:useMobAbility(hellsnapID) -- hellsnap
            end)
            mob:timer(10000, function(mobArg) -- enough delay to let the pets get off a long spell (coupled with the timeSinceWS timer)
                mobArg:setLocalVar("phaseChange", 1)
            end)
        end
    end
    mob:setLocalVar("timeSinceWS", os.time())
end

function onMobFight(mob, target)

    -- Init Vars
    local mobHP = mob:getHP()
    local mobHPP = mob:getHPP()
    local depopTime = mob:getLocalVar("PWDespawnTime")
    local phase = mob:getLocalVar("phase")
    local astral = mob:getLocalVar("astralFlow")
    local phaseSpecialID = mob:getLocalVar("usedSpecial") ~= 1 and mobSpecID[phase] or 0 -- "special" refers to 2-hour ability

    -- Check for phase change
    if (phase < 21 and mobHP < 1000) and mob:getLocalVar("phaseChange") ~= 1 then
        mob:setLocalVar("phaseChange", 1)
    end

    if mob:actionQueueEmpty() and mob:getLocalVar("timeSinceWS") < os.time() - 5 then
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

        else
            -- use non-dverger 2-hour at 50% hp of current phase
            if phaseSpecialID > 0 then
                local halfHP = mobPhaseHP[phase] / 2
                if mobHP < halfHP then
                    mob:delStatusEffectSilent(tpz.effect.GEO_POISON) -- WINGSCUSTOM DoT first half of each even-numbered phase
                    mob:useMobAbility(phaseSpecialID)
                    mob:setLocalVar("usedSpecial", 1)
                end
            end
            -- make sure pets weren't dragged off...
            for i = 0, 1 do
                for j = 1, 8 do
                    local pet = GetMobByID(petIDs[i][j])
                    if pet:isAlive() and not pet:isEngaged() then
                        pet:updateEnmity(target)
                    end
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

function onCriticalHit(mob)
    local phase = mob:getLocalVar("phase")
    if phase == 18 then -- Hydra phase
        local critNum = mob:getLocalVar("crits")

        if ((critNum+1) > mob:getLocalVar("CritToTheFace")) then  -- Lose a head
            if (mob:AnimationSub() == 0) then
                mob:AnimationSub(1)
                mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
            elseif (mob:AnimationSub() == 1) then
                mob:AnimationSub(2)
                mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
            else
                -- Meh
            end

            -- Number of crits to lose a head, re-randoming
            mob:setLocalVar("CritToTheFace", math.random(10, 30))

            critNum = 0 -- reset the crits on the NM
        else
            critNum = critNum + 1
        end
        mob:setLocalVar("crits", critNum)
    end
end

function phaseChange(mob)
    local phase = mob:getLocalVar("phase")
    local effects = mob:getStatusEffects()

    -- remove all status effects and stun to interrupt any current action
    for i=1, #effects do
        mob:delStatusEffect(effects[i]:getType())
    end
    if phase > 1 then
        mob:addStatusEffect(tpz.effect.STUN, 1, 0, 10)
    end

    mob:setLocalVar("usedSpecial", 0)

    mob:setMod(tpz.mod.UDMGPHYS   , 0)
    mob:setMod(tpz.mod.UDMGRANGE  , 0)
    mob:setMod(tpz.mod.UDMGBREATH , 0)
    mob:setMod(tpz.mod.UDMGMAGIC  , 0)
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

        -- disappear for a bit, then come back with the new mob model
        mob:timer(4000, function(mob)
            -- WINGSCUSTOM DoT first half of each even-numbered phase
            if mob:getLocalVar("QoL-DoT") == 1 then
                local power = 300
                mob:addStatusEffect(tpz.effect.GEO_POISON, power, 3, 600)
            else
                mob:delStatusEffectSilent(tpz.effect.GEO_POISON)
            end
            mob:setStatus(tpz.status.UPDATE)
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:delStatusEffectSilent(tpz.effect.STUN)
            -- ensure we don't lose claim from forced disengage
            local target = mob:getTarget()
            if target then
                mob:updateClaim(target)
            end
        end)

        mob:AnimationSub(0)
        mob:setMod(tpz.mod.STUNRES, -10)
        -- Number of crits to lose a head, re-randoming
        mob:setLocalVar("CritToTheFace", math.random(10, 30))
        mob:setLocalVar("crits", 0)
        -- dverger phases
        mob:setLocalVar("QoL-DoT", 0)
        if phase % 2 == 1 then
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
            -- takes no damage during intermediate dverger phases
            if phase ~= 21 then
                mob:setMod(tpz.mod.UDMGPHYS   , -100)
                mob:setMod(tpz.mod.UDMGRANGE  , -100)
                mob:setMod(tpz.mod.UDMGBREATH , -100)
                mob:setMod(tpz.mod.UDMGMAGIC  , -100)
                mob:setMod(tpz.mod.STUNRES, 100)
            end
            mob:timer(5000, function(mob)
                mob:setTP(3000)  -- Cackle unless final phase (some other skill will be chosen)
            end)
        else
            mob:setLocalVar("QoL-DoT", 1)
            if phase == 16 or phase == 18 or phase == 20 then
                mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
            else
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
            end
        end

        despawnPets()
        mob:timer(6000, function(mob)
            popPets(mob)
        end)
    end
    mob:setTP(0)

    mob:setModelId(mobModelID[phase])
    mob:setHP(mobPhaseHP[phase])
    mob:setSkillList(mobSkillID[phase])
    mob:setMobMod(tpz.mobMod.SKILL_LIST, mobSkillID[phase])
    mob:setSpellList(mobSpellID[phase])
end

function popPets(mob)
    local phase = mob:getLocalVar("phase")
    if phase ~= 21 then
        despawnPets(phase % 2) -- messes with astral flow doubled-up pets
    end
    local target = mob:getTarget()

    if target ~= nil then
        -- Handle pets
        for i = 1, 8 do
            local newPet = GetMobByID(petIDs[phase % 2][i])
            local oldPet = GetMobByID(petIDs[(phase - 1) % 2][i])
            handlePet(mob, newPet, oldPet, target, petModelID[phase], phase)
        end
    end
end

function handlePet(mob, newPet, oldPet, target, modelId, phase)
    newPet:disengage()
    newPet:setTP(0)
    newPet:setHP(newPet:getMaxHP())
    newPet:setModelId(modelId)
    if phase ~= nil then
        local petSkills = 0
        local petSpells = 0
        if phase > 0 then
            petSkills = petSkillID[phase]
            petSpells = petSpellID[phase]
        end
        if modelId == 1820 then
            newPet:AnimationSub(2)
        else
            newPet:AnimationSub(0)
        end
        -- spells before spawn
        newPet:setSpellList(petSpells)
        newPet:setMobMod(tpz.mobMod.SPELL_LIST, petSpells)
        newPet:spawn()
        -- skills after spawn
        newPet:setMobMod(tpz.mobMod.SKILL_LIST, petSkills)
        newPet:setSkillList(petSkills)

        -- Don't autoattack if no mobskills (corpselights don't auto or cast)
        if petSkills > 0 then
            newPet:SetMobAbilityEnabled(true)
            newPet:SetAutoAttackEnabled(true)
        else
            newPet:SetMobAbilityEnabled(false)
            newPet:SetAutoAttackEnabled(false)
        end
        -- before final phase, not all lamps in a wave use spells
        if petSpells > 0 and (phase == 21 or math.random(1,2) == 1) then
            newPet:SetMagicCastingEnabled(true)
            newPet:setMobMod(tpz.mobMod.MAGIC_DELAY, 4)
            newPet:setMobMod(tpz.mobMod.HP_STANDBACK, 70)
        else
            newPet:SetMagicCastingEnabled(false)
            newPet:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
        end
        newPet:setUnkillable(false)
    else
        -- astral flow avatars
        newPet:spawn()
        newPet:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
    end
    newPet:setPos(mob:getXPos() + 2 * math.random(-2, 2), mob:getYPos(), mob:getZPos() + 2 * math.random(-2, 2))
    newPet:updateEnmity(target)
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