---------------------------------------------
-- Avatars Favor - Effect
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/avatars_favor")
---------------------------------------------

function onEffectGain(target, effect)
    applyAvatarsFavorAuraToPet(target, effect)
    applyAvatarsFavorDebuffsToPet(target)
end

function onEffectTick(target, effect)
    -- Perform tick power upgrade to max
    if effect:getPower() < SKILL_317_INDEX then
        effect:setPower(effect:getPower() + 1)
    end

    -- Cap power based on skill level
    if target:getSkillLevel(tpz.skill.SUMMONING_MAGIC) < 187 and effect:getPower() > SKILL_186_INDEX then
        effect:setPower(SKILL_186_INDEX)
    elseif target:getSkillLevel(tpz.skill.SUMMONING_MAGIC) < 317 and effect:getPower() > SKILL_DEFAULT_INDEX then
        effect:setPower(SKILL_DEFAULT_INDEX)
    end

    applyAvatarsFavorAuraToPet(target, effect)
end


function onEffectLose(target, effect)
     removeAvatarsFavorAuraFromPet(target)
end

    