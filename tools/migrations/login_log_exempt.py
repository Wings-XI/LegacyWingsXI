import mariadb
from migrations import utils

def migration_name():
	return "Adding exempt column to login log"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	dbname = utils.login_dbname()
	cur.execute("SHOW COLUMNS FROM {}.login_log LIKE 'exempt'".format(dbname))
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	dbname = utils.login_dbname()
	try:
		cur.execute("ALTER TABLE {}.login_log ADD COLUMN `exempt` tinyint(3) unsigned NOT NULL DEFAULT '0'".format(dbname))
		db.commit()
	except mariadb.Error as err:
		print("Something went wrong: {}".format(err))
