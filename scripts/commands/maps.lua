---------------------------------------------------------------------------------------------------
-- func: maps
-- desc: Adds all maps to the current player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/settings")

cmdprops =
{
    permission = 0,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    -- player:PrintToPlayer("!maps {player}")
end

function onTrigger(player, target)
    
    if ALL_MAPS == 0 then
        player:PrintToPlayer("Maps are not automatically obtained on this server.")
        return
    end
    
    if player:getCharVar("HasAllMaps") ~= 0 then
        player:PrintToPlayer("You already have all maps.")
        return
    end

    local keyIds =
    {
        383, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402,
        403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421,
        422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440,
        441, 442, 443, 444, 445, 446, 447, 1856, 1857, 1858, 1859, 1860, 1861, 1862, 1863, 1864, 1865,
        1866, 1867, 1868, 1869, 1870, 1871, 1872, 1873, 1874, 1875, 1876, 1877, 1878, 1879, 1880, 1881,
        1882, 1883, 1884, 1885, 1886, 1887, 1888, 1889, 1890, 1891, 1892, 1893, 1894, 1895, 1896, 1897,
        1898, 1899, 1900, 1901, 1902, 1903, 1904, 1905, 1906, 1907, 1908, 1909, 1910, 1911, 1912, 1913,
        1914, 1915, 1916, 1917, 1918, 2302, 2303, 2304, 2305, 2307, 2308, 2309
    }

    local maps_added = 0
    player:PrintToPlayer("Working on it, please wait.")
    
    -- add maps
    for _, v in ipairs( keyIds ) do
        if not player:hasKeyItem( v ) then
            player:addKeyItem( v )
            maps_added = maps_added + 1
        end
    end
    
    player:setCharVar("HasAllMaps", 1)
    if maps_added > 0 then
        player:PrintToPlayer("All maps obtained!")
    else
        player:PrintToPlayer("You already have all maps.")
    end
end
