import mariadb

def migration_name():
    return "Battlefield Record History"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # ensure chatfilterslo does not exist
    cur.execute("SHOW COLUMNS FROM `bcnm_info` LIKE 'previousTime';")
    if not cur.fetchone():
        return True
    return False

def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE `bcnm_info` RENAME COLUMN `fastestName` to `previousName`; ")
        cur.execute("ALTER TABLE `bcnm_info` RENAME COLUMN `fastestPartySize` to `previousPartySize`; ")
        cur.execute("ALTER TABLE `bcnm_info` RENAME COLUMN `fastestTime` to `previousTime`; ")
        cur.execute("ALTER TABLE `bcnm_info` ADD COLUMN `fastestName` varchar(15) DEFAULT 'Not Set!' AFTER `name`; ")
        cur.execute("ALTER TABLE `bcnm_info` ADD COLUMN `fastestPartySize` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 AFTER `fastestName`; ")
        cur.execute("ALTER TABLE `bcnm_info` ADD COLUMN `fastestTime` int(10) UNSIGNED DEFAULT 1 AFTER `fastestPartySize`; ")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
