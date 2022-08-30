-- Actions taken EDA 
SELECT *
FROM ripa_raw.raw_actions_taken 
LIMIT 10;

-- Action taken: 24 distinct values 
-- Top 5: None (371,234), hand/flex cuffed (162,556), search of person (112,575), curbside detention (85,932), patrol car detention (60,589) 
SELECT action_taken, COUNT(*)
FROM ripa_raw.raw_actions_taken 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Consented: Null (932,125), Yes (20,142), No (3576)
SELECT consented, COUNT(*)
FROM ripa_raw.raw_actions_taken 
GROUP BY 1;

-- Race EDA: 7 groups 
-- In descending order: white, hispanic/latino/a, black/african american, asian, middle eastern or south asian, pacific islander, native american 
SELECT race, COUNT(*)
FROM ripa_raw.raw_race
GROUP BY 1
ORDER BY 2 DESC;

-- Stop result EDA: 13 distinct values
-- Top 5: Citation for infraction (162,531), Field interview card completed (126,291), Warning (121,476), no action (78,681), Custodial arrest without warrant (68,238) 
SELECT * 
FROM ripa_raw.raw_stop_results
limit 5;
 
SELECT COUNT(DISTINCT result_text)
FROM ripa_raw.raw_stop_results;

SELECT result_text, COUNT(*)
FROM ripa_raw.raw_stop_results
GROUP BY 1
ORDER BY 2 DESC;

-- Stop reason EDA: 8 distinct reasons
-- Top 3: reasonable suspicion (325,018), traffic violation (274,055), investigation to determine truant (8,162)
-- stop reason detail: 16 distinct
-- Top 3: moving violation (172,808), witnessed crime (124,196), matched suspect description (114,827)
-- are matched suspect description all cfs? 
SELECT * 
FROM ripa_raw.raw_stop_reason
LIMIT 10;

SELECT COUNT(DISTINCT reason)
FROM ripa_raw.raw_stop_reason;

SELECT reason, COUNT(*)
FROM ripa_raw.raw_stop_reason
GROUP BY 1
ORDER BY 2 DESC;

SELECT COUNT(DISTINCT reason_detail)
FROM ripa_raw.raw_stop_reason;

SELECT reason_detail, COUNT(*)
from ripa_raw.raw_stop_reason
GROUP BY 1
ORDER BY 2 DESC;


-- search basis: 14 distinct values
-- Top 5: Null (481,016), incident to arrest (70,326), condition of parole/probation (36,127), consent given (13,175), officer safety/safety of others (11,571) 
SELECT *
FROM ripa_raw.raw_search_basis
LIMIT 10;

SELECT COUNT(DISTINCT search_basis)
FROM ripa_raw.raw_search_basis;

SELECT search_basis, COUNT(*)
FROM ripa_raw.raw_search_basis
GROUP BY 1
ORDER BY 2 DESC;

