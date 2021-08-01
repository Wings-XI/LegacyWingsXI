require("scripts/globals/mixins")
require("scripts/globals/status")


g_mixins = g_mixins or {}

g_mixins.warriors_path_taru = function(mob)

    mob:addListener("COMBAT_TICK", "TARU_CTICK", function(mob)
        
        local kukki = mob:getLocalVar("kukki")
        local makki = mob:getLocalVar("makki")
        local cheru = mob:getLocalVar("cheru")
        local changetime = mob:getLocalVar("changetime")
        local battletime = mob:getBattleTime()
        local ID = zones[mob:getZoneID()]
        local randOffset = math.random(1, 3) -- each taru most commonly uses text offset +1-3 for during fight
        local animationchance = math.random()
        if battletime - changetime >= 5 then -- every 5 seconds the taru's will say something and use a random animation
            if cheru == 1 then
                mob:showText(mob, ID.text.CHERUKIKI_OFFSET + randOffset)
                if animationchance < 0.166 then    
                    mob:entityAnimationPacket("kuya") -- knee kick animation
                elseif animationchance < 0.333 then
                    mob:entityAnimationPacket("nagu") -- big firework
                elseif animationchance < 0.500 then
                    mob:entityAnimationPacket("yoro") -- jump animation
                elseif animationchance < 0.666 then
                    mob:entityAnimationPacket("ffr1") -- small firework
                elseif animationchance < 0.833 then
                    mob:entityAnimationPacket("awat") -- panic animation
                else
                    mob:entityAnimationPacket("guts") -- jump animation
                end
                mob:setLocalVar("changetime", mob:getBattleTime())
            elseif makki == 1 then
                mob:showText(mob, ID.text.MAKKI_CHUBUKKI_OFFSET + randOffset)
                if animationchance < 0.166 then    
                    mob:entityAnimationPacket("guts")
                elseif animationchance < 0.333 then
                    mob:entityAnimationPacket("kuya")
                elseif animationchance < 0.500 then
                    mob:entityAnimationPacket("nagu")
                elseif animationchance < 0.666 then
                    mob:entityAnimationPacket("yoro")
                elseif animationchance < 0.833 then
                    mob:entityAnimationPacket("ffr1")
                else
                    mob:entityAnimationPacket("awat")
                end
                mob:setLocalVar("changetime", mob:getBattleTime())
            elseif kukki == 1 then
                mob:showText(mob, ID.text.KUKKI_CHEBUKKI_OFFSET + randOffset)
                if animationchance < 0.166 then    
                    mob:entityAnimationPacket("awat")
                elseif animationchance < 0.333 then
                    mob:entityAnimationPacket("guts")
                elseif animationchance < 0.500 then
                    mob:entityAnimationPacket("kuya")
                elseif animationchance < 0.666 then
                    mob:entityAnimationPacket("nagu")
                elseif animationchance < 0.833 then
                    mob:entityAnimationPacket("yoro")
                else
                    mob:entityAnimationPacket("ffr1")
                end
                mob:setLocalVar("changetime", mob:getBattleTime())
            end
        end
    end)
end

return g_mixins.warriors_path_taru
