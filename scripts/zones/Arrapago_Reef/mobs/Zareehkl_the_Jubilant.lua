-----------------------------------
-- Area: Arrapago Reef
--  ZNM: Zareehkl the Jubilant
-- Note: I've disabled the weapon breaking mechanic because I couldn't find any evidences
--       this mechanic applies to him, this looks like a purely scripted fight.
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage"),
--    require("scripts/mixins/families/qutrub"),
}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)

    -- sometimes triple attack
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 15)

    -- immune to stun and slow/elegy
    mob:setMod(tpz.mod.STUNRES, 100)
    mob:setMod(tpz.mod.SLOWRES, 100)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 4500)
    -- prevent weapon breaking and start w/o sword
    mob:setLocalVar("qutrubBreakChance", 0)

    -- starts w/o weapon
    mob:AnimationSub(1)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMobSkillAttack(0)
    mob:setMod(tpz.mod.DELAY, 0)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 303)
    mob:setLocalVar("cleaves", 0)

    -- last phase/blood weapon mechanic
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.BLOOD_WEAPON,
                duration = 30,
                hpp = math.random(25, 33),
                chance = 100,
                endCode = function(mob)
                    -- will not use any magic or tp move during blood weapon
                    mob:AnimationSub(2)
                    mob:SetAutoAttackEnabled(true)
                    mob:SetMagicCastingEnabled(false)
                    mob:SetMobAbilityEnabled(false)
                    mob:SetMobSkillAttack(0)

                    -- will just spam leaping cleave and unblest jambiya until death after BW is over
                    mob:addListener("EFFECT_LOSE", "BLOOD_WEAPON", function(mob, effect)
                        if effect:getType() == tpz.effect.BLOOD_WEAPON then
                            mob:removeListener("BLOOD_WEAPON")
                            mob:SetMobAbilityEnabled(true)
                            mob:SetMobSkillAttack(5303)
                            mob:setMod(tpz.mod.DELAY, 2750)
                            mob:setMobMod(tpz.mobMod.SKILL_LIST, 0)
                            -- gets really angry at everyone attacking
                            mob:addListener("TAKE_DAMAGE", "DMG_TAKE", function(mob, _, attacker, attackType)
                                if attackType == tpz.attackType.PHYSICAL and ( attacker:isPC() or attacker:isPet() ) then
                                    mob:addEnmity(attacker, 1, 3000)
                                end
                            end)
                            mob:addListener("MAGIC_TAKE", "MDMG_TAKE", function(target, caster)
                                if caster:isPC() or caster:isPet() then
                                    target:addEnmity(caster, 1, 3000)
                                end
                            end)
                            mob:addListener("WEAPONSKILL_TAKE", "WSDMG_TAKE", function(target, attacker)
                                if attacker:isPC() or caster:isPet() then
                                    target:addEnmity(attacker, 1, 3000)
                                end
                            end)
                        end
                    end)
                end,
            },
        },
    })
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getMobMod(tpz.mobMod.SKILL_LIST) == 0 then
        local cleaves = mob:getLocalVar("cleaves")
        if cleaves >= math.random(8, 16) then
            mob:useMobAbility(1784)
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local skillID = skill:getID()
    if skillID == 1784 then
        -- reset cleaves after unblest jambiya
        mob:setLocalVar("cleaves", 0)
    elseif skillID == 2363 then
        -- keep track of every cleaves to trigger jambiya every once in a while
        mob:setLocalVar("cleaves", mob:getLocalVar("cleaves") + 1)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    -- remove every listeners
    local listeners = { "BLOOD_WEAPON", "DMG_TAKE", "MDMG_TAKE", "WSDMG_TAKE", }
    for _, v in ipairs(listeners) do
        mob:removeListener(v)
    end
end