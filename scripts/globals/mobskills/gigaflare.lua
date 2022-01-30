---------------------------------------------
--  Gigaflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Bv1: Used by Bahamut when at 10% of its HP, and can use anytime afterwards at will.
--  Notes: Bv2: Used by Bahamut when at 60%, 50%, 40%, 30%, 20% of its HP.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()

    if (mob:getID() == 16896156 and mobhp <= 10) then -- set up Gigaflare for being called by the script again.
        mob:setLocalVar("GigaFlare", 0)
        mob:SetMobAbilityEnabled(false) -- disable mobskills/spells until Gigaflare is used successfully (don't want to delay it/queue Megaflare)
        mob:SetMagicCastingEnabled(false)
    elseif (mob:getID() == 16896157 and mob:getLocalVar("TeraFlare") ~= 0) then -- make sure Teraflare has happened first - don't want a random Gigaflare to block it.
        mob:setLocalVar("GigaFlareQueue", 1) -- set up Gigaflare for being called by the script again.
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    if (mob:getID() == 16896156) then
        mob:setLocalVar("GigaFlare", 1) -- When set to 1 the script won't call it.
        mob:setLocalVar("tauntShown", 0)
        mob:SetMobAbilityEnabled(true) -- enable the spells/other mobskills again
        mob:SetMagicCastingEnabled(true)
        if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) == 0) then -- re-enable noturn
            mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
        end
    elseif (mob:getID() == 16896157) then
        local GigaFlareQueue = mob:getLocalVar("GigaFlareQueue")
        mob:setLocalVar("GigaFlareQueue", 0)
        mob:setLocalVar("FlareWait", 0) -- reset the variables for Xflare.
        mob:setLocalVar("tauntShown", 0)
        mob:SetMobAbilityEnabled(true) -- re-enable the other actions on success
        mob:SetMagicCastingEnabled(true)
        mob:SetAutoAttackEnabled(true)
        if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) == 0) then -- re-enable noturn
            mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
        end
    end

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*8, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
