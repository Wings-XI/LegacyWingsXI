import array
import mariadb

def migration_name():
    return "Adding zoneid column for audit_gm"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure column doesn't already exist.
    cur.execute("SHOW COLUMNS FROM audit_gm LIKE 'zoneid';")

    row = cur.fetchone()
    # check if zoneid is proper type (originally implemented with wrong type)
    if row and 'smallint' in row[1]:
        return False

    return True

def migrate(cur, db):
    cur.execute("SHOW COLUMNS FROM audit_gm LIKE 'zoneid';")

    row = cur.fetchone()
    if row:
        cur.execute("ALTER TABLE `audit_gm` MODIFY COLUMN zoneid smallint(3) UNSIGNED NOT NULL DEFAULT 0;")
    else:
        cur.execute("ALTER TABLE `audit_gm` ADD COLUMN zoneid smallint(3) UNSIGNED NOT NULL DEFAULT 0;")
    db.commit()

