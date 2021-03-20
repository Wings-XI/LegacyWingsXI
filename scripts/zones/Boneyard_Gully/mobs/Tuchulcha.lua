-----------------------------------
-- Area: Boneyard Gully
--  Mob: Tuchulcha
--  ENM: Sheep in Antlion's Clothing
-----------------------------------
mixins = {require("scripts/mixins/families/antlion_ambush")}
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(tpz.mobMod.SUPERLINK, 0)

    -- Used with HPP to keep track of the number of Sandpits
    mob:setLocalVar("Sandpits", 0)
    
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
    mob:setMod(tpz.mod.PARALYZERESTRAIT, 100)
    mob:setMod(tpz.mod.STUNRESTRAIT, 100)
    mob:setMod(tpz.mod.MAIN_DMG_RATING, 40)
    mob:setMod(tpz.mod.DEFP, -5)
    mob:setMod(tpz.mod.EVA, -20)
end

-- Reset restHP when re-engaging after a sandpit
function onMobEngaged(mob, target)
    if mob:getMobMod(tpz.mobMod.NO_REST) == 1 then
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:setMobMod(tpz.mobMod.NO_REST, 0)
    end
end

function onMobFight(mob, target)
    -- Every 25% of its HP Tuchulcha will bury itself under the sand
    -- accompanied by use of the ability Sandpit
    if mob:getHP() == 0 then return end
    if (mob:getHPP() < 75 and mob:getLocalVar('Sandpits') == 0)
    or (mob:getHPP() < 50 and mob:getLocalVar('Sandpits') == 1)
    or (mob:getHPP() < 25 and mob:getLocalVar('Sandpits') == 2) then
        mob:setLocalVar('Sandpits', mob:getLocalVar('Sandpits') + 1)
        mob:useMobAbility(276)
        mob:timer(4000, function(tuchulcha)
            if mob:getHP() == 0 then return end
            tuchulcha:disengage()
            tuchulcha:setMobMod(tpz.mobMod.NO_MOVE, 1)
            tuchulcha:setMobMod(tpz.mobMod.NO_REST, 1)
            local pos_index = tuchulcha:getLocalVar("sand_pit" .. tuchulcha:getLocalVar('Sandpits'))
            local coords = ID.sheepInAntlionsClothing[tuchulcha:getBattlefield():getArea()].ant_positions[pos_index]
            tuchulcha:setPos(coords)
            for _, char in pairs(tuchulcha:getBattlefield():getPlayers()) do
                char:messageSpecial(ID.text.TUCHULCHA_SANDPIT)
                char:disengage()
                if char:hasPet() then
                    char:petRetreat()
                end
            end
        end)
    end
end

function onMobDeath(mob, player, isKiller)
    local bfID = mob:getBattlefield():getArea()
    
    -- Despawn the hunters
    DespawnMob(ID.sheepInAntlionsClothing[bfID].SWIFT_HUNTER_ID)
    DespawnMob(ID.sheepInAntlionsClothing[bfID].SHREWD_HUNTER_ID)
    DespawnMob(ID.sheepInAntlionsClothing[bfID].ARMORED_HUNTER_ID)
    
    GetNPCByID(mob:getID()+4):setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
    for _, char in pairs(mob:getBattlefield():getPlayers()) do
        char:messageSpecial(7743)
    end
            
end
