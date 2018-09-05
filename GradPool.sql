--
--  Simple data store for the GradPool database
--  More relations and complexity to be added as required
--  Using SQLITE3 as backend datastore
--
--  Most items, including dates, to be stored as TEXT
--  php can sort out type conversion where necessary.
--

-- TABLE: system
--
-- Effectively a table of key/value pairs for app configuration
-- No relations with other tables.
--
-- One column indicates the name of config item
-- Another indicates which column contains the relevant data
-- e.g. 
--     key_name=DATABASE_VERSION might have a data_type of "0"
--     and a string_value of "0.00 alpha"  
--     all other columns would be empty
--
DROP TABLE IF EXISTS system;
CREATE TABLE system (
	config_id INTEGER PRIMARY KEY,
	key_name TEXT NOT NULL,
	data_type INTEGER NOT NULL,	-- range = 0..3
					-- 0 = string, 1 = int
					-- 2 = date, 3 = real
	string_value TEXT,
	integer_value INTEGER,
	date_value TEXT,
	real_value REAL
	);

-- TABLE: people
-- 
-- All people in the system are referenced by this table
-- whether admin, staff, student, or employer.
DROP TABLE IF EXISTS people;
CREATE TABLE people (
	key INTEGER PRIMARY KEY,
	role INTEGER NOT NULL,	-- range = 0..3 
				-- 0 = admin, 1 = staff
				-- 2 = student, 3 = employer
	family_name TEXT NOT NULL,
	initial TEXT,
	given_name TEXT NOT NULL,
	id TEXT,
	phone TEXT,
	email TEXT,
	school TEXT, -- Could be a foreign key
	company TEXT,
	passwd_hash TEXT
      	);

-- TABLE: resumes
--
-- The resume files uploaded by students
-- 
DROP TABLE IF EXISTS resumes;
CREATE TABLE resumes (
	key INTEGER PRIMARY KEY,
	filename TEXT,
	student_id TEXT,
	FOREIGN KEY (student_id) 
	REFERENCES people(id)	ON UPDATE CASCADE
				ON DELETE CASCADE);
