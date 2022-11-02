require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/zone")
require("scripts/globals/npc_util")

anniversary = {}

--[[
    Anniversary 2022 re-uses stage V VNMs in the three starter crag zones
]]

anniversary.zoneinfo2022 =
{
    [tpz.zone.TAHRONGI_CANYON] =
    {
        nmId = 17256921,
        spawnPos = {74, 40.8, 339.5, 250},
        battlemusic = 136,
        playerlvl = 23,
        HQdropitems = {
            320, -- Harpsichord
            415, -- Aldebaran
            457, -- Cushaw Lantern
        },
    },
    [tpz.zone.KONSCHTAT_HIGHLANDS] =
    {
        nmId = 17220021,
        spawnPos = {219.2, 24.5, 325.7, 60},
        battlemusic = 136,
        playerlvl = 23,
        HQdropitems = {
            10811, -- Chocobo shield
            16378, -- Dinner Hose
        },
    },
    [tpz.zone.LA_THEINE_PLATEAU] =
    {
        nmId = 17195494,
        spawnPos = {419.6, 24.6, 46.7, 320},
        battlemusic = 136,
        playerlvl = 23,
        HQdropitems = {
            266, -- Behe Statue
            11355, -- Dinner Jacket
        },
    },
}

anniversary.spawnitems2022 = {
    {537, "damselfly worm"},
    {538, "magicked skull"},
    {539, "crab apron"},
    {540, "bloody robe"},
    {541, "cup of dhalmel saliva"},
    {542, "wild rabbit tail"},
}

anniversary.globalHQdropitems2022 = {
    11290, -- tidal_talisman
    16119, -- Nomad cap
}

anniversary.globalNQdropitems2022 = {
    4217, -- sparkling_hand
    4252, -- summer_fan
    4253, -- spirit_masque
    5725, -- goshikitenge
    6190, -- spriggan_spark
}

anniversary.onTrade = function(player, npc, trade)
    local retval = 0
    if Anniversary_Event == 2022 then
        local currentItem = npc:getLocalVar("Anni2022_Trade") == 0 and 1 or npc:getLocalVar("Anni2022_Trade")
        if trade:getItemCount() == 1 and trade:getItemId() == anniversary.spawnitems2022[currentItem][1] then
            if currentItem == #anniversary.spawnitems2022 then
                npc:setLocalVar("Anni2022_Trade", 1)
                player:setCharVar("Anni2022_FightReady", 1)
                retval = 2
            else
                npc:setLocalVar("Anni2022_Trade", currentItem + 1)
                retval = 1
            end
            player:tradeComplete()
        else
            retval = 1
        end
    end
    return retval
end

anniversary.onTrigger = function(player, npc)
    if Anniversary_Event == 2022 then
        local zoneInfo = anniversary.zoneinfo2022[player:getZoneID()]
        nm = GetMobByID(zoneInfo.nmId)
        if nm:isAlive() or nm:getStatus() ~= 2 then
            if not nm:isEngaged() and nm:isAlive() then
                -- unlikely, just in case somehow the NM stays up and out of combat
                player:PrintToPlayer(string.format("%s: Something bugged with previous fight? Despawning mob.", npc:getName()), 0xD)
                DespawnMob(nm:getID())
                local playerparty = player:getAlliance()
                for _,partymember in pairs(playerparty) do
                    if partymember:getZoneID() == npc:getZoneID() then
                        -- reward only given if talking to the npc when mob is dead and player still has lvl sync effect
                        if partymember:hasStatusEffect(143) then
                            partymember:removeListener("DEATH_Anni2022")
                            partymember:delStatusEffect(143)
                            partymember:delStatusEffect(276)
                            partymember:ChangeMusic(0, 0)
                            partymember:ChangeMusic(1, 0)
                            partymember:ChangeMusic(2, 101)
                            partymember:ChangeMusic(3, 102)
                            if not partymember:isAlive() then partymember:sendRaise(5) end
                        end
                    end
                end
            else
                player:PrintToPlayer(string.format("%s: Please wait until mob is dead and gone, then talk to me again.", npc:getName()), 0xD)
            end
            return 1
        elseif player:hasStatusEffect(143) and nm:isDead() then
            local party = player:getAlliance()
            -- distributes pop items on successful kill
            local randStartNQDrops = math.random(#anniversary.spawnitems2022)
            local dropCount = 0
            local dropCountHQ = 0
            local HQdrops = {}
            local HQdroplist = {}
            local NQdroplist = anniversary.globalNQdropitems2022
            for i=1,#anniversary.globalHQdropitems2022 do
                HQdroplist[#HQdroplist+1] = anniversary.globalHQdropitems2022[i]
            end
            for i=1,#zoneInfo.HQdropitems do
                HQdroplist[#HQdroplist+1] = zoneInfo.HQdropitems[i]
            end

            local randStartHQdrops = 1

            -- event complete, remove status effects and distribute loot
            local AllianceSize = npc:getLocalVar("Anni2022_AllianceSize")
            -- set HQ item droprate per player based on number of players in party, no increase past 12 members
            local globalHQcount = 0
            local i = 0
            while i < #anniversary.globalHQdropitems2022 do
                i = i + 1
                if player:hasItem(anniversary.globalHQdropitems2022[i]) then
                    globalHQcount = globalHQcount + 1
                end
            end
            -- guaranteed hq drop if player has _all_ drops for this location
            local hasAllDrops = true
            i = 0
            while i < #HQdroplist do
                i = i + 1
                if not player:hasItem(HQdroplist[i]) then
                    hasAllDrops = false
                end
            end
            i = 0
            while i < #anniversary.globalNQdropitems2022 do
                i = i + 1
                if not player:hasItem(anniversary.globalNQdropitems2022[i]) then
                    hasAllDrops = false
                end
            end
            local HQdropRate = 150 + utils.clamp(AllianceSize * 8, 0, 100) + globalHQcount * 50
            for _,member in pairs(party) do
                if member:getZoneID() == npc:getZoneID() then
                    member:delStatusEffect(143)
                    member:delStatusEffect(276)
                    member:ChangeMusic(0, 0)
                    member:ChangeMusic(1, 0)
                    member:ChangeMusic(2, 101)
                    member:ChangeMusic(3, 102)
                    if not member:isAlive() then member:sendRaise(5) end

                    -- if you were part of a group that started the fight, you can just do it as much as you want now
                    -- free sj items!
                    -- member:setCharVar("Anni2022_FightReady", 0)

                    -- spam nq drops directly to each alliance member
                    dropCount = 0
                    while dropCount < #NQdroplist do
                        dropCount = dropCount + 1
                        if not npcUtil.giveItem(member, { {NQdroplist[dropCount], math.random(1,10)} } ) then
                            dropCount = #NQdroplist + 1
                        end
                    end
                    local randRoll = math.random(1000)
                    if (randRoll < HQdropRate and dropCountHQ < AllianceSize) or (member:getName() == player:getName() and hasAllDrops) then
                        dropCountHQ = dropCountHQ + 1
                        local checkedHQs = 0
                        local foundHQ = false
                        -- pick an HQ item this player doesn't have
                        -- add to treasure pool at the end so spawn items distribute first
                        randStartHQdrops = math.random(#HQdroplist)
                        while checkedHQs < #HQdroplist and foundHQ == false do
                            if member:hasItem(HQdroplist[randStartHQdrops]) then
                                randStartHQdrops = (randStartHQdrops % #HQdroplist) + 1
                                checkedHQs = checkedHQs + 1
                            else
                                member:PrintToPlayer("You get a prize (in the treasure pool)!", 0xD)
                                foundHQ = true
                            end
                        end
                        if foundHQ == false then
                            member:PrintToPlayer("You have all the HQ drops, your friends get a prize (in the treasure pool)!", 0xD)
                        end
                        -- either chosen specifically for this player, or the original random index
                        HQdrops[dropCountHQ] = HQdroplist[randStartHQdrops]
                    end
                end
            end
            -- then drop the spawn items (2 per player up to 6)
            dropCount = 0
            while dropCount < #anniversary.spawnitems2022 and dropCount < AllianceSize * 2 do
                player:addTreasure(anniversary.spawnitems2022[randStartNQDrops][1], npc)
                randStartNQDrops = (randStartNQDrops % #anniversary.spawnitems2022) + 1
                dropCount = dropCount + 1
            end
            -- finally hq items
            dropCount = 0
            while dropCount < dropCountHQ and dropCount < 10 do
                dropCount = dropCount + 1
                player:addTreasure(HQdrops[dropCount], npc)
            end
            return 1
        elseif player:getCharVar("Anni2022_FightReady") == 1 then
            -- player:PrintToArea("Prepare youself for combat...Talk to me when you are done.", tpz.msg.channel.SAY, tpz.msg.area.SAY, npc:getName())
            local playerparty = player:getAlliance()
            for _,partymember in pairs(playerparty) do
                if partymember:getZoneID() == npc:getZoneID() then
                    partymember:PrintToPlayer(string.format("%s: Prepare youself for combat...Talk to me when you are done and again after that to start the event immediately (no more sj items required).", npc:getName()), 0xD)
                end
            end
            return 2
        else
            local currentItem = npc:getLocalVar("Anni2022_Trade") == 0 and 1 or npc:getLocalVar("Anni2022_Trade")
            if currentItem == 1 then
                player:PrintToPlayer(string.format("%s: Welcome to the 2022 anniversary event, trade a %s to get started", npc:getName(), anniversary.spawnitems2022[currentItem][2]), 0xD)
            elseif currentItem ~= #anniversary.spawnitems2022 then
                player:PrintToPlayer(string.format("%s: Next item required is %s", npc:getName(), anniversary.spawnitems2022[currentItem][2]), 0xD)
            else
                player:PrintToPlayer(string.format("%s: Next item required is %s. This is the last item required", npc:getName(), anniversary.spawnitems2022[currentItem][2]), 0xD)
                player:PrintToPlayer(string.format("%s: Once traded, the event will start for your party immediately!", npc:getName()), 0xD)
            end
            return 1
        end
    end
    return 0
end

anniversary.spawnNM = function(player, npc)
    local zoneInfo = anniversary.zoneinfo2022[player:getZoneID()]
    nm = GetMobByID(zoneInfo.nmId)
    if nm:isAlive() or nm:getStatus() ~= 2 then
        -- shouldn't be possible to hit this, except during testing
        player:PrintToPlayer(string.format("%s: Please wait until mob is dead and gone, then talk to me again.", npc:getName()), 0xD)
    else
        local party = player:getAlliance()
        -- scale everything to the party size when fight started
        npc:setLocalVar("Anni2022_AllianceSize", #party)
        DespawnMob(zoneInfo.nmId)
        nm:setSpawn(zoneInfo.spawnPos[1], zoneInfo.spawnPos[2], zoneInfo.spawnPos[3])
        -- set nm level to get fun job traits/spells
        nm:setMobLevel(80)
        SpawnMob(nm:getID())
        -- set nm level based on number of players in party, no increase past 12 members
        nm:setMobLevel(zoneInfo.playerlvl - 2 + utils.clamp(npc:getLocalVar("Anni2022_AllianceSize") / 2, 0, 6))
        nm:setMod(tpz.mod.HPP, npc:getLocalVar("Anni2022_AllianceSize") * 5)
        nm:setMod(tpz.mod.REGAIN, npc:getLocalVar("Anni2022_AllianceSize") * 100)
        nm:setPos(zoneInfo.spawnPos[1], zoneInfo.spawnPos[2], zoneInfo.spawnPos[3], zoneInfo.spawnPos[4])
        nm:setMobMod(tpz.mobMod.EXP_BONUS, -100)
        nm:setMobMod(tpz.mobMod.NO_DROPS, 1)
        nm:setMobMod(tpz.mobMod.CHARMABLE, 0)
        nm:setMobMod(tpz.mobMod.GIL_MAX, -1)
        nm:addMod(tpz.mod.SILENCERES, 1000)
        nm:addMod(tpz.mod.SPELLINTERRUPT, 100)
        -- nm:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
        nm:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
        nm:updateClaim(player)
        nm:engage(player:getShortID())
        -- immobilized for a bit of time
        nm:addStatusEffect(tpz.effect.BIND, 0, 0, 30)
        nm:addStatusEffect(tpz.effect.SILENCE, 0, 0, 10)
        nm:setTP(0)
        nm:setHP(nm:getMaxHP())
        nm:setMobMod(tpz.mobMod.MAGIC_COOL, 30 - npc:getLocalVar("Anni2022_AllianceSize"))

        --[[nm:addListener("DISENGAGE", "DISENGAGE_Anni2022", function(nm)
            nm:removeListener("DISENGAGE_Anni2022")
            nm:removeListener("DEATH_Anni2022")
            DespawnMob(zoneInfo.nmId)
        end)]]

        nm:addListener("DEATH", "DEATH_Anni2022", function(nm)
            nm:removeListener("DMG_Anni2022")
            nm:removeListener("DISENGAGE_Anni2022")
            nm:removeListener("DEATH_Anni2022")
            DespawnMob(nm:getID())
        end)

        nm:addListener("TAKE_DAMAGE", "DMG_Anni2022", function(nm, amount, target)
            if target and target:isPet() then
                -- Insta-death any pet that does dmg and increment fastcast for your insolence
                local fastcast = utils.clamp(nm:getMod(tpz.mod.UFASTCAST) + 50, 0, 99)
                local attp = utils.clamp(nm:getMod(tpz.mod.ATTP) + 50, 0, 200)
                nm:setMod(tpz.mod.UFASTCAST, 99)
                if nm:getMP() > 1000 then
                    nm:castSpell(367, target)
                else
                    target:setHP(0)
                end
                nm:timer(1000, function(nm)
                    nm:setMod(tpz.mod.UFASTCAST, fastcast)
                    nm:setMod(tpz.mod.ATTP, attp)
                end)
            end
        end)

        -- join whole alliance to confrontation event
        for _,member in pairs(party) do
            if member:getZoneID() == npc:getZoneID() then
                nm:updateEnmity(member)
                member:delStatusEffect(tpz.effect.WEAKNESS)
                member:addStatusEffect(143, zoneInfo.playerlvl, 0, 0) -- Add Level Restriction
                member:addStatusEffect(276, 10, 0, 0) -- Add Confrontation Status to allow attacking the mobs
                member:setTP(0)
                member:setHP(member:getMaxHP())
                member:setMP(member:getMaxMP())
                member:ChangeMusic(0, zoneInfo.battlemusic)
                member:ChangeMusic(1, zoneInfo.battlemusic)
                member:ChangeMusic(2, zoneInfo.battlemusic)
                member:ChangeMusic(3, zoneInfo.battlemusic)
                member:setCharVar("Anni2022_FightReady", 1)
                member:delStatusEffectsByFlag(tpz.effectFlag.DISPELABLE)
                RemoveTempItems(member)

                member:addListener("DEATH", "DEATH_Anni2022", function(member)
                    member:removeListener("DEATH_Anni2022")
                    member:delStatusEffect(143)
                    member:delStatusEffect(276)
                    member:ChangeMusic(0, 0)
                    member:ChangeMusic(1, 0)
                    member:ChangeMusic(2, 101)
                    member:ChangeMusic(3, 102)
                    local party = member:getAlliance()
                    local alive = false
                    for _,partymember in pairs(party) do
                        if partymember:getZoneID() == member:getZoneID() and partymember:hasStatusEffect(143) and alive == false then
                            alive = partymember:isAlive() and true or false
                        end
                    end
                    if alive == false then
                        -- full wipe, clear battle and reset fight
                        local zoneInfo = anniversary.zoneinfo2022[member:getZoneID()]
                        for _,partymember in pairs(party) do
                            if partymember:getZoneID() == member:getZoneID() then
                                -- give time if a TP move killed the player
                                partymember:timer(10000, function(partymember)
                                    partymember:sendRaise(5)
                                    partymember:PrintToPlayer(string.format("Anniversary Event: Full wipe, eh? Everything is ready for you to try again immediately!"), 0xD)
                                end)
                            end
                        end
                        -- DespawnMob(zoneInfo.nmId)
                    end
                end)
            end
        end
    end

end
