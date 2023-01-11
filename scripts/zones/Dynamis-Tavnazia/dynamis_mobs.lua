-----------------------------------
--
-- Dynamis-Tavnazia
--
--[[
    Resources:
    https://enedin.be/dyna/html/zone/tav.htm
    https://enedin.be/dyna/html/zone/frame_tav.htm
    https://www.dynamisbums.com/strategy/tav.html
]]
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_TAVNAZIA

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] = 
{
    -- floor 0
    [16949255] = { id =  16949255 }, -- Nightmare Bugard ( 001 )

    -- floor 1
    [16949257] = { id =  16949257}, -- Nightmare Worm ( 002 )
    [16949269] = { id = 16949269}, -- wave 1 floor 1 vanguard eye qm3
    [16949270] = { id = 16949270}, -- wave 1 floor 1 vanguard eye qm3
    [16949271] = { id = 16949271}, -- wave 1 floor 1 vanguard eye
    [16949272] = { id = 16949272}, -- wave 1 floor 1 vanguard eye
    [16949289] = { id = 16949289}, -- wave 1 floor 1 vanguard eye
    [16949290] = { id = 16949290}, -- wave 1 floor 1 vanguard eye
    [16949291] = { id = 16949291}, -- wave 1 floor 1 vanguard eye
    [16949292] = { id = 16949292}, -- wave 1 floor 1 vanguard eye
    [16949303] = { id = 16949303}, -- wave 2 floor 1 vanguard eye
    [16949304] = { id = 16949304}, -- wave 2 floor 1 vanguard eye
    [16949305] = { id = 16949305}, -- wave 2 floor 1 vanguard eye
    [16949306] = { id = 16949306}, -- wave 2 floor 1 vanguard eye
    [16949322] = { id = 16949322}, -- wave 2 floor 1 vanguard eye
    [16949323] = { id = 16949323}, -- wave 2 floor 1 vanguard eye
    [16949324] = { id = 16949324}, -- wave 2 floor 1 vanguard eye

    [16949273] = { id = 16949273}, -- wave 1 floor 1 nightmare hornet
    [16949274] = { id = 16949274}, -- wave 1 floor 1 nightmare hornet
    [16949275] = { id = 16949275}, -- wave 1 floor 1 nightmare hornet
    [16949276] = { id = 16949276}, -- wave 1 floor 1 nightmare hornet
    [16949258] = { id = 16949258}, -- wave 2 floor 1 nightmare hornet
    [16949259] = { id = 16949259}, -- wave 2 floor 1 nightmare hornet
    [16949260] = { id = 16949260}, -- wave 2 floor 1 nightmare hornet
    [16949261] = { id = 16949261}, -- wave 2 floor 1 nightmare hornet

    [16949317] = { id = 16949317}, -- wave 1 floor 1 nightmare makura
    [16949318] = { id = 16949318}, -- wave 1 floor 1 nightmare makura
    [16949319] = { id = 16949319}, -- wave 1 floor 1 nightmare makura
    [16949320] = { id = 16949320}, -- wave 1 floor 1 nightmare makura
    [16949321] = { id = 16949321}, -- wave 1 floor 1 nightmare makura
    [16949266] = { id = 16949266}, -- wave 1 floor 1 nightmare makura
    [16949267] = { id = 16949267}, -- wave 1 floor 1 nightmare makura
    [16949268] = { id = 16949268}, -- wave 1 floor 1 nightmare makura
    [16949405] = { id = 16949405}, -- wave 2 floor 1 nightmare makura
    [16949406] = { id = 16949406}, -- wave 2 floor 1 nightmare makura
    [16949407] = { id = 16949407}, -- wave 2 floor 1 nightmare makura
    [16949408] = { id = 16949408}, -- wave 2 floor 1 nightmare makura
    [16949409] = { id = 16949409}, -- wave 2 floor 1 nightmare makura
    [16949410] = { id = 16949410}, -- wave 2 floor 1 nightmare makura
    [16949411] = { id = 16949411}, -- wave 2 floor 1 nightmare makura
    [16949412] = { id = 16949412}, -- wave 2 floor 1 nightmare makura

    [16949341] = { id = 16949341}, -- wave 1 floor 1 nightmare leech
    [16949342] = { id = 16949342}, -- wave 1 floor 1 nightmare leech
    [16949343] = { id = 16949343}, -- wave 1 floor 1 nightmare leech
    [16949344] = { id = 16949344}, -- wave 1 floor 1 nightmare leech
    [16949345] = { id = 16949345}, -- wave 1 floor 1 nightmare leech
    [16949346] = { id = 16949346}, -- wave 1 floor 1 nightmare leech
    [16949347] = { id = 16949347}, -- wave 1 floor 1 nightmare leech
    [16949348] = { id = 16949348}, -- wave 1 floor 1 nightmare leech
    [16949418] = { id = 16949418}, -- wave 2 floor 1 nightmare leech
    [16949419] = { id = 16949419}, -- wave 2 floor 1 nightmare leech
    [16949420] = { id = 16949420}, -- wave 2 floor 1 nightmare leech
    [16949421] = { id = 16949421}, -- wave 2 floor 1 nightmare leech
    [16949422] = { id = 16949422}, -- wave 2 floor 1 nightmare leech
    [16949423] = { id = 16949423}, -- wave 2 floor 1 nightmare leech
    [16949424] = { id = 16949424}, -- wave 2 floor 1 nightmare leech
    [16949425] = { id = 16949425}, -- wave 2 floor 1 nightmare leech


    -- floor 2
    [16949256] = { id =  16949256}, -- Nightmare Antlion ( 003 )
    [16949325] = { id = 16949325}, -- wave 1 floor 2 vanguard eye qm3
    [16949356] = { id = 16949356}, -- wave 1 floor 2 vanguard eye qm3
    [16949357] = { id = 16949357}, -- wave 1 floor 2 vanguard eye
    [16949358] = { id = 16949358}, -- wave 1 floor 2 vanguard eye
    [16949362] = { id = 16949362}, -- wave 1 floor 2 vanguard eye
    [16949363] = { id = 16949363}, -- wave 1 floor 2 vanguard eye
    [16949364] = { id = 16949364}, -- wave 1 floor 2 vanguard eye
    [16949369] = { id = 16949369}, -- wave 1 floor 2 vanguard eye
    [16949370] = { id = 16949370}, -- wave 1 floor 2 vanguard eye
    [16949371] = { id = 16949371}, -- wave 1 floor 2 vanguard eye
    [16949376] = { id = 16949376}, -- wave 1 floor 2 vanguard eye
    [16949377] = { id = 16949377}, -- wave 1 floor 2 vanguard eye
    [16949378] = { id = 16949378}, -- wave 2 floor 2 vanguard eye
    [16949379] = { id = 16949379}, -- wave 2 floor 2 vanguard eye
    [16949380] = { id = 16949380}, -- wave 2 floor 2 vanguard eye
    [16949381] = { id = 16949381}, -- wave 2 floor 2 vanguard eye
    [16949382] = { id = 16949382}, -- wave 2 floor 2 vanguard eye
    [16949383] = { id = 16949383}, -- wave 2 floor 2 vanguard eye
    [16949384] = { id = 16949384}, -- wave 2 floor 2 vanguard eye
    [16949385] = { id = 16949385}, -- wave 2 floor 2 vanguard eye
    [16949386] = { id = 16949386}, -- wave 2 floor 2 vanguard eye


    [16949277] = { id = 16949277}, -- wave 1 floor 2 nightmare hornet
    [16949278] = { id = 16949278}, -- wave 1 floor 2 nightmare hornet
    [16949279] = { id = 16949279}, -- wave 1 floor 2 nightmare hornet
    [16949280] = { id = 16949280}, -- wave 1 floor 2 nightmare hornet
    [16949262] = { id = 16949262}, -- wave 3 floor 2 nightmare hornet
    [16949263] = { id = 16949263}, -- wave 3 floor 2 nightmare hornet
    [16949264] = { id = 16949264}, -- wave 3 floor 2 nightmare hornet
    [16949265] = { id = 16949265}, -- wave 3 floor 2 nightmare hornet

    [16949332] = { id = 16949332}, -- wave 1 floor 2 nightmare cluster
    [16949333] = { id = 16949333}, -- wave 1 floor 2 nightmare cluster
    [16949334] = { id = 16949334}, -- wave 1 floor 2 nightmare cluster
    [16949335] = { id = 16949335}, -- wave 1 floor 2 nightmare cluster
    [16949336] = { id = 16949336}, -- wave 1 floor 2 nightmare cluster
    [16949337] = { id = 16949337}, -- wave 1 floor 2 nightmare cluster
    [16949338] = { id = 16949338}, -- wave 1 floor 2 nightmare cluster
    [16949339] = { id = 16949339}, -- wave 3 floor 2 nightmare cluster
    [16949340] = { id = 16949340}, -- wave 3 floor 2 nightmare cluster
    [16949388] = { id = 16949388}, -- wave 3 floor 2 nightmare cluster
    [16949389] = { id = 16949389}, -- wave 3 floor 2 nightmare cluster
    [16949395] = { id = 16949395}, -- wave 3 floor 2 nightmare cluster
    [16949403] = { id = 16949403}, -- wave 3 floor 2 nightmare cluster
    [16949404] = { id = 16949404}, -- wave 3 floor 2 nightmare cluster


    -- All children set to 1,1,1,0 in mob_spawn_points but listed here as a failsafe
    [16949431] = { id = 16949431}, -- child
    [16949432] = { id = 16949432}, -- child
    [16949433] = { id = 16949433}, -- child
    [16949434] = { id = 16949434}, -- child
    [16949435] = { id = 16949435}, -- child
    [16949436] = { id = 16949436}, -- child
    [16949437] = { id = 16949437}, -- child
    [16949438] = { id = 16949438}, -- child
    [16949439] = { id = 16949439}, -- child
    [16949440] = { id = 16949440}, -- child
    [16949441] = { id = 16949441}, -- child
    [16949442] = { id = 16949442}, -- child
    [16949426] = { id = 16949426}, -- child
    [16949427] = { id = 16949427}, -- child
    [16949428] = { id = 16949428}, -- child
    [16949429] = { id = 16949429}, -- child
    [16949430] = { id = 16949430}, -- child
    [16949413] = { id = 16949413}, -- child
    [16949414] = { id = 16949414}, -- child
    [16949415] = { id = 16949415}, -- child
    [16949416] = { id = 16949416}, -- child
    [16949417] = { id = 16949417}, -- child
    [16949281] = { id = 16949281}, -- child
    [16949282] = { id = 16949282}, -- child
    [16949283] = { id = 16949283}, -- child
    [16949284] = { id = 16949284}, -- child
    [16949285] = { id = 16949285}, -- child
    [16949286] = { id = 16949286}, -- child
    [16949293] = { id = 16949293}, -- child
    [16949294] = { id = 16949294}, -- child
    [16949295] = { id = 16949295}, -- child
    [16949298] = { id = 16949298}, -- child
    [16949299] = { id = 16949299}, -- child
    [16949300] = { id = 16949300}, -- child
    [16949287] = { id = 16949287}, -- child
    [16949296] = { id = 16949296}, -- child
    [16949301] = { id = 16949301}, -- child
    [16949307] = { id = 16949307}, -- child
    [16949308] = { id = 16949308}, -- child
    [16949309] = { id = 16949309}, -- child
    [16949310] = { id = 16949310}, -- child
    [16949311] = { id = 16949311}, -- child
    [16949312] = { id = 16949312}, -- child
    [16949313] = { id = 16949313}, -- child
    [16949314] = { id = 16949314}, -- child
    [16949315] = { id = 16949315}, -- child
    [16949316] = { id = 16949316}, -- child
    [16949349] = { id = 16949349}, -- child
    [16949350] = { id = 16949350}, -- child
    [16949353] = { id = 16949353}, -- child
    [16949354] = { id = 16949354}, -- child
    [16949355] = { id = 16949355}, -- child
    [16949359] = { id = 16949359}, -- child
    [16949360] = { id = 16949360}, -- child
    [16949361] = { id = 16949361}, -- child
    [16949365] = { id = 16949365}, -- child
    [16949366] = { id = 16949366}, -- child
    [16949372] = { id = 16949372}, -- child
    [16949373] = { id = 16949373}, -- child
    [16949351] = { id = 16949351}, -- child
    [16949367] = { id = 16949367}, -- child
    [16949374] = { id = 16949374}, -- child

    [16949443] = { id = 16949443}, -- Dummy Worm
    [16949444] = { id = 16949444}, -- Dummy Worm
    [16949445] = { id = 16949445}, -- Dummy Worm

}

mobList[zone].zoneID = zone

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
-- Floor 0
mobList[zone][16949255].pos = { 27.9, -12, 40, 58     } -- nightmare bugard
-- Floor 1
mobList[zone][16949257].pos = {  1.000, -23.351, 25.521, 110     } -- nightmare worm
mobList[zone][16949269].pos = { -0098.0, -0027.0,0008.4,195   } -- floor 1 vanguard eye qm3
mobList[zone][16949270].pos = { -0098.0, -0027.0,-0006.4,060   } -- floor 1 vanguard eye qm3
mobList[zone][16949271].pos = { -0078.0, -0021.5,0054.5,056   } -- floor 1 vanguard eye
mobList[zone][16949272].pos = { -0096.0, -0027.0,0041.3,063   } -- floor 1 vanguard eye
mobList[zone][16949289].pos = { -0110.0, -0027.0,0042.0,048   } -- floor 1 vanguard eye
mobList[zone][16949290].pos = { -0079.0, -0022.0,-0050.5,202   } -- floor 1 vanguard eye
mobList[zone][16949291].pos = { -0097.8, -0027.0,-0049.0,189   } -- floor 1 vanguard eye
mobList[zone][16949292].pos = { -0112.0, -0027.0,-0047.5,196   } -- floor 1 vanguard eye
mobList[zone][16949303].pos = { -0098.0, -0027.0,0008.4,195   } -- floor 1 vanguard eye
mobList[zone][16949304].pos = { -0098.0, -0027.0,-0006.4,060   } -- floor 1 vanguard eye
mobList[zone][16949305].pos = { -0078.0, -0021.5,0054.5,191   } -- floor 1 vanguard eye
mobList[zone][16949306].pos = { -0096.0, -0027.0,0041.3,176   } -- floor 1 vanguard eye
mobList[zone][16949322].pos = { -0110.0, -0027.0,0042.0,074   } -- floor 1 vanguard eye
mobList[zone][16949323].pos = { -0079.0, -0022.0,-0050.5,061   } -- floor 1 vanguard eye
mobList[zone][16949324].pos = { -0097.8, -0027.0,-0049.0,068   } -- floor 1 vanguard eye

mobList[zone][16949273].pos = { -0030.5, -0022.0,0030.0,031   } -- floor 1 nightmare hornet
mobList[zone][16949274].pos = { -0054.8, -0022.0,0044.0,003   } -- floor 1 nightmare hornet
mobList[zone][16949275].pos = { -0032.5, -0022.0,-0032.0,142   } -- floor 1 nightmare hornet
mobList[zone][16949276].pos = { -0056.8, -0022.0,-0043.5,000   } -- floor 1 nightmare hornet
mobList[zone][16949258].pos = { -0030.5, -0022.0,0030.0,159   } -- floor 1 nightmare hornet
mobList[zone][16949259].pos = { -0054.8, -0022.0,0044.0,131   } -- floor 1 nightmare hornet
mobList[zone][16949260].pos = { -0032.5, -0022.0,-0032.0,014   } -- floor 1 nightmare hornet
mobList[zone][16949261].pos = { -0056.8, -0022.0,-0043.5,128   } -- floor 1 nightmare hornet

mobList[zone][16949317].pos = { -0076.5, -0020.0,-0071.2,170   } -- floor 1 nightmare makura
mobList[zone][16949318].pos = { -0089.5, -0020.0,-0072.5,205   } -- floor 1 nightmare makura
mobList[zone][16949319].pos = { -0089.0, -0015.5,-0049.5,052   } -- floor 1 nightmare makura
mobList[zone][16949320].pos = { -0084.5, -0013.2,-0035.5,074   } -- floor 1 nightmare makura
mobList[zone][16949321].pos = { -0074.7, -0010.8,-0023.5,087   } -- floor 1 nightmare makura
mobList[zone][16949266].pos = { -0070.0, -0011.0,-0008.0,093   } -- floor 1 nightmare makura
mobList[zone][16949267].pos = { -0080.5, -0011.5,-0005.7,031   } -- floor 1 nightmare makura
mobList[zone][16949268].pos = { -0091.1, -0013.0,-0009.5,250   } -- floor 1 nightmare makura
mobList[zone][16949405].pos = { -0076.5, -0020.0,-0071.2,043   } -- floor 1 nightmare makura
mobList[zone][16949406].pos = { -0089.5, -0020.0,-0072.5,078   } -- floor 1 nightmare makura
mobList[zone][16949407].pos = { -0089.0, -0015.5,-0049.5,180   } -- floor 1 nightmare makura
mobList[zone][16949408].pos = { -0084.5, -0013.2,-0035.5,202   } -- floor 1 nightmare makura
mobList[zone][16949409].pos = { -0074.7, -0010.8,-0023.5,215   } -- floor 1 nightmare makura
mobList[zone][16949410].pos = { -0070.0, -0011.0,-0008.0,221   } -- floor 1 nightmare makura
mobList[zone][16949411].pos = { -0080.5, -0011.5,-0005.7,159   } -- floor 1 nightmare makura
mobList[zone][16949412].pos = { -0091.1, -0013.0,-0009.5,123   } -- floor 1 nightmare makura

mobList[zone][16949341].pos = { -0076.5, -0020.0,0071.2,085   } -- floor 1 nightmare leech
mobList[zone][16949342].pos = { -0089.5, -0020.0,0072.5,050   } -- floor 1 nightmare leech
mobList[zone][16949343].pos = { -0089.0, -0015.5,0049.5,203   } -- floor 1 nightmare leech
mobList[zone][16949344].pos = { -0084.5, -0013.2,0035.5,181   } -- floor 1 nightmare leech
mobList[zone][16949345].pos = { -0074.7, -0010.8,0023.5,168   } -- floor 1 nightmare leech
mobList[zone][16949346].pos = { -0070.0, -0011.0,0008.0,162   } -- floor 1 nightmare leech
mobList[zone][16949347].pos = { -0080.5, -0011.5,0005.7,224   } -- floor 1 nightmare leech
mobList[zone][16949348].pos = { -0091.1, -0013.0,0009.5,005   } -- floor 1 nightmare leech
mobList[zone][16949418].pos = { -0076.5, -0020.0,0071.2,213   } -- floor 1 nightmare leech
mobList[zone][16949419].pos = { -0089.5, -0020.0,0072.5,178   } -- floor 1 nightmare leech
mobList[zone][16949420].pos = { -0089.0, -0015.5,0049.5,076   } -- floor 1 nightmare leech
mobList[zone][16949421].pos = { -0084.5, -0013.2,0035.5,054   } -- floor 1 nightmare leech
mobList[zone][16949422].pos = { -0074.7, -0010.8,0023.5,041   } -- floor 1 nightmare leech
mobList[zone][16949423].pos = { -0070.0, -0011.0,0008.0,035   } -- floor 1 nightmare leech
mobList[zone][16949424].pos = { -0080.5, -0011.5,0005.7,097   } -- floor 1 nightmare leech
mobList[zone][16949425].pos = { -0091.1, -0013.0,0009.5,133   } -- floor 1 nightmare leech


-- Floor 2
mobList[zone][16949256].pos = { 17    ,     -36,     19,   0     } -- nightmare antlion
mobList[zone][16949443].pos = { 17    ,     -36,     19,   0     } -- dummy worm
mobList[zone][16949444].pos = { 17    ,     -36,     19,   0     } -- dummy worm
mobList[zone][16949445].pos = { 17    ,     -36,     19,   0     } -- dummy worm
mobList[zone][16949325].pos = { 0098.0, -0041.0,0006.0,188   } -- floor 2 vanguard eye qm3
mobList[zone][16949356].pos = { 0098.0, -0041.0,-0006.0,063   } -- floor 2 vanguard eye qm3
mobList[zone][16949357].pos = { 0078.0, -0038.0,0029.0,161   } -- floor 2 vanguard eye
mobList[zone][16949358].pos = { 0080.0, -0036.0,0044.0,126   } -- floor 2 vanguard eye
mobList[zone][16949362].pos = { 0076.0, -0034.0,0069.0,058   } -- floor 2 vanguard eye
mobList[zone][16949363].pos = { 0097.5, -0041.0,0047.5,066   } -- floor 2 vanguard eye
mobList[zone][16949364].pos = { 0114.8, -0041.0,0050.0,075   } -- floor 2 vanguard eye
mobList[zone][16949369].pos = { 0081.0, -0038.0,-0030.5,097   } -- floor 2 vanguard eye
mobList[zone][16949370].pos = { 0080.0, -0036.0,-0045.0,125   } -- floor 2 vanguard eye
mobList[zone][16949371].pos = { 0078.5, -0034.0,-0067.0,189   } -- floor 2 vanguard eye
mobList[zone][16949376].pos = { 0096.0, -0041.0,-0045.7,185   } -- floor 2 vanguard eye
mobList[zone][16949377].pos = { 0113.0, -0041.0,-0047.0,181   } -- floor 2 vanguard eye
mobList[zone][16949378].pos = { 0078.0, -0038.0,0029.0,033   } -- floor 2 vanguard eye
mobList[zone][16949379].pos = { 0080.0, -0036.0,0044.0,254   } -- floor 2 vanguard eye
mobList[zone][16949380].pos = { 0076.0, -0034.0,0069.0,186   } -- floor 2 vanguard eye
mobList[zone][16949381].pos = { 0097.5, -0041.0,0047.5,194   } -- floor 2 vanguard eye
mobList[zone][16949382].pos = { 0114.8, -0041.0,0050.0,203   } -- floor 2 vanguard eye
mobList[zone][16949383].pos = { 0081.0, -0038.0,-0030.5,225   } -- floor 2 vanguard eye
mobList[zone][16949384].pos = { 0080.0, -0036.0,-0045.0,253   } -- floor 2 vanguard eye
mobList[zone][16949385].pos = { 0078.5, -0034.0,-0067.0,061   } -- floor 2 vanguard eye
mobList[zone][16949386].pos = { 0096.0, -0041.0,-0045.7,057   } -- floor 2 vanguard eye

mobList[zone][16949277].pos = { 0031.5, -0036.0,0031.5,098   } -- floor 2 nightmare hornet
mobList[zone][16949278].pos = { 0061.0, -0036.0,0043.8,124   } -- floor 2 nightmare hornet
mobList[zone][16949279].pos = { 0031.8, -0036.0,-0031.5,156   } -- floor 2 nightmare hornet
mobList[zone][16949280].pos = { 0058.5, -0036.0,-0043.8,129   } -- floor 2 nightmare hornet
mobList[zone][16949262].pos = { 0031.5, -0036.0,0031.5,226   } -- floor 2 nightmare hornet
mobList[zone][16949263].pos = { 0061.0, -0036.0,0043.8,252   } -- floor 2 nightmare hornet
mobList[zone][16949264].pos = { 0031.8, -0036.0,-0031.5,028   } -- floor 2 nightmare hornet
mobList[zone][16949265].pos = { 0058.5, -0036.0,-0043.8,001   } -- floor 2 nightmare hornet

mobList[zone][16949332].pos = { 0087.5, -0028.0,0039.5,200   } -- floor 2 nightmare cluster
mobList[zone][16949333].pos = { 0074.0, -0025.0,0020.0,184   } -- floor 2 nightmare cluster
mobList[zone][16949334].pos = { 0074.0, -0025.0,0003.8,198   } -- floor 2 nightmare cluster
mobList[zone][16949335].pos = { 0080.0, -0025.0,-0001.7,011   } -- floor 2 nightmare cluster
mobList[zone][16949336].pos = { 0074.0, -0025.0,-0010.5,058   } -- floor 2 nightmare cluster
mobList[zone][16949337].pos = { 0080.5, -0025.5,-0031.0,027   } -- floor 2 nightmare cluster
mobList[zone][16949338].pos = { 0088.0, -0030.0,-0052.0,052   } -- floor 2 nightmare cluster
mobList[zone][16949339].pos = { 0087.5, -0028.0,0039.5,073   } -- floor 2 nightmare cluster
mobList[zone][16949340].pos = { 0074.0, -0025.0,0020.0,057   } -- floor 2 nightmare cluster
mobList[zone][16949388].pos = { 0074.0, -0025.0,0003.8,071   } -- floor 2 nightmare cluster
mobList[zone][16949389].pos = { 0080.0, -0025.0,-0001.7,139   } -- floor 2 nightmare cluster
mobList[zone][16949395].pos = { 0074.0, -0025.0,-0010.5,186   } -- floor 2 nightmare cluster
mobList[zone][16949403].pos = { 0080.5, -0025.5,-0031.0,155   } -- floor 2 nightmare cluster
mobList[zone][16949404].pos = { 0088.0, -0030.0,-0052.0,180   } -- floor 2 nightmare cluster


-- -- set statue eye color
-- mobList[zone][SMB+75 ].eyes = dynamis.eyes.BLUE
-- mobList[zone][SMB+76 ].eyes = dynamis.eyes.GREEN
-- mobList[zone][SMB+25 ].eyes = dynamis.eyes.BLUE

-- set time extensions (two others are received in qm3.lua)
mobList[zone][16949255].timeExtension = 15 -- bugard
mobList[zone][16949256].timeExtension = 30 -- antlion

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements    = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty

-- set which waves this monster will spawn on (can be multiple)
-- wave 1: initial mobs
mobList[zone][16949255].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949257].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949256].waves = { 1, nil, nil, nil, nil }

mobList[zone][16949443].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949444].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949445].waves = { 1, nil, nil, nil, nil }

-- Statues
mobList[zone][16949269].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949270].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949271].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949272].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949289].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949290].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949291].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949292].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949303].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949304].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949305].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949306].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949322].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949323].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949324].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949325].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949356].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949357].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949358].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949362].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949363].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949364].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949369].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949370].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949371].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949376].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949377].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949378].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949379].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949380].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949381].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949382].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949383].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949384].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949385].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949386].waves = { nil, nil, 3, nil, nil }

-- hornets
mobList[zone][16949273].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949274].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949275].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949276].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949258].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949259].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949260].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949261].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949277].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949278].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949279].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949280].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949262].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949263].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949264].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949265].waves = { nil, nil, 3, nil, nil }

-- makura
mobList[zone][16949317].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949318].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949319].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949320].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949321].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949266].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949267].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949268].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949405].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949406].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949407].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949408].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949409].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949410].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949411].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949412].waves = { nil, 2, nil, nil, nil }

-- leech
mobList[zone][16949341].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949342].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949343].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949344].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949345].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949346].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949347].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949348].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949418].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949419].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949420].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949421].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949422].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949423].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949424].waves = { nil, 2, nil, nil, nil }
mobList[zone][16949425].waves = { nil, 2, nil, nil, nil }

-- cluster
mobList[zone][16949332].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949333].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949334].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949335].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949336].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949337].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949338].waves = { 1, nil, nil, nil, nil }
mobList[zone][16949339].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949340].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949388].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949389].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949395].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949403].waves = { nil, nil, 3, nil, nil }
mobList[zone][16949404].waves = { nil, nil, 3, nil, nil }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- Statues primary childgroups
mobList[zone][16949269].randomChildrenCount1 = 4 ; mobList[zone][16949269].randomChildrenList1 = 5  -- floor 1 vanguard eye qm3
mobList[zone][16949270].randomChildrenCount1 = 3 ; mobList[zone][16949270].randomChildrenList1 = 6  -- floor 1 vanguard eye qm3
mobList[zone][16949271].randomChildrenCount1 = 3 ; mobList[zone][16949271].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949272].randomChildrenCount1 = 1 ; mobList[zone][16949272].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949289].randomChildrenCount1 = 4 ; mobList[zone][16949289].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949290].randomChildrenCount1 = 3 ; mobList[zone][16949290].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949291].randomChildrenCount1 = 4 ; mobList[zone][16949291].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949292].randomChildrenCount1 = 5 ; mobList[zone][16949292].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949303].randomChildrenCount1 = 4 ; mobList[zone][16949303].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949304].randomChildrenCount1 = 2 ; mobList[zone][16949304].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949305].randomChildrenCount1 = 3 ; mobList[zone][16949305].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949306].randomChildrenCount1 = 3 ; mobList[zone][16949306].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949322].randomChildrenCount1 = 2 ; mobList[zone][16949322].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949323].randomChildrenCount1 = 4 ; mobList[zone][16949323].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949324].randomChildrenCount1 = 4 ; mobList[zone][16949324].randomChildrenList1 = 5  -- floor 1 vanguard eye
mobList[zone][16949325].randomChildrenCount1 = 3 ; mobList[zone][16949325].randomChildrenList1 = 8  -- floor 2 vanguard eye qm3
mobList[zone][16949356].randomChildrenCount1 = 2 ; mobList[zone][16949356].randomChildrenList1 = 8  -- floor 2 vanguard eye qm3
mobList[zone][16949357].randomChildrenCount1 = 2 ; mobList[zone][16949357].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949358].randomChildrenCount1 = 2 ; mobList[zone][16949358].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949362].randomChildrenCount1 = 2 ; mobList[zone][16949362].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949363].randomChildrenCount1 = 2 ; mobList[zone][16949363].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949364].randomChildrenCount1 = 2 ; mobList[zone][16949364].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949369].randomChildrenCount1 = 3 ; mobList[zone][16949369].randomChildrenList1 = 9  -- floor 2 vanguard eye
mobList[zone][16949370].randomChildrenCount1 = 3 ; mobList[zone][16949370].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949371].randomChildrenCount1 = 2 ; mobList[zone][16949371].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949376].randomChildrenCount1 = 3 ; mobList[zone][16949376].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949377].randomChildrenCount1 = 1 ; mobList[zone][16949377].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949378].randomChildrenCount1 = 2 ; mobList[zone][16949378].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949379].randomChildrenCount1 = 2 ; mobList[zone][16949379].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949380].randomChildrenCount1 = 2 ; mobList[zone][16949380].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949381].randomChildrenCount1 = 2 ; mobList[zone][16949381].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949382].randomChildrenCount1 = 2 ; mobList[zone][16949382].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949383].randomChildrenCount1 = 3 ; mobList[zone][16949383].randomChildrenList1 = 9  -- floor 2 vanguard eye
mobList[zone][16949384].randomChildrenCount1 = 3 ; mobList[zone][16949384].randomChildrenList1 = 7  -- floor 2 vanguard eye
mobList[zone][16949385].randomChildrenCount1 = 4 ; mobList[zone][16949385].randomChildrenList1 = 8  -- floor 2 vanguard eye
mobList[zone][16949386].randomChildrenCount1 = 2 ; mobList[zone][16949386].randomChildrenList1 = 8  -- floor 2 vanguard eye

-- Statues secondary childgroups
mobList[zone][16949272].randomChildrenCount2 = 2 ; mobList[zone][16949272].randomChildrenList2 = 6  -- floor 1 vanguard eye
mobList[zone][16949289].randomChildrenCount2 = 1 ; mobList[zone][16949289].randomChildrenList2 = 6  -- floor 1 vanguard eye
mobList[zone][16949304].randomChildrenCount2 = 1 ; mobList[zone][16949304].randomChildrenList2 = 6  -- floor 1 vanguard eye
mobList[zone][16949305].randomChildrenCount2 = 1 ; mobList[zone][16949305].randomChildrenList2 = 6  -- floor 1 vanguard eye
mobList[zone][16949322].randomChildrenCount2 = 2 ; mobList[zone][16949322].randomChildrenList2 = 6  -- floor 1 vanguard eye
mobList[zone][16949356].randomChildrenCount2 = 1 ; mobList[zone][16949356].randomChildrenList2 = 7  -- floor 2 vanguard eye qm3
mobList[zone][16949357].randomChildrenCount2 = 1 ; mobList[zone][16949357].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949358].randomChildrenCount2 = 1 ; mobList[zone][16949358].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949362].randomChildrenCount2 = 1 ; mobList[zone][16949362].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949363].randomChildrenCount2 = 1 ; mobList[zone][16949363].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949364].randomChildrenCount2 = 1 ; mobList[zone][16949364].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949370].randomChildrenCount2 = 1 ; mobList[zone][16949370].randomChildrenList2 = 9  -- floor 2 vanguard eye
mobList[zone][16949371].randomChildrenCount2 = 1 ; mobList[zone][16949371].randomChildrenList2 = 9  -- floor 2 vanguard eye
mobList[zone][16949376].randomChildrenCount2 = 1 ; mobList[zone][16949376].randomChildrenList2 = 9  -- floor 2 vanguard eye
mobList[zone][16949377].randomChildrenCount2 = 3 ; mobList[zone][16949377].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949378].randomChildrenCount2 = 1 ; mobList[zone][16949378].randomChildrenList2 = 9  -- floor 2 vanguard eye
mobList[zone][16949379].randomChildrenCount2 = 2 ; mobList[zone][16949379].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949380].randomChildrenCount2 = 2 ; mobList[zone][16949380].randomChildrenList2 = 7  -- floor 2 vanguard eye
mobList[zone][16949381].randomChildrenCount2 = 1 ; mobList[zone][16949381].randomChildrenList2 = 9  -- floor 2 vanguard eye
mobList[zone][16949382].randomChildrenCount2 = 1 ; mobList[zone][16949382].randomChildrenList2 = 9  -- floor 2 vanguard eye
mobList[zone][16949386].randomChildrenCount2 = 1 ; mobList[zone][16949386].randomChildrenList2 = 7  -- floor 2 vanguard eye

-- Statues tertiary childgroups
mobList[zone][16949357].randomChildrenCount3 = 1 ; mobList[zone][16949357].randomChildrenList3 = 9  -- floor 2 vanguard eye
mobList[zone][16949363].randomChildrenCount3 = 1 ; mobList[zone][16949363].randomChildrenList3 = 9  -- floor 2 vanguard eye
mobList[zone][16949364].randomChildrenCount3 = 1 ; mobList[zone][16949364].randomChildrenList3 = 9  -- floor 2 vanguard eye
mobList[zone][16949378].randomChildrenCount3 = 2 ; mobList[zone][16949378].randomChildrenList3 = 7  -- floor 2 vanguard eye
mobList[zone][16949381].randomChildrenCount3 = 2 ; mobList[zone][16949381].randomChildrenList3 = 7  -- floor 2 vanguard eye
mobList[zone][16949382].randomChildrenCount3 = 2 ; mobList[zone][16949382].randomChildrenList3 = 7  -- floor 2 vanguard eye

-- hornets
mobList[zone][16949273].randomChildrenCount = 2 ; mobList[zone][16949273].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949274].randomChildrenCount = 2 ; mobList[zone][16949274].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949275].randomChildrenCount = 2 ; mobList[zone][16949275].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949276].randomChildrenCount = 2 ; mobList[zone][16949276].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949258].randomChildrenCount = 2 ; mobList[zone][16949258].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949259].randomChildrenCount = 2 ; mobList[zone][16949259].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949260].randomChildrenCount = 2 ; mobList[zone][16949260].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949261].randomChildrenCount = 2 ; mobList[zone][16949261].randomChildrenList = 1  -- floor 1 nightmare hornet
mobList[zone][16949277].randomChildrenCount = 2 ; mobList[zone][16949277].randomChildrenList = 1  -- floor 2 nightmare hornet
mobList[zone][16949278].randomChildrenCount = 2 ; mobList[zone][16949278].randomChildrenList = 1  -- floor 2 nightmare hornet
mobList[zone][16949279].randomChildrenCount = 2 ; mobList[zone][16949279].randomChildrenList = 1  -- floor 2 nightmare hornet
mobList[zone][16949280].randomChildrenCount = 2 ; mobList[zone][16949280].randomChildrenList = 1  -- floor 2 nightmare hornet
mobList[zone][16949262].randomChildrenCount = 2 ; mobList[zone][16949262].randomChildrenList = 1  -- floor 2 nightmare hornet
mobList[zone][16949263].randomChildrenCount = 2 ; mobList[zone][16949263].randomChildrenList = 1  -- floor 2 nightmare hornet
mobList[zone][16949264].randomChildrenCount = 2 ; mobList[zone][16949264].randomChildrenList = 1  -- floor 2 nightmare hornet
mobList[zone][16949265].randomChildrenCount = 2 ; mobList[zone][16949265].randomChildrenList = 1  -- floor 2 nightmare hornet

-- makura
mobList[zone][16949317].randomChildrenCount = 1 ; mobList[zone][16949317].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949318].randomChildrenCount = 2 ; mobList[zone][16949318].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949319].randomChildrenCount = 1 ; mobList[zone][16949319].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949320].randomChildrenCount = 2 ; mobList[zone][16949320].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949321].randomChildrenCount = 1 ; mobList[zone][16949321].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949266].randomChildrenCount = 2 ; mobList[zone][16949266].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949267].randomChildrenCount = 1 ; mobList[zone][16949267].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949268].randomChildrenCount = 2 ; mobList[zone][16949268].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949405].randomChildrenCount = 1 ; mobList[zone][16949405].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949406].randomChildrenCount = 2 ; mobList[zone][16949406].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949407].randomChildrenCount = 1 ; mobList[zone][16949407].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949408].randomChildrenCount = 2 ; mobList[zone][16949408].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949409].randomChildrenCount = 1 ; mobList[zone][16949409].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949410].randomChildrenCount = 2 ; mobList[zone][16949410].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949411].randomChildrenCount = 1 ; mobList[zone][16949411].randomChildrenList = 4  -- floor 1 nightmare makura
mobList[zone][16949412].randomChildrenCount = 2 ; mobList[zone][16949412].randomChildrenList = 4  -- floor 1 nightmare makura


-- leech
mobList[zone][16949341].randomChildrenCount = 1 ; mobList[zone][16949341].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949342].randomChildrenCount = 2 ; mobList[zone][16949342].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949343].randomChildrenCount = 1 ; mobList[zone][16949343].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949344].randomChildrenCount = 2 ; mobList[zone][16949344].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949345].randomChildrenCount = 1 ; mobList[zone][16949345].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949346].randomChildrenCount = 2 ; mobList[zone][16949346].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949347].randomChildrenCount = 1 ; mobList[zone][16949347].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949348].randomChildrenCount = 2 ; mobList[zone][16949348].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949418].randomChildrenCount = 1 ; mobList[zone][16949418].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949419].randomChildrenCount = 2 ; mobList[zone][16949419].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949420].randomChildrenCount = 1 ; mobList[zone][16949420].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949421].randomChildrenCount = 2 ; mobList[zone][16949421].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949422].randomChildrenCount = 1 ; mobList[zone][16949422].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949423].randomChildrenCount = 2 ; mobList[zone][16949423].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949424].randomChildrenCount = 1 ; mobList[zone][16949424].randomChildrenList = 3  -- floor 1 nightmare leech
mobList[zone][16949425].randomChildrenCount = 2 ; mobList[zone][16949425].randomChildrenList = 3  -- floor 1 nightmare leech

-- clusters
mobList[zone][16949332].randomChildrenCount = 2 ; mobList[zone][16949332].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949333].randomChildrenCount = 2 ; mobList[zone][16949333].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949334].randomChildrenCount = 2 ; mobList[zone][16949334].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949335].randomChildrenCount = 2 ; mobList[zone][16949335].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949336].randomChildrenCount = 2 ; mobList[zone][16949336].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949337].randomChildrenCount = 2 ; mobList[zone][16949337].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949338].randomChildrenCount = 2 ; mobList[zone][16949338].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949339].randomChildrenCount = 2 ; mobList[zone][16949339].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949340].randomChildrenCount = 2 ; mobList[zone][16949340].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949388].randomChildrenCount = 2 ; mobList[zone][16949388].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949389].randomChildrenCount = 2 ; mobList[zone][16949389].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949395].randomChildrenCount = 2 ; mobList[zone][16949395].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949403].randomChildrenCount = 2 ; mobList[zone][16949403].randomChildrenList = 2  -- floor 2 nightmare cluster
mobList[zone][16949404].randomChildrenCount = 2 ; mobList[zone][16949404].randomChildrenList = 2  -- floor 2 nightmare cluster


-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
-- building out enough extra for 3 fights at a time
-- but as wave 1 parents are killed, need to figure out how to include them as potential children
randomChildrenList[zone] = 
{
    -- hornets 2 children per
    [1] =
    {
        16949431,
        16949432,
        16949433,
        16949434,
        16949435,
        16949436,
        -- 16949273,
        -- 16949274,
        -- 16949275,
        -- 16949276,
        -- 16949277,
        -- 16949278,
        -- 16949279,
        -- 16949280,
    },
    -- clusters 2 children per
    [2] =
    {
        16949437,
        16949438,
        16949439,
        16949440,
        16949441,
        16949442,
        -- 16949332,
        -- 16949333,
        -- 16949334,
        -- 16949335,
        -- 16949336,
        -- 16949337,
        -- 16949338,
    },
    -- leech avg 1.5 children per
    [3] =
    {
        16949426,
        16949427,
        16949428,
        16949429,
        16949430,
        -- 16949341,
        -- 16949342,
        -- 16949343,
        -- 16949344,
        -- 16949345,
        -- 16949346,
        -- 16949347,
        -- 16949348,
    },
    -- makara avg 1.5 children per
    [4] =
    {
        16949413,
        16949414,
        16949415,
        16949416,
        16949417,
        -- 16949317,
        -- 16949318,
        -- 16949319,
        -- 16949320,
        -- 16949321,
        -- 16949266,
        -- 16949267,
        -- 16949268,
    },
    -- hydra
    [5] =
    {
        16949281, -- 'Hydra_Warrior
        16949282, -- 'Hydra_Red_Mage',
        16949283, -- 'Hydra_Paladin
        16949284, -- 'Hydra_Ninja
        16949285, -- 'Hydra_Monk
        16949286, -- 'Hydra_White_Mage',
        16949293, -- 'Hydra_Black_Mage',
        16949294, -- 'Hydra_Dark_Knight',
        16949295, -- 'Hydra_Bard'
        16949298, -- 'Hydra_Thief'
        16949299, -- 'Hydra_Ranger'
        16949300, -- 'Hydra_Samurai'
    },
    -- hydra with pets
    [6] =
    {
        16949287, -- 'Hydra_Beastmaster
        16949296, -- 'Hydra_Dragoon'
        16949301, -- 'Hydra_Summoner'
    },
    -- Nightmare Taurus
    [7] =
    {
        16949307, -- 'Nightmare_Taurus'
        16949308, -- 'Nightmare_Taurus'
        16949309, -- 'Nightmare_Taurus'
        16949310, -- 'Nightmare_Taurus'
        16949311, -- 'Nightmare_Taurus'
        16949312, -- 'Nightmare_Taurus'
        16949313, -- 'Nightmare_Taurus'
        16949314, -- 'Nightmare_Taurus'
        16949315, -- 'Nightmare_Taurus'
        16949316, -- 'Nightmare_Taurus'
    },
    -- kindred
    [8] =
    {
        16949349, -- 'Kindred_Monk
        16949350, -- 'Kindred_Black_Mage
        16949353, -- 'Kindred_White_Mage
        16949354, -- 'Kindred_Dark_Knight
        16949355, -- 'Kindred_Ranger
        16949359, -- 'Kindred_Red_Mage
        16949360, -- 'Kindred_Paladin
        16949361, -- 'Kindred_Samurai
        16949365, -- 'Kindred_Warrior
        16949366, -- 'Kindred_Thief
        16949372, -- 'Kindred_Bard
        16949373, -- 'Kindred_Ninja
    },
    -- kindred with pets
    [9] =
    {
        16949351, -- 'Kindred_Beastmaster
        16949367, -- 'Kindred_Summoner
        16949374, -- 'Kindred_Dragoon
    }
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] = 
{

}