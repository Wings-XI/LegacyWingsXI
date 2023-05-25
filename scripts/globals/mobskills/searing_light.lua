---------------------------------------------------
-- Searing Light
-- Deals light elemental damage to enemies within area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    mob:messageBasic(tpz.msg.basic.READIES_WS, 0, skill:getID())
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dINT = math.floor(mob:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local level = mob:getMainLvl()
    local damage = 48 + (level * 8)
    local avatarID = mob:getID()

    damage = damage + (dINT * 1.5)
    damage = MobMagicalMove(mob, target, skill, damage, tpz.magic.ele.LIGHT, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(mob, nil, target, damage.dmg, tpz.magic.ele.LIGHT)
    damage = AvatarFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)

    -- Damage halved for Battaru Royale Astral Flows if target has related element KI
    if
        avatarID < 17477633 and
        avatarID > 17473591 and
        target:hasKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL)
    then
        damage = damage / 2
    -- When Crimson-toothed Pawberry has <= 25% hp, "the damage from Searing Ligtht will be much higher.""
    elseif
        avatarID == ID.mob.CRIMSON_TOOTHED_PAWBERRY + 2 and
        GetMobByID(ID.mob.CRIMSON_TOOTHED_PAWBERRY):getHPP() < 25
    then
        damage = damage * 1.5
    end

    target:takeDamage(damage, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return damage
end
