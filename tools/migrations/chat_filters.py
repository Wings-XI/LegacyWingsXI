import mariadb

def migration_name():
    return "Chat Filters"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # ensure chatfilterslo does not exist
    cur.execute("SHOW COLUMNS FROM `chars` LIKE 'chatfilters';")
    if not cur.fetchone():
        return True
    return False

def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE `chars` " \
            "ADD COLUMN `chatfilters` bigint(20) unsigned NOT NULL DEFAULT '0' AFTER `nnameflags`;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
