#!/usr/bin/python3
import mariadb
#from mariadb import Error, errorcode
import re

zones = {
39:"Dynamis-Valkurm",
40:"Dynamis-Buburimu",
41:"Dynamis-Qufim",
42:"Dynamis-Tavnazia",
134:"Dynamis-Beaucedine",
135:"Dynamis-Xarcabard",
185:"Dynamis-San_dOria",
186:"Dynamis-Bastok",
187:"Dynamis-Windurst",
188:"Dynamis-Jeuno",
}
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
    print("ObjectList = {")
    for id in zones:
        print('\t[{}] ='.format(id))
        print('\t{{ -- {}'.format(zones[id]))

        cur.execute('SELECT mobid,mobname FROM mob_spawn_points WHERE ((mobid >> 12) & 0xFFF) = {}'.format(id))
        rows = cur.fetchall()

        for row in rows:
            print('\t\t{{{}, "{}"}},'.format(row[0], row[1].replace('_',' ')))
        print("\t},")
    print("}")

def main():
    connect()
    all_mobs(cur)
    close()


if __name__ == "__main__":
    main()

