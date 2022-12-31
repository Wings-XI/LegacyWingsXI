import mariadb
from migrations import utils

# Database change:
# -  `ip_exempt` tinyint(4) NOT NULL DEFAULT 0
# +  `ip_exempt` smallint(3) unsigned NOT NULL DEFAULT 0

def migration_name():
	return "Changing ip_exempt column type"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	dbname = utils.login_dbname()
	cur.execute("SHOW COLUMNS FROM {}.accounts LIKE 'ip_exempt'".format(dbname))
	row = cur.fetchone()
	return row[1] == "tinyint(4)"

def migrate(cur, db):
	dbname = utils.login_dbname()
	try:
		cur.execute("ALTER TABLE {}.accounts MODIFY COLUMN `ip_exempt` smallint(3) unsigned NOT NULL DEFAULT 0".format(dbname))
		db.commit()
	except mariadb.Error as err:
		print("Something went wrong: {}".format(err))
