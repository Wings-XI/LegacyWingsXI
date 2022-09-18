import mysql.connector
from migrations import utils

def migration_name():
	return "Adding OTP secret column to login accounts table"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	dbname = utils.login_dbname()
	cur.execute("SHOW COLUMNS FROM {}.accounts LIKE 'otp_secret'".format(dbname))
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	dbname = utils.login_dbname()
	try:
		cur.execute("ALTER TABLE {}.accounts ADD COLUMN `otp_secret` varchar(64) DEFAULT NULL".format(dbname))
		db.commit()
	except mysql.connector.Error as err:
		print("Something went wrong: {}".format(err))
