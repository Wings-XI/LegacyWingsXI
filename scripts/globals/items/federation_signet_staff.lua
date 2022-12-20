-----------------------------------------
-- ID: 17585
-- Item: Federation Signet Staff
-- Effect: Signet
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/conquest")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target, param, caster)
    local nation = tpz.nation.WINDURST
    -- WINGSCUSTOM signet staff usable on targets with rank 10 in nation as well as current allegiance
    if (target:getNation() ~= nation and target:getRank(nation) ~= 10) then
        return tpz.msg.basic.ITEM_CANNOT_USE_ON
    end

    -- WINGSCUSTOM - No zone restriction on signet staves
    --[[-- If target's current region is not a conquest region or not a nation city involved with conquest
    if (target:getCurrentRegion() > tpz.region.JEUNO) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end]]

    -- Can only use on targets within party or self
    if (target:getID() ~= caster:getID()) then
        if (caster:getPartyLeader() == nil or target:getPartyLeader() == nil or target:getPartyLeader():getID() ~= caster:getPartyLeader():getID()) then
            return tpz.msg.basic.ITEM_CANNOT_USE_ON
        end
        -- WINGSCUSTOM since it's usable in any zone, avoid griefing by not allowing overwriting other player's sanction/sigil outside of conquest zones
        if (target:hasStatusEffectByFlag(tpz.effectFlag.INFLUENCE) and target:getCurrentRegion() > tpz.region.LIMBUS) then
            return tpz.msg.basic.ITEM_CANNOT_USE_ON
        end
    end

    return 0
end

function onItemUse(target)
    local nation = tpz.nation.WINDURST
    target:delStatusEffectsByFlag(tpz.effectFlag.INFLUENCE, true)
    -- WINGSCUSTOM signet duration equals that of a guard's signet, with a minimum of original 5 hours
    target:addStatusEffect(tpz.effect.SIGNET, 0, 0, utils.max(18000, (target:getRank(nation) + getNationRank(nation)) * 3600))
end
