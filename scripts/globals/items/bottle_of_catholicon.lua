-----------------------------------------
-- ID: 4206
-- Item: Bottle of Catholicon
-- Item Effect: This potion removes up to three negative effects.  Does not remove Curse, Doom, or Amnesia
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    -- some debate on the wiki talk page about PARALYSIS
    removables = {tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.PARALYSIS, tpz.effect.POISON, tpz.effect.DISEASE,
                  tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND, tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN,
                  tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN, tpz.effect.STR_DOWN,
                  tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
                  tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN,
                  tpz.effect.ATTACK_DOWN, tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN,
                  tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN, tpz.effect.MAGIC_DEF_DOWN, tpz.effect.MAX_TP_DOWN,
                  tpz.effect.MAX_MP_DOWN, tpz.effect.MAX_HP_DOWN, tpz.effect.PETRIFICATION, tpz.effect.ELEGY, tpz.effect.REQUIEM,
                  tpz.effect.SILENCE} 

    local statusNum = -1
    local has = {}

    for i, effect in ipairs(removables) do
        if (target:hasStatusEffect(effect)) then
            statusNum = statusNum + 1
            has[statusNum] = removables[i]
        end
    end

    -- No status effects found on target - way to waste an item
    if statusNum == -1 then
        return 0
    -- 3 or less effects on target
    elseif statusNum >=0 and statusNum <=2 then
        for i = 0, statusNum, 1 do
            target:delStatusEffect(has[i])
        end
    -- more than 3 effects - randomize removal
    else
        for i = 0, 2, 1 do
            local effectIndex = math.random(0, statusNum)
            target:delStatusEffect(has[effectIndex])
            table.remove(has, effectIndex)
            statusNum = statusNum - 1
        end
    end
    -- TODO add messaging if a player uses this on another player (currently only the player having effects removed notices)
end

