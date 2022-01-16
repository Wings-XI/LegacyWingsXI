-----------------------------------------
-- ID: 14990
-- Blizzard Gloves
--  Enchantment: "Enblizzard"
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.ENBLIZZARD
    local duration = 180
    local magicskill = target:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local potency = 0

    if magicskill <= 200 then
        potency = 3 + math.floor(6 * magicskill / 100)
    elseif magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    potency = utils.clamp(potency, 3, 25)

    target:addStatusEffect(effect, potency, 0, 180)
end
