---------------------------------------------------
-- Ultimate Terror
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local mpCost = 27
    skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    local res = applyPlayerResistance(pet,-1,target, 0, tpz.skill.DARK_MAGIC, tpz.magic.ele.DARK)
    
    if res >= 0.5 then
        
        if not target:hasStatusEffect(tpz.effect.STR_DOWN) and not pet:hasStatusEffect(tpz.effect.STR_BOOST) and math.random() < 3/7 then
            pet:addStatusEffect(tpz.effect.STR_BOOST,20*res,3,60*res)
            target:addStatusEffect(tpz.effect.STR_DOWN,20*res,3,60*res)
            --print("str")
        end
        
        if not target:hasStatusEffect(tpz.effect.DEX_DOWN) and not pet:hasStatusEffect(tpz.effect.DEX_BOOST) and math.random() < 3/7 then
            pet:addStatusEffect(tpz.effect.DEX_BOOST,20*res,3,60*res)
            target:addStatusEffect(tpz.effect.DEX_DOWN,20*res,3,60*res)
            --print("dex")
        end
        
        if not target:hasStatusEffect(tpz.effect.VIT_DOWN) and not pet:hasStatusEffect(tpz.effect.VIT_BOOST) and math.random() < 3/7 then
            pet:addStatusEffect(tpz.effect.VIT_BOOST,20*res,3,60*res)
            target:addStatusEffect(tpz.effect.VIT_DOWN,20*res,3,60*res)
            --print("vit")
        end
        
        if not target:hasStatusEffect(tpz.effect.AGI_DOWN) and not pet:hasStatusEffect(tpz.effect.AGI_BOOST) and math.random() < 3/7 then
            pet:addStatusEffect(tpz.effect.AGI_BOOST,20*res,3,60*res)
            target:addStatusEffect(tpz.effect.AGI_DOWN,20*res,3,60*res)
            --print("agi")
        end
        
        if not target:hasStatusEffect(tpz.effect.INT_DOWN) and not pet:hasStatusEffect(tpz.effect.INT_BOOST) and math.random() < 4/7 then
            pet:addStatusEffect(tpz.effect.INT_BOOST,20*res,3,60*res)
            target:addStatusEffect(tpz.effect.INT_DOWN,20*res,3,60*res)
            --print("int")
        end
        
        if not target:hasStatusEffect(tpz.effect.MND_DOWN) and not pet:hasStatusEffect(tpz.effect.MND_BOOST) and math.random() < 3/7 then
            pet:addStatusEffect(tpz.effect.MND_BOOST,20*res,3,60*res)
            target:addStatusEffect(tpz.effect.MND_DOWN,20*res,3,60*res)
            --print("mnd")
        end
        
        if not target:hasStatusEffect(tpz.effect.CHR_DOWN) and not pet:hasStatusEffect(tpz.effect.CHR_BOOST) and math.random() < 3/7 then
            pet:addStatusEffect(tpz.effect.CHR_BOOST,20*res,3,60*res)
            target:addStatusEffect(tpz.effect.CHR_DOWN,20*res,3,60*res)
            --print("chr")
        end
        
        skill:setMsg(0)
        
    end
    
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return 0
end
