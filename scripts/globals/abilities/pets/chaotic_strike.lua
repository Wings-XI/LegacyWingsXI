---------------------------------------------------
-- Chaotic Strike M=9, 2
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/magic")
require("scripts/globals/summon")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 164
    local ele = tpz.damageType.LIGHTNING
    local params = {}
    params.str_wsc = 0.15 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.15 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    local numhits = 3
    local accmod = 1
    local dmgmod = 9
    local dmgmodsubsequent = 2
    local critmod = 1
    local duration = 0
    local totaldamage = 0

    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, TP_NO_EFFECT, 1, 2, 3, critmod, params)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)

    local hits = damage.hitslanded

    if (hits > 0 and totaldamage > 0) then
        while (hits > 0) do
            local resist = applyResistanceAbility(pet,target,tpz.magic.element.LIGHTNING,tpz.skill.ENFEEBLING_MAGIC)
            duration = duration + 5 * resist
            hits = hits -1
        end
    end

    local finalDuration = math.ceil(duration * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))

    if (target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100) then
        if finalDuration > 3 and totaldamage > 0 then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, finalDuration)
        end
    end

    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)

    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
