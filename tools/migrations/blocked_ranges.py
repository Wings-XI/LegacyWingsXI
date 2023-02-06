import mariadb
from migrations import utils

def migration_name():
	return "Creating blocked_ranges tables"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	logindb = utils.login_dbname()
	try:
		cur.execute("show columns from {}.blocked_ranges like 'network_address'".format(logindb))
		cur.fetchone()
		return False
	except mariadb.Error as err:
		if err.errno == errorcode.ER_NO_SUCH_TABLE:
			return True
		else:
			print("Something went wrong checking for the blocked_ranges table: {}".format(err))
		return False

def migrate(cur, db):
    utils.run_login_sql_file("../sql-login/blocked_ranges.sql", cur)
