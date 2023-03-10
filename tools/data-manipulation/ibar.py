#!/usr/bin/python3
import mariadb
#from mariadb import Error, errorcode
import re

credentials = {}
db = cur = database = host = port = login = password = None

def connect():
    #print("Loading conf/map.conf")
    # Grab mysql credentials
    filename = "../../conf/map.conf"

    global credentials, db, cur, database, host, port, login, password

    with open(filename) as f:
        while True:
            line = f.readline()
            if not line: break
            match = re.match(r"(mysql_\w+):\s+(\S+)", line)
            if match:
                credentials[match.group(1)] = match.group(2)

    database = credentials["mysql_database"]
    host = credentials["mysql_host"]
    port = int(credentials["mysql_port"])
    login = credentials["mysql_login"]
    password = credentials["mysql_password"]

    try:
        db = mariadb.connect(host=host,
                user=login,
                passwd=password,
                db=database,
                port=port)
        cur = db.cursor()
    except mariadb.Error as err:
        print(err)
        close()
    #else:
        #print("Connected to database: " + database)

def close():
    if db:
        #print("Closing connection...")
        cur.close()
        db.close()

def all_mobs(cur):
    cur.execute('SELECT zoneid,name FROM zone_settings WHERE zoneport <> 0')
    zones = cur.fetchall()

    for zone in zones:
        id = zone[0]

        cur.execute('SELECT mobid,mobname,mJob,sJob,minlevel,maxlevel,behavior,aggro,detects,true_detection,links,mobtype & 2 = 2,spawntype,respawntime,\
                (SELECT group_concat(DISTINCT name) FROM mob_droplist as d LEFT JOIN item_basic i ON d.itemid = i.itemid WHERE d.dropId = mob_groups.dropid AND d.dropType IN (0,1) order by grouprate,itemrate),\
                (SELECT group_concat(DISTINCT sortname) FROM mob_droplist as d LEFT JOIN item_basic i ON d.itemid = i.itemid WHERE d.dropId = mob_groups.dropid AND d.dropType IN (2)),\
                slash,pierce,h2h,impact,fire,ice,wind,earth,lightning,water,light,dark\
                 FROM mob_spawn_points LEFT JOIN mob_groups ON mob_spawn_points.groupid = mob_groups.groupid AND mob_groups.zoneid = {0} left join mob_pools USING (poolid) left join mob_family_system USING (familyid) WHERE ((mobid >> 12) & 0xFFF) = {0} order by mobname'.format(id))
        rows = cur.fetchall()

        file = open("./ibar/data/{}.lua".format(id), "w")
        file.write('--[[\n')
        file.write(' *\tZone\t::\t{}\n'.format(zone[1]))
        file.write(' *\tZoneID\t::\t{}\n'.format(id))
        file.write(' *\tTotal\t::\t{}\n'.format(len(rows)))
        file.write(']]--\n')
        file.write('\tmb_data = {}\n')

        for count, row in enumerate(rows, 1):
            aggroList = ''
            aggro = int(0 if row[8] is None else row[8])
            if aggro & 1 == 1:
                aggroList = 'S' if aggroList == '' else aggroList + ',S'
            if aggro & 2 == 2:
                aggroList = 'H' if aggroList == '' else aggroList + ',H'

            if row[9] == 1:
                aggroList = "{}T({})".format('A,' if row[7] == 1 else '', aggroList)

            if aggro & 4 == 4:
                aggroList = aggroList + ',HP'
            if aggro & 0x20 == 0x20:
                aggroList = aggroList + ',M'
            if aggro & 0x40 == 0x40:
                aggroList = aggroList + ',WS'
            if aggro & 0x80 == 0x80:
                aggroList = aggroList + ',JA'
            if aggro & 0x100 == 0x100:
                aggroList = aggroList + ',SC'

            phys = {16:'Slash',17:'Pierce',18:'H2H',19:'Blunt'}
            mag = {20:'Fire',21:'Ice',22:'Wind',23:'Earth',24:'Lightning',25:'Water',26:'Light',27:'Dark'}
            weakResult = {}
            strongResult = {}

            weakPhys = { phys[i]: abs(row[i]-1) for i in range(16, 20) if (type(row[i]) == float and row[i] > 1) }
            weakPhys: list[tuple] = sorted(weakPhys.items(), key=lambda x:x[1], reverse=True)
            
            weakMag = { mag[i]: abs(row[i]-1) for i in range(20, 28) if type(row[i]) == float and row[i] > 1 }
            weakMag: list[tuple] = sorted(weakMag.items(), key=lambda x:x[1], reverse=True)
            
            weakDict = dict(weakPhys + weakMag)

            for val in weakDict.values():
                weakResult[val] = [x for x in weakDict.keys() if weakDict[x] == val]

            strongPhys = { phys[i]: abs(row[i]-1) for i in range(16, 20) if (type(row[i]) == float and row[i] < 1) }
            strongPhys: list[tuple] = sorted(strongPhys.items(), key=lambda x:x[1], reverse=True)

            strongMag = { mag[i]: abs(row[i]-1) for i in range(20, 28) if type(row[i]) == float and row[i] < 1 }
            strongMag: list[tuple] = sorted(strongMag.items(), key=lambda x:x[1], reverse=True)
            
            strongDict = dict(strongPhys + strongMag)

            for val in strongDict.values():
                strongResult[val] = [x for x in strongDict.keys() if strongDict[x] == val]

            ## add one back for final output
            weak: list[str] = [f'{"/".join(value)}: {float(round(keylist + 1, 3))}' for keylist, value in weakResult.items()]
            strong: list[str] = [f'{"/".join(value)}: {float(round(keylist + 1, 3))}' for keylist, value in strongResult.items()]

            drops = '' if row[14] is None else row[14].replace('_',' ')
            steal = '' if row[15] is None else row[15].replace('_',' ')

            dropList = []
            previousSplit = ''
            currItem = ''
            lineLength = 0
            for item in drops.split(','):
                splitChar = ' '
                tempSplit = item.split('-')
                if tempSplit[0] in ['scroll of absorb','scroll of gain','scroll of boost']:
                    splitChar = tempSplit[0].split(' ')[2] + '-'
                elif item.split(' ', maxsplit=1)[0] in ['scroll']:
                    splitChar = ' of '
                listItem = item.split(splitChar, maxsplit=1)
                if listItem[0] != previousSplit:
                    if currItem != '':
                        dropList.append(currItem)
                    previousSplit = listItem[0]
                    currItem = previousSplit
                    lineLength += len(currItem + splitChar)
                itemAdd = ('/' if currItem != previousSplit else ('' if len(listItem) == 1 else splitChar)) + ('' if len(listItem) == 1 else '' + listItem[1])
                if lineLength + len(itemAdd) > 250:
                    itemAdd = '\\n' + itemAdd
                    lineLength = len(itemAdd)
                else:
                    lineLength += len(itemAdd)
                currItem += itemAdd

            dropList.append(currItem)

            file.write('\tmb_data[{}] = {{ nm="{}", id="{}", name="{}", mj="{}", sj="{}", mlvl="{}-{}", behavior="{}", aggro="{}", links="{}", spawntype="{}", respawntime="{}", items="{}", steal="{}", weak="{}", strong="{}", note="" }}\n'.format(
                    count,                          # row
                    'Y' if row[11] == 1 else 'N',   # NM?
                    row[0],                         # id
                    row[1],                         # name
                    row[2],                         # Main Job
                    row[3],                         # Sub Job
                    row[4],                         # Main level
                    row[5],                         # Sub level
                    row[6],                         # Behavior
                    aggroList,                      # Aggro?
                    'Y' if row[10] == 1 else 'N',   # Links?
                    row[12],                        # Spawn type
                    row[13],                        # Respawn time
                    ','.join(dropList),             # Drop list
                    steal,                          # Steal list
                    ', '.join(weak),                 # Weak to list
                    ', '.join(strong),               # Strong to list
                    )
                )

        file.write("\treturn mb_data;\n")
        file.close()

def main():
    connect()
    all_mobs(cur)
    close()


if __name__ == "__main__":
    main()
