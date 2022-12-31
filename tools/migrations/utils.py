import re
import mariadb

dbname = None

hex2bin = {
    "0" : "0000",
    "1" : "0001",
    "2" : "0010",
    "3" : "0011",
    "4" : "0100",
    "5" : "0101",
    "6" : "0110",
    "7" : "0111",
    "8" : "1000",
    "9" : "1001",
    "A" : "1010",
    "B" : "1011",
    "C" : "1100",
    "D" : "1101",
    "E" : "1110",
    "F" : "1111"
}

def blob_to_binary(blob):
    # Split hex string into pairs of two
    split_spells = re.findall('..', blob)

    for index, item in enumerate(split_spells):
        # reverse each pair of hexes
        reversed_hex = item[::-1]

        # replace hex val with binary value
        split_spells[index] = ""
        for hex in reversed_hex:
            # Reverse binary val
            split_spells[index] += hex2bin[hex][::-1]

    # print(split_spells)

    # Join everything together in one big 1/0 string
    return "".join(split_spells)


def read_login_conf():
	global dbname
	dbname = None
	try:
		with open("../conf/login.conf") as f:
			while True:
				line = f.readline()
				if not line: break
				match = re.match(r'^\s*db_database\s*=\s*(\S+)', line)
				if match:
					dbname = match.group(1)
		if dbname == None:
			print('Error fetching login database.\nCheck ../conf/login.conf.\n')
	except err:
		print('Error fetching login database from ../conf/login.conf: {}\n'.format(err))

def login_dbname():
	global dbname
	if dbname == None:
		read_login_conf()
	return dbname

def run_login_sql_file(file, cur):
	logindb = login_dbname()
	try:
		with open(file, "r") as sqlfile:
			cur.execute("select database()")
			dbname = cur.fetchone()

			# run the sql on the login database
			sql = sqlfile.read()
			cur.execute("use {}".format(logindb))
			for result in cur.execute(sql, multi=True):
				pass # iterate through all the statements in the file

			# switch back to normal database
			cur.execute("use {}".format(dbname[0]))
	except mariadb.Error as err:
		print("Something went wrong with file {}: {}".format(file, err))
