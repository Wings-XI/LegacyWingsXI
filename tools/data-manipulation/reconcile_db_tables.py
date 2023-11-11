"""
SELECT table_schema, table_name, group_concat(COLUMN_NAME)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA IN ('wingsdb','xidb') AND TABLE_NAME IN ('chars',
'char_blacklist',
'char_effects',
'char_equip',
'char_equip_saved',
'char_exp',
'char_history',
'char_inventory',
'char_jobs',
'char_look',
'char_merit',
'char_pet',
'char_points',
'char_profile',
'char_recast',
'char_skills',
'char_spells',
'char_stats',
'char_storage',
'char_style',
'char_unlocks',
'char_vars',
'delivery_box')
GROUP BY table_schema,table_name order by table_name,table_schema ;
"""

# the above will provide a list of all tables and columns for each db, paste below
results = """
table_schema;table_name;group_concat(COLUMN_NAME)
wingsdb;chars;eminence,playtime,zones,titles,weaponskills,abilities,set_blue_spells,keyitems,quests,unlocked_weapons,gmlevel,mentor,lastupdate,timecreated,moghancement,languages,chatfilters,nnameflags,isstylelocked,campaign_allegiance,campaign,assault,pos_rot,pos_prevzone,pos_zone,nation,charname,goldworldpass,accid,content_id,charid,pos_x,pos_y,missions,home_z,home_y,home_x,home_rot,home_zone,boundary,moghouse,pos_z
xidb;chars;unlocked_weapons,playtime,zones,titles,weaponskills,abilities,set_blue_spells,keyitems,quests,gmlevel,languages,lastupdate,timecreated,moghancement,chatfilters,nnameflags,isstylelocked,campaign_allegiance,job_master,mentor,eminence,campaign,pos_x,pos_rot,pos_prevzone,pos_zone,nation,charname,original_accid,accid,charid,pos_y,pos_z,assault,missions,home_z,home_y,home_x,home_rot,home_zone,boundary,moghouse
wingsdb;char_blacklist;charid_target,charid_owner
xidb;char_blacklist;charid_target,charid_owner
wingsdb;char_effects;timestamp,flags,tier,subpower,subid,duration,tick,power,icon,effectid,charid
xidb;char_effects;timestamp,flags,tier,subpower,subid,duration,tick,power,icon,effectid,charid
wingsdb;char_equip;containerid,equipslotid,slotid,charid
xidb;char_equip;containerid,equipslotid,slotid,charid
xidb;char_equip_saved;feet,neck,waist,ear1,ear2,ring1,ring2,back,legs,hands,charid,jobid,main,sub,ranged,ammo,head,body
wingsdb;char_exp;nin,drg,smn,blu,cor,pup,dnc,sch,geo,run,merits,limits,sam,rng,charid,mode,war,mnk,whm,blm,rdm,brd,bst,drk,pld,thf
xidb;char_exp;cor,blu,smn,drg,nin,pup,dnc,sch,geo,run,merits,limits,sam,rng,charid,mode,war,mnk,whm,blm,rdm,thf,pld,drk,bst,brd
xidb;char_history;items_used,chats_sent,npc_interactions,battles_fought,gm_calls,distance_travelled,ws_used,abilities_used,spells_cast,charid,enemies_defeated,times_knocked_out,mh_entrances,joined_parties,joined_alliances
wingsdb;char_inventory;extra,signature,bazaar,quantity,itemId,slot,location,charid
xidb;char_inventory;extra,signature,bazaar,quantity,itemId,slot,location,charid
wingsdb;char_jobs;sam,nin,drg,smn,blu,cor,pup,dnc,sch,geo,run,rng,brd,bst,charid,unlocked,genkai,war,mnk,whm,blm,rdm,thf,pld,drk
xidb;char_jobs;sam,nin,drg,smn,blu,cor,pup,dnc,sch,geo,run,rng,brd,bst,charid,unlocked,genkai,war,mnk,whm,blm,rdm,thf,pld,drk
wingsdb;char_look;legs,feet,main,sub,ranged,hands,body,head,size,race,face,charid
xidb;char_look;legs,feet,main,sub,ranged,hands,body,head,size,race,face,charid
wingsdb;char_merit;upgrades,meritid,charid
xidb;char_merit;upgrades,meritid,charid
wingsdb;char_pet;chocoboid,adventuringfellowid,equipped_attachments,unlocked_attachments,automatonid,wyvernid,charid
xidb;char_pet;field_chocobo,chocoboid,adventuringfellowid,equipped_attachments,unlocked_attachments,automatonid,wyvernid,charid
wingsdb;char_points;mweya_plasm,cruor,resistance_credit,dominion_note,fifth_echelon_trophy,fourth_echelon_trophy,third_echelon_trophy,second_echelon_trophy,first_echelon_trophy,cave_points,id_tags,pulchridopt_wing,lebondopt_wing,ilrusi_assault_point,nyzul_isle_assault_point,zeni_point,jetton,therion_ichor,allied_notes,aman_vouchers,login_points,bayld,kinetic_unit,obsidian_fragment,op_credits,traverser_stones,voidstones,reclamation_marks,unity_accolades,fire_crystals,ice_crystals,wind_crystals,earth_crystals,lightning_crystals,water_crystals,light_crystals,dark_crystals,rems_ch10,rems_ch9,rems_ch8,kupofried_corundums,imprimaturs,pheromone_sacks,rems_ch1,rems_ch2,rems_ch3,rems_ch4,rems_ch5,rems_ch6,rems_ch7,deeds,charid,guild_smithing,guild_goldsmithing,guild_weaving,guild_leathercraft,guild_bonecraft,guild_alchemy,guild_cooking,cinder,fire_fewell,ice_fewell,guild_woodworking,guild_fishing,scyld,sandoria_cp,bastok_cp,windurst_cp,beastman_seal,kindred_seal,kindred_crest,high_kindred_crest,sacred_kindred_crest,ancient_beastcoin,valor_point,wind_fewell,earth_fewell,lightning_fewell,moblin_marble,infamy,prestige,legion_point,spark_of_eminence,shining_star,imperial_standing,leujaoam_assault_point,mamool_assault_point,lebros_assault_point,periqia_assault_point,phantom_worm,morion_worm,water_fewell,light_fewell,dark_fewell,ballista_point,fellow_point,daily_tally,chocobuck_sandoria,chocobuck_bastok,chocobuck_windurst,research_mark,tunnel_worm
xidb;char_points;leafslit_stone,snoworb_stone_2,snoworb_stone_1,snoworb_stone,snowdim_stone_2,snowdim_stone_1,snowdim_stone,snowtip_stone_2,snowtip_stone_1,snowtip_stone,leafslit_stone_1,leafslit_stone_2,duskslit_stone,leaforb_stone_2,leaforb_stone_1,leaforb_stone,leafdim_stone_2,leafdim_stone_1,leafdim_stone,leaftip_stone_2,leaftip_stone_1,leaftip_stone,snowslit_stone_2,snowslit_stone_1,current_accolades,deeds,dark_crystals,light_crystals,water_crystals,lightning_crystals,earth_crystals,wind_crystals,ice_crystals,prev_accolades,mystical_canteen,ghastly_stone,snowslit_stone,wailing_stone_2,wailing_stone_1,wailing_stone,verdigris_stone_2,verdigris_stone_1,verdigris_stone,ghastly_stone_2,ghastly_stone_1,fire_crystals,duskslit_stone_1,silver_aman_voucher,induration_spheres_set,liquefaction_spheres_set,mc_s_sr03_set,mc_s_sr02_set,mc_s_sr01_set,dark_crystal_set,light_crystal_set,water_crystal_set,lightning_crystal_set,detonation_spheres_set,scission_spheres_set,impaction_spheres_set,darkness_spheres_set,light_spheres_set,gravitation_spheres_set,fragmentation_spheres_set,distortion_spheres_set,fusion_spheres_set,compression_spheres_set,transfixion_spheres_set,reverberation_spheres_set,earth_crystal_set,wind_crystal_set,duskorb_stone_2,duskorb_stone_1,duskorb_stone,duskdim_stone_2,duskdim_stone_1,duskdim_stone,dusktip_stone_2,dusktip_stone_1,dusktip_stone,pellucid_stone,fern_stone,taupe_stone,ice_crystal_set,fire_crystal_set,crafter_points,gallantry,total_hallmarks,current_hallmarks,potpourri,escha_silt,escha_beads,duskslit_stone_2,shining_star,daily_tally,fellow_point,ballista_point,dark_fewell,light_fewell,water_fewell,lightning_fewell,earth_fewell,wind_fewell,chocobuck_sandoria,chocobuck_bastok,chocobuck_windurst,spark_of_eminence,legion_point,prestige,infamy,moblin_marble,phantom_worm,morion_worm,tunnel_worm,research_mark,ice_fewell,fire_fewell,ancient_beastcoin,sacred_kindred_crest,high_kindred_crest,kindred_crest,kindred_seal,beastman_seal,windurst_cp,bastok_cp,sandoria_cp,valor_point,scyld,guild_fishing,cinder,guild_cooking,guild_alchemy,guild_bonecraft,guild_leathercraft,guild_weaving,guild_goldsmithing,guild_smithing,guild_woodworking,charid,imperial_standing,unity_accolades,imprimaturs,kupofried_corundums,voidstones,traverser_stones,op_credits,id_tags,cave_points,first_echelon_trophy,second_echelon_trophy,pheromone_sacks,rems_ch1,rems_ch2,reclamation_marks,rems_ch10,rems_ch9,rems_ch8,rems_ch7,rems_ch6,rems_ch5,rems_ch4,rems_ch3,third_echelon_trophy,fourth_echelon_trophy,allied_notes,therion_ichor,jetton,zeni_point,nyzul_isle_assault_point,ilrusi_assault_point,periqia_assault_point,lebros_assault_point,mamool_assault_point,leujaoam_assault_point,aman_vouchers,login_points,fifth_echelon_trophy,dominion_note,resistance_credit,cruor,mweya_plasm,pulchridopt_wing,lebondopt_wing,obsidian_fragment,kinetic_unit,bayld
wingsdb;char_profile;fame_aby_tahrongi,fame_aby_latheine,fame_aby_misareaux,fame_aby_vunkerl,fame_aby_attohwa,fame_aby_altepa,fame_aby_grauberg,fame_aby_uleguerand,fame_adoulin,fame_aby_konschtat,fame_jeuno,charid,rank_points,rank_sandoria,rank_bastok,rank_windurst,fame_sandoria,fame_bastok,fame_windurst,fame_norg
xidb;char_profile;fame_aby_attohwa,fame_aby_vunkerl,fame_aby_misareaux,fame_aby_latheine,fame_aby_altepa,fame_aby_grauberg,fame_aby_uleguerand,fame_adoulin,fame_holiday,unity_leader,fame_aby_tahrongi,fame_aby_konschtat,charid,rank_points,rank_sandoria,rank_bastok,rank_windurst,fame_sandoria,fame_bastok,fame_windurst,fame_norg,fame_jeuno
wingsdb;char_recast;recast,time,id,charid
xidb;char_recast;recast,time,id,charid
wingsdb;char_skills;rank,value,skillid,charid
xidb;char_skills;rank,value,skillid,charid
wingsdb;char_spells;charid,spellid
xidb;char_spells;charid,spellid
wingsdb;char_stats;search_message,bazaar_message,zoning,mlvl,slvl,pet_id,pet_type,pet_hp,pet_mp,seacom_type,title,charid,hp,mp,nameflags,mhflag,mjob,sjob,death,2h
xidb;char_stats;zoning,mlvl,slvl,pet_id,pet_type,pet_hp,pet_mp,pet_level,bazaar_message,title,2h,charid,hp,mp,nameflags,mhflag,mjob,sjob,death
wingsdb;char_storage;wardrobe4,wardrobe3,wardrobe2,wardrobe,case,sack,satchel,locker,safe,inventory,charid
xidb;char_storage;wardrobe3,wardrobe4,wardrobe5,wardrobe6,wardrobe7,wardrobe8,wardrobe2,wardrobe,case,charid,inventory,safe,locker,satchel,sack
wingsdb;char_style;ranged,sub,main,feet,legs,hands,body,head,charid
xidb;char_style;ranged,sub,main,feet,legs,hands,body,head,charid
wingsdb;char_unlocks;campaign_sandy,campaign_bastok,campaign_windy,homepoints,survivals,maw,runic_portal,mog_locker,outpost_windy,outpost_bastok,outpost_sandy,charid
xidb;char_unlocks;survivals,traverser_start,traverser_claimed,abyssea_conflux,waypoints,eschan_portals,claimed_deeds,unique_event,homepoints,campaign_windy,campaign_bastok,charid,outpost_sandy,outpost_bastok,outpost_windy,mog_locker,runic_portal,maw,campaign_sandy
wingsdb;char_vars;value,varname,charid
xidb;char_vars;expiry,value,varname,charid
wingsdb;delivery_box;sent,received,sender,senderid,extra,quantity,itemsubid,charid,charname,box,slot,itemid
xidb;delivery_box;received,sender,senderid,extra,quantity,itemsubid,itemid,slot,box,charname,charid,sent
"""

def replace_nth(sub,repl,txt,nth):
    arr=txt.split(sub)
    part1=sub.join(arr[:nth])
    part2=sub.join(arr[nth:])

    return part1+repl+part2


newCharID = '@NEWCHARID'
oldCharID = '@OLDCHARID'
sourceDB = 'WINGSDB'
destDB = 'XIDB'
tableCols = {}

for line in [line.upper().split(';') for line in results.splitlines() if line != '']:
    db = line[0]
    table = line[1]
    cols = line[2]

    if db not in tableCols.keys():
        tableCols[db] = {}
    tableCols[db][table] = cols.split(',')

print('SET @ACCID = <account_id>;')
print('SET @OLDCHARID = <charidFromWings>;')
print('SET @NEWCHARID = <newCharID>;')
for table in tableCols[sourceDB].keys():
    if table in tableCols[destDB].keys():
        matchingCols = [col for col in tableCols[sourceDB][table] if col in tableCols[destDB][table]]
        if 'CHARID' in matchingCols:
            matchingCols.remove('CHARID')
            sql = 'REPLACE INTO --NEWDB--.{0} (`CHARID`,{1}) \n SELECT @NEWCHARID as `CHARID`,{1} \n  FROM --OLDDB--.{0} WHERE charid = @OLDCHARID;'.format(table, ','.join(["`{}`".format(col) for col in matchingCols]))
            # for chars table, put the accid variable in place of old account id
            if table == 'CHARS':
                sql = replace_nth('`ACCID`', '@ACCID as `ACCID`', sql, 2)
            print(sql)
        else:
            print('-- {} is not a valid table, as it has no charid column'.format(table))
    else:
        print('-- {} is not in {}'.format(table, destDB))