-- Creating analysis schema and tables
CREATE SCHEMA IF NOT EXISTS ripa_analysis;

-- Table for all stop details including time, duration, officer details, location, actions taken, reason for action, and stop results 
DROP TABLE IF EXISTS ripa_analysis.stops; 
CREATE TABLE ripa_analysis.stops AS 
SELECT 
	sr.stop_id, 
    sr.pid, 
    sr.date_stop,
    sr.time_stop, 
    sr.stop_dur, 
    sr.exp_years,
    sr.cfs_response,
    sr.assignment, 
    sr.address_street,
    sr.address_city, 
    sr.beat_name,
    a_t.action_taken,
    a_t.consented,
    sre.reason, 
    sre.reason_for_stopcode, 
    sre.reason_text, 
    sre.reason_detail, 
    sre.reason_explanation,
    result.result_text, 
    result.result_code_text
FROM ripa_raw.raw_stop_details AS sr
JOIN ripa_raw.raw_actions_taken AS a_t 
	ON sr.stop_id=a_t.stop_id AND sr.pid=a_t.pid
JOIN ripa_raw.raw_stop_reason AS sre 
	ON sr.stop_id=sre.stop_id AND sr.pid=sre.pid
JOIN ripa_raw.raw_stop_results AS result
	ON sr.stop_id=result.stop_id AND sr.pid=result.pid;


-- Table for all personal details including race, perceived limit english, perceived age, perceived gender, gender nonconform, perceived_lgbt 
DROP TABLE IF EXISTS ripa_analysis.person_info;
CREATE TABLE ripa_analysis.person_info AS 
SELECT 
	sd.stop_id, 
    sd.pid, 
    race.race,
    sd.perceived_limited_english,
    sd.perceived_age,
    sd.perceived_gender,
    sd.gender_nonconform,
    sd.perceived_lgbt
FROM ripa_raw.raw_stop_details AS sd
JOIN ripa_raw.raw_race AS race 
	ON sd.stop_id=race.stop_id AND sd.pid=race.pid;

-- Table for search and contraband/evidence found
DROP TABLE IF EXISTS ripa_analysis.search_evidence;
CREATE TABLE ripa_analysis.search_evidence AS 
SELECT
	sb.stop_id, 
    sb.pid, 
    sb.search_basis,
    sb.basis_explanation,
    contra.contraband,
    seize.basis_for_seizure
FROM ripa_raw.raw_search_basis AS sb 
JOIN ripa_raw.raw_contraband_found AS contra 
	ON sb.stop_id=contra.stop_id AND sb.pid=contra.pid
JOIN ripa_raw.raw_basis_property AS seize
	ON sb.stop_id=seize.stop_id AND sb.pid=seize.pid;