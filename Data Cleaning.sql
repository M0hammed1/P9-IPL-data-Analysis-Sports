CREATE DATABASE ipl_data; -- or use -> CREATE DATABASE if not exists ipl_data;
USE ipl_data;

-- Disable safe updates mode to allow updates without specifying a key in the WHERE clause
SET sql_safe_updates = 0;
-- Handling Missing Values (Example: Setting 'city' to 'Unknown' where it's NULL)
UPDATE ipl_matches
SET city = 'Unknown'
WHERE city IS NULL;

-- Data Type Corrections (Assuming they are correctly formatted from the import process)
ALTER TABLE ipl_matches MODIFY COLUMN date DATE;
DESCRIBE ipl_matches;
SELECT * FROM ipl_matches;

-- Removing Duplicates (Example: Ensuring no duplicate matches based on a unique ID)
-- Note: This step is generally handled during data preparation before import. => Already DONE. 
-- or we can do that using this code -> DELETE t1 FROM matches t1 INNER JOIN matches t2 WHERE t1.id < t2.id AND t1.team1 = t2.team1 AND t1.team2 = t2.team2 AND t1.date = t2.date;

-- Standardizing Team Names (Example: Updating team names to their latest ones) : we can use the code below but it's better to work with current teams names to not corrupt data and results.
-- UPDATE ipl_matches SET team1 = 'Delhi Capitals' WHERE team1 = 'Delhi Daredevils'; UPDATE ipl_matches SET team2 = 'Delhi Capitals' WHERE team2 = 'Delhi Daredevils';

-- Filtering Irrelevant Matches (Example: Removing matches without a result) using code bellow but we can check first if there are result is NULL using second line of code (select from where) and we found that no such result exist so no need to this step
-- DELETE FROM ipl_matches WHERE result IS NULL;
-- SELECT * FROM ipl_matches WHERE result IS NULL;
