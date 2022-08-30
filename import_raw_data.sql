-- Creating schema for raw data 
create schema if not exists ripa_raw;

-- NEED TO FIX STOP DETAILS AND STOP REASON

-- Create and populate stop_details
-- Had to delete '\' from rows 393149, and remove base date (1900-01-01) from time columns in 92 rows 
DROP TABLE IF EXISTS ripa_raw.raw_stop_details;
CREATE TABLE ripa_raw.raw_stop_details (
	stop_id INT,
    ori VARCHAR(255),
    agency VARCHAR(255),
    exp_years INT,
    date_stop DATE, 
    time_stop TIME, 
    stop_dur INT,
    cfs_response INT,
    officer_assignment_key INT, 
    assignment VARCHAR(255),
    intersection VARCHAR(255),
    address_block VARCHAR(255), 
    landmark VARCHAR(255),
    address_street VARCHAR(255),
    highway_exit VARCHAR(255),
    is_school VARCHAR(255), 
    school_name VARCHAR(255),
    address_city VARCHAR(255),
    beat INT,
    beat_name VARCHAR(255),
    pid INT,
    is_student INT,
    perceived_limited_english VARCHAR(255),
    perceived_age INT, 
    perceived_gender VARCHAR(255), 
    gender_nonconform varchar(255), 
    gend VARCHAR(255), 
    gend_nc VARCHAR(255), 
    perceived_lgbt VARCHAR(10)
);

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_stops_datasd.csv'
INTO TABLE ripa_raw.raw_stop_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

-- Create and populate stop_result
DROP TABLE IF EXISTS ripa_raw.import_stop_results;
CREATE TABLE ripa_raw.import_stop_results(
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    result_key INT NOT NULL, 
    result VARCHAR(255) NULL, 
    result_code VARCHAR(255) NULL, 
    result_text VARCHAR(255) NULL
);

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_stop_result_datasd.csv'
INTO TABLE ripa_raw.import_stop_results
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS ripa_raw.raw_stop_results;
CREATE TABLE ripa_raw.raw_stop_results AS 
SELECT i.stop_id,
    i.pid,
	i.result_key, 
    i.result,
    CAST(i.result_code AS FLOAT),
	i.result_text
FROM ripa_raw.import_stop_results i;

DROP TABLE IF EXISTS ripa_raw.import_stop_results

-- Create and populate actions_taken 
DROP TABLE IF EXISTS ripa_raw.raw_actions_taken;
CREATE TABLE ripa_raw.raw_actions_taken (
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    action_taken VARCHAR(255) NOT NULL,
    consented VARCHAR(255) NULL
);

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_actions_taken_datasd.csv'
INTO TABLE ripa_raw.raw_actions_taken
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Create and populate contraband 
DROP TABLE IF EXISTS ripa_raw.raw_contraband_found;
CREATE TABLE ripa_raw.raw_contraband_found ( 
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    contraband VARCHAR(255) NOT NULL
); 

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_contraband_evid_datasd.csv'
INTO TABLE ripa_raw.raw_contraband_found
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Create and populate basis_for_property_seizure 
DROP TABLE IF EXISTS ripa_raw.raw_basis_property;
CREATE TABLE ripa_raw.raw_basis_property ( 
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    basis_for_seizure VARCHAR(255) NULL
); 

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_prop_seize_basis_datasd.csv'
INTO TABLE ripa_raw.raw_basis_property
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Create and populate property_seized 
DROP TABLE IF EXISTS ripa_raw.raw_prop_seized;
CREATE TABLE ripa_raw.raw_prop_seized ( 
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    property_seized VARCHAR(255) NULL
);

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_prop_seize_type_datasd.csv' 
INTO TABLE ripa_raw.raw_prop_seized
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

-- Create and populate race 
DROP TABLE IF EXISTS ripa_raw.raw_race;
CREATE TABLE ripa_raw.raw_race (
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    race VARCHAR(30) NOT NULL
);

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_race_datasd.csv'
INTO TABLE ripa_raw.raw_race 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS; 

-- Create and populate search_basis 
DROP TABLE IF EXISTS ripa_raw.raw_search_basis;
CREATE TABLE ripa_raw.raw_search_basis (
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    search_basis VARCHAR(255) NULL,
    basis_explanation VARCHAR(255) NULL
);

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_search_basis_datasd.csv'
INTO TABLE ripa_raw.raw_search_basis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 


-- Create and populate stop_reason
-- Had to delete "\" from the end of each reason_explanation from row 91040, 217503, 572030, 572031, 572032, there are non-numeric data in reason_for_stopcode
DROP TABLE IF EXISTS ripa_raw.raw_stop_reason;
CREATE TABLE ripa_raw.raw_stop_reason (
	stop_id INT NULL,
    pid INT NULL, 
    reason VARCHAR(255) NULL, 
    reason_for_stopcode VARCHAR(255) NULL, 
    reason_text VARCHAR(255) NULL,
    reason_detail VARCHAR(255) NULL, 
    reason_explanation VARCHAR(255) NULL
); 

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_stop_reason_datasd.csv'
INTO TABLE ripa_raw.raw_stop_reason
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 


-- Create and populate stop_result 
DROP TABLE IF EXISTS ripa_raw.import_stop_results;
CREATE TABLE ripa_raw.import_stop_results ( 
	stop_id INT NOT NULL, 
    pid INT NOT NULL, 
    result_key INT NOT NULL, 
    result_text VARCHAR(255) NOT NULL, 
    result_code VARCHAR(255) NULL, 
    result_code_text VARCHAR(255) NULL
); 

LOAD DATA INFILE '/Users/chris/ML_projects/ripa_proj/ripa_stop_result_datasd.csv'
INTO TABLE ripa_raw.import_stop_results 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS ripa_raw.raw_stop_results;
CREATE TABLE ripa_raw.raw_stop_results AS 
SELECT 
	isr.stop_id,
    isr.pid,
    isr.result_key, 
    isr.result_text, 
    CAST(isr.result_code AS FLOAT), 
    isr.result_code_text 
FROM ripa_raw.import_stop_results isr;

DROP TABLE IF EXISTS ripa_raw.import_stop_results;