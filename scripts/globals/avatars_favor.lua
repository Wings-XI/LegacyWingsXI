-----------------------------------
-- Avatars Favor helper
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------

SKILL_186_INDEX = 6 -- 187 taken from wiki talk page
SKILL_DEFAULT_INDEX = 9
SKILL_317_INDEX = 10

-- Avatar Favor buffs scale per tock (~9 seconds) to a max value based on current summoning skill
-- Index 1 is the initial value
-- Index 6 is the value for the low skill tier
-- Index 9 is the value for ~level 75, up to 316 skill
-- Index 10 is the value for having 317 or more skill
-- This can be extended for servers who are higher than 75 cap by adding additional values to the "arrays" and new skill tier logic (and Siren)
local avatarsFavorEffect = {
    [tpz.pet.id.CARBUNCLE] = -- Regen
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 14},
        effect = tpz.effect.CARBUNCLE_S_FAVOR
    },
    [tpz.pet.id.FENRIR] = -- Magic Eva
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = tpz.effect.FENRIR_S_FAVOR
    },
    [tpz.pet.id.IFRIT] = -- Double Attack
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 15},
        effect = tpz.effect.IFRIT_S_FAVOR
    },
    [tpz.pet.id.TITAN] = -- Defense
    {
        scaling = {25, 28, 31, 35, 39, 43, 47, 52, 57, 62},
        effect = tpz.effect.TITAN_S_FAVOR
    },
    [tpz.pet.id.LEVIATHAN] = -- Magic Accuracy
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = tpz.effect.LEVIATHAN_S_FAVOR
    },
    [tpz.pet.id.GARUDA] = -- Evasion
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = tpz.effect.GARUDA_S_FAVOR
    },
    [tpz.pet.id.SHIVA] = -- Magic Attack
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = tpz.effect.SHIVA_S_FAVOR
    },
    [tpz.pet.id.RAMUH] = -- Potency (Critical Hit+%)
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 15},
        effect = tpz.effect.RAMUH_S_FAVOR
    },
    [tpz.pet.id.DIABOLOS] = -- Refresh
    {
        scaling = {1, 1, 1, 2, 2, 2, 3, 3, 3, 4},
        effect = tpz.effect.DIABOLOS_S_FAVOR
    },
    [tpz.pet.id.CAIT_SITH] = -- Magic Defense
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 15},
        effect = tpz.effect.CAIT_SITH_S_FAVOR
    },
}

function applyAvatarsFavorAuraToPet(target, effect)
    local petId = target:getPetID()
    if shouldAvatarsFavorBeApplied(petId) then
        local power = avatarsFavorEffect[petId].scaling[effect:getPower()]
        local avatarEffect = avatarsFavorEffect[petId].effect

        --Useful debug message
        --printf("Power %d, Effect %d", effect:getPower(), power)

        target:getPet():addStatusEffectEx(avatarEffect, avatarEffect, 6, 3, 15, avatarEffect, power, tpz.auraTarget.ALLIES, bit.bor(tpz.effectFlag.NO_LOSS_MESSAGE, tpz.effectFlag.AURA))
    end
end

function removeAvatarsFavorAuraFromPet(target)
    local petId = target:getPetID()
    if shouldAvatarsFavorBeApplied(petId) then
        local pet = target:getPet()
        if pet:hasStatusEffect(avatarsFavorEffect[petId].effect) then
            pet:delStatusEffect(avatarsFavorEffect[petId].effect)
        end
        removeAvatarsFavorDebuffsFromPet(target)
    end
end

function applyAvatarsFavorDebuffsToPet(target)
    local petId = target:getPetID()
    if shouldAvatarsFavorBeApplied(petId) then
        local pet = target:getPet()
        pet:delMod(tpz.mod.MATT, 20) -- Other than MATT most of these values are myth and guesses from multiple sources
        pet:delMod(tpz.mod.ATTP, 20)
        pet:delMod(tpz.mod.ACC, 10)
        pet:delMod(tpz.mod.DEFP, 10)
    end
end

function removeAvatarsFavorDebuffsFromPet(target)
    local petId = target:getPetID()
    if shouldAvatarsFavorBeApplied(petId) then
        local pet = target:getPet()
        pet:addMod(tpz.mod.MATT, 20)
        pet:addMod(tpz.mod.ATTP, 20)
        pet:addMod(tpz.mod.ACC, 10)
        pet:addMod(tpz.mod.DEFP, 10)
    end
end

-------------------------------------------
-- Given a :getPetID petID (Not a getMobID)
-- Returns if Avatars Favor should be applied
-- This equates to is the pet not nil and should have avatars favor effect
-- Does not account for Siren
-------------------------------------------
function shouldAvatarsFavorBeApplied(petId)
    local shouldApply = false

    if petId and petId >= tpz.pet.id.CARBUNCLE and petId <= tpz.pet.id.DIABOLOS then
        shouldApply = true
    end

    if petId and petId == tpz.pet.id.CAIT_SITH then
        shouldApply = true
    end

    return shouldApply
end
