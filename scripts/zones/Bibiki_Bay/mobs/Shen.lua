-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
-----------------------------------

function enterShell()
    local mob = GetMobByID(ID.mob.SHEN)
    mob:AnimationSub(1)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:setMod(tpz.mod.UDMGPHYS, -85)
    mob:setMod(tpz.mod.UDMGRANGE, -85)
    mob:setMod(tpz.mod.UDMGMAGIC, -75)
    mob:setMod(tpz.mod.UDMGBREATH, -75)
    mob:addMod(tpz.mod.REGEN, mob:getLocalVar("[Shen]inShellRegen"))
    mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[Shen]inShellSkillList"))
    mob:setMobMod(tpz.mobMod.SPELL_LIST, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function exitShell()
    local mob = GetMobByID(ID.mob.SHEN)
    mob:AnimationSub(0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.UDMGBREATH, 0)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[Shen]noShellSkillList"))
    mob:setMobMod(tpz.mobMod.SPELL_LIST, mob:getLocalVar("[Shen]noShellSpellList"))
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.UDMGPHYS, -15)
    mob:addMod(tpz.mod.UDMGRANGE, -15)

    local shellTimer = os.time() + 60
    mob:setLocalVar("[Shen]noShellSkillList", 251)
    mob:setLocalVar("[Shen]inShellSkillList", 1170)
    mob:setLocalVar("[Shen]noShellSpellList", 499)
    mob:setLocalVar("[Shen]timeInShellMin", 50)
    mob:setLocalVar("[Shen]timeInShellMax", 70)
    mob:setLocalVar("[Shen]inShellRegen", 100)
    mob:setLocalVar("[Shen]shellTimer", shellTimer)
    exitShell()
end

function onMobFight(mob, target)
    local mobId = mob:getID()
    local petOne = GetMobByID(mobId+1)
    local petTwo = GetMobByID(mobId+2)
    local petCooldown = mob:getLocalVar("[Shen]petCooldown")
    local inShell = mob:getLocalVar("[Shen]inShell")

    local timeToShell = mob:getLocalVar("[Shen]shellTimer")
    if os.time() > timeToShell then
        mob:setLocalVar("[Shen]inShell", 1)
        if inShell == 1 and mob:AnimationSub() == 0 then
            enterShell()

            local timeInShell = math.random(mob:getLocalVar("[Shen]timeInShellMin"), mob:getLocalVar("[Shen]timeInShellMax"))
            mob:timer(timeInShell * 1000, function(mob)
                exitShell()
                local shellTimer = os.time() + 60
                mob:setLocalVar("[Shen]shellTimer", shellTimer)
                mob:setLocalVar("[Shen]inShell", 0)
            end)
        end
    end

    if os.time() >= petCooldown and mob:getBattleTime() % 20 == 0 and mob:getBattleTime() ~= 0 and (petOne:isSpawned() == false or petTwo:isSpawned() == false) then
        mob:castSpell(214)
        mob:setLocalVar("[Shen]petCooldown", os.time() + 20)
    end

    -- Based on capture, Shen exits shell if a pet dies so that it can respawn it
    local petDeath = GetServerVariable("[Shen]Filtrate Death")
    if petDeath == 1 then
        exitShell()
        local shellTimer = os.time() + 60
        mob:setLocalVar("[Shen]shellTimer", shellTimer)
        SetServerVariable("[Shen]Filtrate Death", 0)
    end
end

function onCastStarting(mob, spell)
    local target = mob:getTarget()
    local pos = target:getPos()
    local mobId = mob:getID()
    local petOne = GetMobByID(mobId+1)
    local petTwo = GetMobByID(mobId+2)

    if spell:getID() == 214 then
        spell:castTime(0)

        if petOne:isSpawned() == false then
            SpawnMob(petOne:getID())
            petOne:updateEnmity(target)
            petOne:setPos(pos.x, pos.y, pos.z, pos.rot)
        elseif petTwo:isSpawned() == false then
            SpawnMob(petTwo:getID())
            petTwo:updateEnmity(target)
            petTwo:setPos(pos.x, pos.y, pos.z, pos.rot)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    local mobId = mob:getID()
    for i = 1, 2 do
        local petID = GetMobByID(mobId+i)
        petID:setHP(0)
    end
    SetServerVariable("[Shen]Filtrate Death", 0)
end
