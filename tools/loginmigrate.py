#!/usr/bin/env python3

"""loginmigrate.py
Migrate existing userbase from old to new login server
Author: Twilight
License: GPLv3
"""

import sys
import mysql
import mariadb

MAP_HOST = "127.0.0.1"
MAP_USER = "topaz"
MAP_PASS = "topaz"
MAP_DB = "topaz"
LOGIN_HOST = "127.0.0.1"
LOGIN_USER = "topaz"
LOGIN_PASS = "topaz"
LOGIN_DB = "topaz_login"
LOGIN_PREFIX = ""
WORLD_ID = 100

def add_content_ids(dbcon, accid, numids):
    dbcur = dbcon.cursor()
    for i in range(numids):
        content_query = "INSERT INTO %scontents (account_id, enabled) VALUES (%d, 1)" % (LOGIN_PREFIX, accid)
        print(content_query)
        dbcur.execute(content_query)
        dbcur.execute("COMMIT")
    dbcur.close()
    
def get_free_content_id(dbcon, accid):
    dbcur = dbcon.cursor()
    query = "SELECT MIN(content_id) FROM %scontents WHERE content_id NOT IN (SELECT content_id FROM %schars) AND account_id = %d" % (LOGIN_PREFIX, LOGIN_PREFIX, accid)
    dbcur.execute(query)
    row = dbcur.fetchone()
    if not row:
        raise RuntimeError("No free content ID found")
    content_id = row[0]
    dbcur.close()
    return content_id

def migrate_accounts(map_con, login_con):
    map_cur = map_con.cursor()
    login_cur = login_con.cursor()
    login_cur.execute("TRUNCATE TABLE %saccounts" % LOGIN_PREFIX)
    login_cur.execute("TRUNCATE TABLE %scontents" % LOGIN_PREFIX)
    map_cur.execute("SELECT id, login, current_email, timecreate, timelastmodify, content_ids, expansions, features, status, priv FROM accounts")
    row = map_cur.fetchone()
    while row:
        priv = 1 if row[8] == 1 else 0
        username_esc = login_con.converter.escape(row[1])
        email_esc = login_con.converter.escape(row[2])
        print(str(row[2]))
        timecreate_esc = login_con.converter.escape(row[3].strftime('%Y-%m-%d %H:%M:%S'))
        timemodified_esc = login_con.converter.escape(row[4].strftime('%Y-%m-%d %H:%M:%S'))
        login_query = "INSERT INTO %saccounts (id, username, password, salt, email, timecreated, timemodified, expansions, features, privileges) VALUES (%d, '%s', '', '', '%s', '%s', '%s', %d, %d, %d)" % \
        (LOGIN_PREFIX, row[0], username_esc, email_esc, timecreate_esc, timemodified_esc, row[6], row[7], priv)
        print(login_query)
        login_cur.execute(login_query)
        login_cur.execute("COMMIT")
        add_content_ids(login_con, row[0], row[5])
        row = map_cur.fetchone()
    login_cur.close()
    map_cur.close()
    
def update_char_content_id(map_con, login_con, world_id):
    map_cur = map_con.cursor()
    login_cur = login_con.cursor()
    login_query = "SELECT content_id, character_id FROM %schars WHERE world_id = %d" % (LOGIN_PREFIX, world_id)
    login_cur.execute(login_query)
    row = login_cur.fetchone()
    while row:
        map_query = "UPDATE chars SET content_id=%d WHERE charid=%d" % (row[0], row[1])
        map_cur.execute(map_query)
        map_cur.execute("COMMIT")
        row = login_cur.fetchone()
    login_cur.close()
    map_cur.close()

def migrate_chars(map_con, login_con, world_id):
    map_cur = map_con.cursor()
    login_cur = login_con.cursor()
    map_query = "SELECT chars.charid, accid, charname, goldworldpass, mjob, mlvl, pos_zone, race, face, head, body, hands, legs, feet, main, sub, size, nation FROM chars, char_stats, char_look WHERE char_stats.charid = chars.charid AND char_look.charid = chars.charid"
    map_cur.execute(map_query)
    row = map_cur.fetchone()
    while row:
        new_content_id = get_free_content_id(login_con, row[1])
        charname_esc = login_con.converter.escape(row[2])
        if row[3]:
            gwp_esc = login_con.converter.escape(row[3])
        else:
            gwp_esc = ""
        login_query = "INSERT INTO %schars (content_id, character_id, name, world_id, goldworldpass, main_job, main_job_lv, zone, race, face, hair, head, body, hands, legs, feet, main, sub, size, nation) VALUES (%d, %d, '%s', %d, '%s', %d, %d, %d, %d, %d, 0, %d, %d, %d, %d, %d, %d, %d, %d, %d)" % \
        (LOGIN_PREFIX, new_content_id, row[0], charname_esc, world_id, gwp_esc, row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13], row[14], row[15], row[16], row[17])
        print(login_query)
        login_cur.execute(login_query)
        login_cur.execute("COMMIT")
        row = map_cur.fetchone()
    login_cur.close()
    map_cur.close()

def main(argv):
    map_con = mariadb.connect(host=MAP_HOST, user=MAP_USER, password=MAP_PASS, database=MAP_DB)
    login_con = mariadb.connect(host=LOGIN_HOST, user=LOGIN_USER, password=LOGIN_PASS, database=LOGIN_DB)
    migrate_accounts(map_con, login_con)
    migrate_chars(map_con, login_con, WORLD_ID)
    update_char_content_id(map_con, login_con, WORLD_ID)
    login_con.close()
    map_con.close()


if __name__ == "__main__":
    main(sys.argv)
