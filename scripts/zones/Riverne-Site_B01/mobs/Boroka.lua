-----------------------------------
-- Area: Riverne - Site B01
--   NM: Boroka
-----------------------------------
require("scripts/globals/titles")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.FASTCAST, 20)
    mob:setMod(tpz.mod.RESBUILD_SLEEP,10)
    mob:addMod(tpz.mod.SILENCERES, 100)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.SOUL_VOICE, cooldown = 120, hpp = math.random(85, 95)}, -- Can use Soul Voice multiple times
        },
    })
end

function onMobWeaponSkill(target, mob, skill)
    -- Always follows up any TP move with Hoof Volley
    local skillId = skill:getID()

    if skillId ~= 1330 then
        mob:useMobAbility(1330)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.BOROKA_BELEAGUERER)
end

function onMobDespawn(mob)
	local respawn = math.random(75600, 86400)  -- 21 to 24 hours
    mob:setRespawnTime(respawn)
	SetServerVariable("BorokaRespawn",(os.time() + respawn))
end

