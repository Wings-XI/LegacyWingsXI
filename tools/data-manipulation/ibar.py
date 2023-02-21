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

        cur.execute('SELECT mobid,mobname,mJob,sJob,minlevel,maxlevel,behavior,aggro,detects,true_detection,links,mobtype & 2 = 2,spawntype FROM mob_spawn_points LEFT JOIN mob_groups ON mob_spawn_points.groupid = mob_groups.groupid AND mob_groups.zoneid = {0} left join mob_pools USING (poolid) left join mob_family_system USING (familyid) WHERE ((mobid >> 12) & 0xFFF) = {0}'.format(id))
        rows = cur.fetchall()

        file = open("./ibar/data/{}.lua".format(id), "w")
        file.write('--[[\n')
        file.write(' *\tZone\t::\t{}\n'.format(zone[1]))
        file.write(' *\tZoneID\t::\t{}\n'.format(id))
        file.write(' *\tTotal\t::\t{}\n'.format(len(rows)))
        file.write(']]--\n')
        file.write('\tmb_data = {}\n')
        count = 1
        for row in rows:
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

            file.write('\tmb_data[{}] = {{ nm="{}", id="{}", name="{}", mj="{}", sj="{}", mlvl="{}-{}", behavior="{}", aggro="{}", links="{}", spawntype="{}", weak="{}", note="" }}\n'.format(
                    count, 'Y' if row[11] == 1 else 'N', row[0], row[1], row[2], row[3], row[4], row[5], row[6], aggroList, 'Y' if row[10] == 1 else 'N', row[12], '???'))
            count = count + 1
        file.write("\treturn mb_data;\n")
        file.close()

def main():
    connect()
    all_mobs(cur)
    close()


if __name__ == "__main__":
    main()

