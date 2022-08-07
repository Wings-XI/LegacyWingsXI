---------------------------------------------
-- Vampiric Root
-- Steals HP from a single target and absorbs positive status effects (except food and reraise). 
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Notes: If used against undead, it will simply do damage and not drain HP.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_1_SHADOW)

    -- will steal beneficials if it actually hits
    if skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB then
        -- steals all beneficial buffs except food and reraise
        local beneficials =
        {
            -- bar spells
            tpz.effect.BARFIRE, tpz.effect.BARBLIZZARD, tpz.effect.BARAERO, tpz.effect.BARSTONE, tpz.effect.BARTHUNDER, tpz.effect.BARWATER, tpz.effect.BARSLEEP,
            tpz.effect.BARPOISON, tpz.effect.BARPARALYZE, tpz.effect.BARBLIND, tpz.effect.BARSILENCE, tpz.effect.BARPETRIFY, tpz.effect.BARVIRUS, tpz.effect.BARAMNESIA,
            -- boost and gain spells
            tpz.effect.STR_BOOST, tpz.effect.DEX_BOOST, tpz.effect.VIT_BOOST, tpz.effect.AGI_BOOST, tpz.effect.INT_BOOST, tpz.effect.MND_BOOST, tpz.effect.CHR_BOOST,
            -- enspells
            tpz.effect.ENFIRE, tpz.effect.ENBLIZZARD, tpz.effect.ENAERO, tpz.effect.ENSTONE, tpz.effect.ENTHUNDER, tpz.effect.ENWATER,
            tpz.effect.ENFIRE_II, tpz.effect.ENBLIZZARD_II, tpz.effect.ENAERO_II, tpz.effect.ENSTONE_II, tpz.effect.ENTHUNDER_II, tpz.effect.ENWATER_II,
            tpz.effect.ENLIGHT, tpz.effect.ENDARK,
            -- protect/shell/haste/regen type spells
            tpz.effect.BLINK, tpz.effect.STONESKIN, tpz.effect.AQUAVEIL, tpz.effect.PROTECT, tpz.effect.SHELL, tpz.effect.PHALANX,
            tpz.effect.HASTE, tpz.effect.FLURRY, tpz.effect.FLURRY_II, tpz.effect.REGEN, tpz.effect.REFRESH, tpz.effect.EMBRAVA,
            tpz.effect.REGAIN, tpz.effect.POTENCY, tpz.effect.PAX, tpz.effect.INTENSION, tpz.effect.REPRISAL,
            -- spikes spells
            tpz.effect.BLAZE_SPIKES, tpz.effect.ICE_SPIKES, tpz.effect.SHOCK_SPIKES, -- tpz.effect.DREAD_SPIKES,
            -- storm spells
            tpz.effect.FIRESTORM, tpz.effect.HAILSTORM, tpz.effect.WINDSTORM, tpz.effect.SANDSTORM, tpz.effect.THUNDERSTORM, tpz.effect.RAINSTORM,
            tpz.effect.AURORASTORM, tpz.effect.VOIDSTORM,
            -- stat boost from misc sources
            tpz.effect.MAX_HP_BOOST, tpz.effect.MAX_MP_BOOST, tpz.effect.ACCURACY_BOOST, tpz.effect.ATTACK_BOOST, tpz.effect.EVASION_BOOST, tpz.effect.DEFENSE_BOOST,
            tpz.effect.SHINING_RUBY, tpz.effect.MAGIC_ATK_BOOST, tpz.effect.MAGIC_DEF_BOOST,
            -- bard songs
            tpz.effect.PAEON, tpz.effect.BALLAD, tpz.effect.MINNE, tpz.effect.MINUET, tpz.effect.MADRIGAL, tpz.effect.PRELUDE,
            tpz.effect.MAMBO, tpz.effect.AUBADE, tpz.effect.PASTORAL, tpz.effect.HUM, tpz.effect.FANTASIA, tpz.effect.OPERETTA,
            tpz.effect.CAPRICCIO, tpz.effect.SERENADE, tpz.effect.ROUND, tpz.effect.GAVOTTE, tpz.effect.FUGUE, tpz.effect.RHAPSODY,
            tpz.effect.ARIA, tpz.effect.MARCH, tpz.effect.ETUDE, tpz.effect.CAROL, tpz.effect.SIRVENTE, tpz.effect.DIRGE,
            tpz.effect.SCHERZO,
            -- corsair rolls
            tpz.effect.FIGHTERS_ROLL, tpz.effect.MONKS_ROLL, tpz.effect.HEALERS_ROLL, tpz.effect.WIZARDS_ROLL, tpz.effect.WARLOCKS_ROLL, tpz.effect.ROGUES_ROLL,
            tpz.effect.GALLANTS_ROLL, tpz.effect.CHAOS_ROLL, tpz.effect.BEAST_ROLL, tpz.effect.CHORAL_ROLL, tpz.effect.HUNTERS_ROLL, tpz.effect.SAMURAI_ROLL,
            tpz.effect.NINJA_ROLL, tpz.effect.DRACHEN_ROLL, tpz.effect.EVOKERS_ROLL, tpz.effect.MAGUSS_ROLL, tpz.effect.CORSAIRS_ROLL, tpz.effect.PUPPET_ROLL,
            tpz.effect.DANCERS_ROLL, tpz.effect.SCHOLARS_ROLL, tpz.effect.BOLTERS_ROLL, tpz.effect.CASTERS_ROLL, tpz.effect.COURSERS_ROLL, tpz.effect.BLITZERS_ROLL,
            tpz.effect.TACTICIANS_ROLL, tpz.effect.ALLIES_ROLL, tpz.effect.MISERS_ROLL, tpz.effect.COMPANIONS_ROLL, tpz.effect.AVENGERS_ROLL, tpz.effect.NATURALISTS_ROLL,
            -- dancer sambas
            tpz.effect.DRAIN_SAMBA, tpz.effect.ASPIR_SAMBA, tpz.effect.HASTE_SAMBA,
        }

        for i, effect in ipairs(beneficials) do
            if target:hasStatusEffect(effect) then
                local currentEffect = target:getStatusEffect(effect)
                MobStatusEffectMove(target, mob, effect, currentEffect:getPower(), currentEffect:getTick(), currentEffect:getTimeRemaining() / 1000)
                target:delStatusEffect(effect)
            end
        end
    end

    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))
    return dmg
end