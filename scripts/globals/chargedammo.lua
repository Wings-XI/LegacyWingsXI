require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")

tpz.chargedAmmoType =
{
    WIND = 1,
    LIGHTNING = 2,
    WATER = 3
    -- virtue stones are in attackround.cpp function "CreateAttacks"
}

tpz.chargedAmmoSubEffect =
{
    [tpz.chargedAmmoType.WIND]      = tpz.subEffect.WIND_DAMAGE, 
    [tpz.chargedAmmoType.LIGHTNING] = tpz.subEffect.LIGHTNING_DAMAGE, 
    [tpz.chargedAmmoType.WATER]     = tpz.subEffect.WATER_DAMAGE
}

tpz.chargedAmmoItemID =
{
    [tpz.chargedAmmoType.WIND]      = { 18236, 18237, 18238 }, -- wind fan, kilo fan, mega fan
    [tpz.chargedAmmoType.LIGHTNING] = { 18228, 18229, 18230 }, -- battery, kilo battery, mega battery
    [tpz.chargedAmmoType.WATER]     = { 18232, 18233, 18234 }  -- hydro pump, kilo pump, mega pump
}

tpz.chargedAmmoElement =
{
    [tpz.chargedAmmoType.WIND]      = tpz.magic.ele.WIND,
    [tpz.chargedAmmoType.LIGHTNING] = tpz.magic.ele.LIGHTNING,
    [tpz.chargedAmmoType.WATER]     = tpz.magic.ele.WATER
}

function doChargedAmmoAddEffect(player, target, damageType)
    if math.random(1,7) ~= 1 then return 0,0,0 end
    local ammo = player:getEquippedItem(tpz.slot.AMMO)
    if ammo == nil then return 0,0,0 end
    
    -- convert ammo type to tier (1,2,3)
    local ammoID = ammo:getID()
    local tier = 0
    if     tpz.chargedAmmoItemID[damageType][1] == ammoID then tier = 1
    elseif tpz.chargedAmmoItemID[damageType][2] == ammoID then tier = 2
    elseif tpz.chargedAmmoItemID[damageType][3] == ammoID then tier = 3
    else return 0,0,0 end
    
    -- player is confirmed to have correct ammo type on. consume 1 ammo
    if ammo:getQuantity() == 1 then player:unequipItem(tpz.slot.AMMO) end
    if player:delItem(ammoID, 1, ammo:getLocationID(), ammo:getSlotID()) == false then return 0,0,0 end
    
    -- dmg pre-calc based on tier of ammo
    local dmg = 0
    if     tier == 1 then dmg = math.random(25,50)
    elseif tier == 2 then dmg = math.random(35,70)
    elseif tier == 3 then dmg = math.random(50,100) end
    local levelcorr = (player:getMainLvl() - target:getMainLvl()) / 2
    if levelcorr > 6 then levelcorr = 6 end
    dmg = dmg + levelcorr
    if dmg < 0 then dmg = 0 end
    
    -- dmg calc
    local params = { }
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(player, tpz.chargedAmmoElement[damageType], target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(player, target, tpz.chargedAmmoElement[damageType], 0)
    dmg = adjustForTarget(target, dmg, tpz.chargedAmmoElement[damageType])
    dmg = finalMagicNonSpellAdjustments(player, target, tpz.chargedAmmoElement[damageType], dmg)
    
    local msg = tpz.msg.basic.ADD_EFFECT_DMG
    if dmg < 0 then
        msg = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = -dmg
    end
    
    return tpz.chargedAmmoSubEffect[damageType],msg,dmg
end