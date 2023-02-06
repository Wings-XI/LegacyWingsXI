import mariadb
from migrations import utils

def migration_name():
	return "Adding temporary IP exception column to login accounts table"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	dbname = utils.login_dbname()
	cur.execute("SHOW COLUMNS FROM {}.accounts LIKE 'temp_exempt'".format(dbname))
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	dbname = utils.login_dbname()
	try:
		cur.execute("ALTER TABLE {}.accounts ADD COLUMN `temp_exempt` datetime DEFAULT NULL".format(dbname))
		db.commit()
	except mariadb.Error as err:
		print("Something went wrong: {}".format(err))
