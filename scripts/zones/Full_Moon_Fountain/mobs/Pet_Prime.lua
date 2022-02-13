-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Pet Prime
-----------------------------------

mixins = {require("scripts/mixins/families/avatar")}

function onMobSpawn(mob)
    local master = GetMobByID(mob:getID() - 1)
    print(master:getName())
    if string.find(master:getName(), "Lights") then
        mob:setModelId(791)
    elseif string.find(master:getName(), "Shadows") then
        mob:setModelId(792)
    elseif string.find(master:getName(), "Flames") then
        mob:setModelId(793)
    elseif string.find(master:getName(), "Boulder") then
        mob:setModelId(794)
    elseif string.find(master:getName(), "Torrents") then
        mob:setModelId(795)
    elseif string.find(master:getName(), "Gusts") then
        mob:setModelId(796)
    elseif string.find(master:getName(), "Glaciers") then
        mob:setModelId(797)
    elseif string.find(master:getName(), "Sparks") then
        mob:setModelId(798)
    end
end

function onMobDeath(mob, player, isKiller)
end
