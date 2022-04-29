--------------------------------------------------------
-- (C) 2022 Wings Project.                            --
-- Licensed under GPLv3                              --
-- Hook system.                                       --
-- Create a file called hook-<name> and set <name>    --
-- in settings and it'll be included when including   --
-- this file.                                         --
--                                                    --
-- The hook system is used in order to avoid          --
-- including large chunks of custom code used by      --
-- specific servers inside the main Wings tree.       --
-- If a large bit of custom code is required, create  --
-- a hook file for your server and implement the      --
-- custom logic as part of the hook. If needed,       --
-- create a new hook and add a stub and documentation --
-- in this file.                                      --
--------------------------------------------------------

require("scripts/globals/settings")

if HOOK_FILE_NAME ~= nil and HOOK_FILE_NAME ~= "" then
    require("scripts/globals/hook-" .. HOOK_FILE_NAME)
end

--[[

Documentation of current hooks:
function hookOnCharCreate(player)
Called after the character creation script ends.

]]
