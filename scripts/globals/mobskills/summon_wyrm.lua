---------------------------------------------
--  Summon Wyrm
--  Family: Bahamut
--  Description: Summons a random CoP Wyrm to fight with Bahamut.
--  Type: Summoning
--  Notes: Used by Bahamut at 80%, 60%, 40%, 20% of its HP.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local mobId = mob:getID()
    local randWyrm = mob:getLocalVar("randWyrm")
    local pet = GetMobByID(ID.mob.BAHAMUT_V2 + randWyrm)

        pet:spawn()
        pet:updateEnmity(target)
        skill:setMsg(tpz.msg.basic.NONE)
    return 0
end