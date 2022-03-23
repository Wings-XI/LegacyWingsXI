---------------------------------------------------------------------------------------------------
-- func: Check whether a mob is aggressive / links / detection type
-- desc: Prints the group ID of the currently selected mob
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    
    if targ == nil then
        player:PrintToPlayer("ERROR: No target is selected.")
        return
    end
    
    local aggro = targ:getAggro()
    local link = targ:getLink()
    local detection = targ:getDetectionType()
    
    if aggro == nil or link == nil or detection == nil then
        player:PrintToPlayer("ERROR: Invalid target or target is not a mob.")
        return
    end
    
    local summary = "Behavior of " .. targ:getName() .. "\n"
    summary = summary .. "Aggressive: " .. (aggro and "Yes" or "No") .. "\n"
    summary = summary .. "Links: " .. (link and "Yes" or "No") .. "\n"
    
    
    --[[
    
    Detection type bitmask:
    0x01 - Sight
    0x02 - Sound
    0x04 - Low HP
    0x20 - Magic
    0x40 - Weapon skills
    0x80 - Job abilities
    0x100 - Scent
    
    ]]
    
    local detect_types = { 0x01, 0x02, 0x04, 0x20, 0x40, 0x80, 0x100 }
    local detect_names = { "Sight", "Sound", "Low HP", "Magic", "Weapon skills", "Job Abilities", "Scent" }
    local detection_str = ""
    
    for k, v in ipairs( detect_types ) do
        if bit.band(detection, v) ~= 0 then
            if detection_str ~= "" then
                detection_str = detection_str .. ", "
            end
            detection_str = detection_str .. detect_names[k]
        end
    end
    if detection_str == "" then
        detection_str = "None"
    end
    
    summary = summary .. "Detects: " .. detection_str
    
    player:PrintToPlayer(summary)
    
end
