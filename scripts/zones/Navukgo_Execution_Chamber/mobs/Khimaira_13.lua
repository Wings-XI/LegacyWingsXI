-----------------------------------
-- Area: Navukgo Execution Chamber
-- Mob: Khimaira 13
-- Mission: Shield of Diplomacy
-- TODO: Add "weakened state" where attack damage reduced 90% and very high intimidation rate
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Navukgo_Execution_Chamber/IDs")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 99)
    mob:setMod(tpz.mod.ATT, 500)
    mob:setMod(tpz.mod.MAIN_DMG_RATING, 30)
end


function onMobEngaged(mob, target)
    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if v:getName() == "Karababa" then
            v:addEnmity(mob, 0, 1)
        end
    end
end

function onMobFight(mob, target)
    local ragged = math.random(40,50)
    local recover = mob:getLocalVar("recover")
    local delay = mob:getLocalVar("delay")
    local random = math.random(180,360)

        if (delay > random) and recover == 0 then -- Triggers every 60-120s and severely weakens damage
                mob:showText(mob, ID.text.KHIMAIRA_RAGGED)
                mob:addStatusEffect(tpz.effect.ATTACK_DOWN, 250, 0, ragged)
                mob:setMod(tpz.mod.MAIN_DMG_RATING, -50)
                mob:setLocalVar("recover", 1)
            else
                mob:setLocalVar("delay", delay+1)
        end
        
    mob:addListener("EFFECT_LOSE", "KHIMAIRA_EFFECT_LOSE", function(mob, effect)
        if effect:getType() == tpz.effect.ATTACK_DOWN then
            mob:setMod(tpz.mod.MAIN_DMG_RATING, 30)            
            mob:setLocalVar("recover", 2)
        end
    end) 

    if recover == 2 then
        mob:showText(mob, ID.text.KHIMAIRA_RECOVERED)
        mob:setLocalVar("delay", 0)
        mob:setLocalVar("recover", 0)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onEventUpdate(player, csid, option)
    -- printf("updateCSID: %u", csid)
end

function onEventFinish(player, csid, option, target)
    -- printf("finishCSID: %u", csid)
end
