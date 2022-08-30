-- EDA of Stop Details
SELECT * 
FROM ripa_raw.raw_stop_details
limit 100;

-- Can drop these ori and agency because only 1 distinct value in each 
SELECT COUNT(DISTINCT ori), COUNT(DISTINCT agency)
FROM ripa_raw.raw_stop_details;

-- Years: Officers with 1-5 years of experience tend to make the most stops
SELECT exp_years, COUNT(*) 
FROM ripa_raw.raw_stop_details 
GROUP BY exp_years
ORDER BY COUNT(*) DESC;

-- Max years experience is 50, does only investigative/detective work 
SELECT MAX(exp_years)
FROM ripa_raw.raw_stop_details;

SELECT *
FROM ripa_raw.raw_stop_details
WHERE exp_years = 50;

-- Date stop: 
-- 89,485 stops in 2018, 187,251 stops in 2019, 150,619 stops in 2020, 102,260 stops in 2021 (See a dip after COVID, 2018 low because started in July, last date is Sep 30, 2021)
-- 43,839 stops in Jan, 39,957 stops in Feb, 41,827 stops in Mar, 39,421 stops in Apr, 40,545 stops in May, 33,946 stops in Jun, 56,844 stops in Jul, 
-- 56,157 stops in Aug, 52,409 stops in Sep, 45,345 stops in Oct, 40,519 stops in Nov, 38,806 stops in Dec
-- Consider day of week with type of stop 
SELECT LEFT(date_stop, 4), COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1;

SELECT MIN(date_stop), MAX(date_stop)
FROM ripa_raw.raw_stop_details;

SELECT RIGHT(LEFT(date_stop, 7),2), COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1
ORDER BY 1 ASC;

-- Time stop
SELECT LEFT(time_stop, 2), COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1
ORDER BY 1 ASC;

-- Stop duration: 371 UNIQUE VALUES 
SELECT COUNT(DISTINCT stop_dur)
FROM ripa_raw.raw_stop_details ;

-- CFS response (response to call for service) binary 
SELECT DISTINCT cfs_response
FROM ripa_raw.raw_stop_details;

-- Officer Assignment: 10 unique assignments by decreasing occurances: patrol/traffic enforcement/field operations, other, gang enforcement, investigative/detective, 
-- task force, roadblock or DUI checkpt, narcotics/vice, special events, k1-12 public schools, compliance check 
SELECT assignment, COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1
ORDER BY 2 DESC;

-- Street: 31791 distinct streets 
SELECT COUNT(DISTINCT address_street)
FROM ripa_raw.raw_stop_details;

-- is_school: binary, 431 arrests at a school (less than officers assigned to schools) 
SELECT DISTINCT is_school
FROM ripa_raw.raw_stop_details;

SELECT is_school, COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1;

-- City: 58 unique values 
-- Top 5: San Diego, San Ysidro, Chula Vista, National City, El Cajon 
-- Are these proportional to city populations? 
SELECT COUNT(DISTINCT address_city)
FROM ripa_raw.raw_stop_details ;

SELECT address_city, COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1
ORDER BY 2 DESC;

-- Beat: 126 unique values 
-- Top 5: East village, Pacific Beach, Midway District, Core-Columbia, Ocean Beach
SELECT COUNT(DISTINCT beat)
FROM ripa_raw.raw_stop_details;

SELECT beat_name, COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- is_student: Binary, 235 students stopped  
SELECT is_student, COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1; 

-- perceived_limited_english: Binary, 11,307 stops perceived limited english 
SELECT perceived_limited_english, COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1;

-- perceived_gender: 5 Values: male (386,052), female (142,006), trans W (638), trans M (767), null (152) 
SELECT perceived_gender, COUNT(*)
FROM ripa_raw.raw_stop_details 
GROUP BY 1;

