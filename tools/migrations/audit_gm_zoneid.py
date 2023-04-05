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
    if row:
        return False

    return True

def migrate(cur, db):
    cur.execute("ALTER TABLE `audit_gm` ADD COLUMN zoneid tinyint(3) UNSIGNED NOT NULL DEFAULT 0;")
    db.commit()

