require("scripts/globals/status")

BaseNyzulWeapons = {
        18492, -- (WAR) Sturdy Axe
        18753, -- (MNK) Burning Fists
        18851, -- (WHM) Werebuster
        18589, -- (BLM) Mage's Staff
        17742, -- (RDM) Vorpal Sword
        18003, -- (THF) Swordbreaker
        17744, -- (PLD) Brave Blade
        18944, -- (DRK) Death Sickle
        17956, -- (BST) Double Axe
        18034, -- (BRD) Dancing Dagger
        18719, -- (RNG) Killer Bow
        18443, -- (SAM) Windslicer
        18426, -- (NIN) Sasuke Katana
        18120, -- (DRG) Radiant Lance
        18590, -- (SMN) Scepter Staff
        17743, -- (BLU) Wightslayer
        18720, -- (COR) Quicksilver
        18754, -- (PUP) Inferno Claws
        19102, -- (DNC) Main Gauche
        18592  -- (SCH) Elder Staff
}

AresComponents = {
        16085, -- 15 Head
        16086, -- 25 Head
        16087, -- 35 Head
        14547, -- 15 Body
        14548, -- 25 Body
        14549, -- 35 Body
        14962, -- 15 Hands
        14963, -- 25 Hands
        14964, -- 35 Hands
        15626, -- 15 Legs
        15627, -- 25 Legs
        15628, -- 35 Legs
        15712, -- 15 Feet
        15713, -- 25 Feet
        15714, -- 35 Feet
}

AresArmorSet = {
        16084, -- Mask
        14546, -- Cuirass
        14961, -- Gauntlets
        15625, -- Flanchard
        15711, -- Sollerets
}

SkadiComponents = {
        16089, -- 15 Head
        16090, -- 25 Head
        16091, -- 35 Head
        14551, -- 15 Body
        14552, -- 25 Body
        14553, -- 35 Body
        14966, -- 15 Hands
        14967, -- 25 Hands
        14968, -- 35 Hands
        15630, -- 15 Legs
        15631, -- 25 Legs
        15632, -- 35 Legs
        15716, -- 15 Feet
        15717, -- 25 Feet
        15718, -- 35 Feet
}

SkadiArmorSet = {
        16088, -- Visor
        14550, -- Cuirie
        14965, -- Bazubands
        15629, -- Chausses
        15715, -- Jambreaux
}

UsukaneComponents = {
        16093, -- 15 Head
        16094, -- 25 Head
        16095, -- 35 Head
        14555, -- 15 Body
        14556, -- 25 Body
        14557, -- 35 Body
        14970, -- 15 Hands
        14971, -- 25 Hands
        14972, -- 35 Hands
        15634, -- 15 Legs
        15635, -- 25 Legs
        15636, -- 35 Legs
        15720, -- 15 Feet
        15721, -- 25 Feet
        15722, -- 35 Feet
}

UsukaneArmorSet = {
        16092, -- Somen
        14554, -- Haramaki
        14969, -- Gote
        15633, -- Hizayoroi
        15719, -- Sune-Ate
}

MardukComponents = {
        16097, -- 15 Head
        16098, -- 25 Head
        16099, -- 35 Head
        14559, -- 15 Body
        14560, -- 25 Body
        14561, -- 35 Body
        14974, -- 15 Hands
        14975, -- 25 Hands
        14976, -- 35 Hands
        15638, -- 15 Legs
        15639, -- 25 Legs
        15640, -- 35 Legs
        15724, -- 15 Feet
        15725, -- 25 Feet
        15726, -- 35 Feet
}

MardukArmorSet = {
        16096, -- Tiara
        14558, -- Jubbah
        14973, -- Dastanas
        15637, -- Shalwar
        15723, -- Crackows
}

MorriganComponents = {
        16101, -- 15 Head
        16102, -- 25 Head
        16103, -- 35 Head
        14563, -- 15 Body
        14564, -- 25 Body
        14565, -- 35 Body
        14978, -- 15 Hands
        14979, -- 25 Hands
        14980, -- 35 Hands
        15642, -- 15 Legs
        15643, -- 25 Legs
        15644, -- 35 Legs
        15728, -- 15 Feet
        15729, -- 25 Feet
        15730, -- 35 Feet
}

MorriganArmorSet = {
        16100, -- Coronal
        14562, -- Robe
        14977, -- Cuffs
        15641, -- Slops
        15727, -- Pigaches
}
-----------------------------------
-- Place convenience functions
-- related to equipment here
-----------------------------------

function isArtifactArmor(itemid)
    retval = false
    if    ((itemid >= 12511 and itemid <= 12520) or (itemid >= 13855 and itemid <= 13857) or (itemid >= 13868 and itemid <= 13869)) then retval = true -- normal head sets
    elseif ((itemid >= 12638 and itemid <= 12650) or (itemid >= 13781 and itemid <= 13782)) then retval = true -- normal body sets
    elseif (itemid >= 13961 and itemid <= 13975) then retval = true -- normal hand sets
    elseif (itemid >= 14089 and itemid <= 14103) then retval = true -- normal feet sets
    elseif (itemid >= 14214 and itemid <= 14228) then retval = true -- normal legs sets

    elseif (itemid >= 15265 and itemid <= 15267) then retval = true -- ToAU head sets
    elseif (itemid >= 14521 and itemid <= 14523) then retval = true -- ToAU body sets
    elseif (itemid >= 14928 and itemid <= 14930) then retval = true -- ToAU hand sets
    elseif (itemid >= 15684 and itemid <= 15686) then retval = true -- ToAU feet sets
    elseif (itemid >= 15600 and itemid <= 15602) then retval = true -- ToAU legs sets

    elseif (itemid >= 16138 and itemid <= 16140) then retval = true -- WotG head sets
    elseif (itemid >= 14578 and itemid <= 14580) then retval = true -- WotG body sets
    elseif (itemid >= 15002 and itemid <= 15004) then retval = true -- WotG hand sets
    elseif (itemid >= 15746 and itemid <= 15748) then retval = true -- WotG feet sets
    elseif (itemid >= 15659 and itemid <= 15661) then retval = true -- WotG legs sets
    end
    return retval
end

function isBaseNyzulWeapon(itemId)

    for i, wepId in pairs(BaseNyzulWeapons) do
        if (itemId == wepId) then
            return true
        end
    end

    return false

end


-- Provides a power for using a chocobo shirt with bunch of gysahl greens
function ChocoboShirt(player)
    local body = player:getEquipID(tpz.slot.BODY)
    local power = 0
    if (body == 10293) then -- Chocobo Shirt
        power = power + 1
    end
    return power
end
