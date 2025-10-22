SELECT * FROM virus_db.corona_virus;
--  CHECK NULL
SELECT * FROM virus_db.corona_virus
WHERE   `Deaths` IS NULL 
		OR `Confirmed` IS NULL
        OR `Recovered` IS NULL
        OR `Latitude` IS NULL
        OR `Longitude` IS NULL
        OR `Date` IS NULL
        OR `Province` IS NULL
        OR `Country/Region` IS NULL;
        
-- CHECK TOTEL COLUMN NUMBER
SELECT COUNT(*) FROM virus_db.corona_virus;
SELECT COUNT(DISTINCT `Province`) FROM virus_db.corona_virus;

-- CHECK WHAT IS START DATE && END DATE
SELECT MIN(`Date`) start_date, MAX(`Date`) end_date FROM virus_db.corona_virus;

UPDATE virus_db.corona_virus
SET `Date` = STR_TO_DATE(`Date`, '%d-%m-%Y');

ALTER TABLE virus_db.corona_virus MODIFY COLUMN `Date` DATE;


-- CHEKE NUMBER OF MONTH PRESENT IN DATASET
SELECT COUNT(DISTINCT DATE_FORMAT(`Date`, '%Y-%m')) `MONTH` FROM virus_db.corona_virus;

-- FIND MONTHLY AVG FOR CONFIRMED, DEATHS, RECOVERED

SELECT DISTINCT DATE_FORMAT(`Date`, '%Y-%m') `MONTH`,     
AVG(`Confirmed`) AS Avg_Confirmed,
AVG(`Deaths`) AS Avg_Deaths,
AVG(`Recovered`) AS Avg_Recovered FROM virus_db.corona_virus
GROUP BY `MONTH`
ORDER BY `MONTH` DESC;

-- FIND MINIMUM VALUES FOR CONFIRMED, DEATHS, RECOVERED PER YEAR

SELECT 
    DISTINCT YEAR(`Date`) AS `Year`,
    MIN(`Confirmed`) AS Min_Confirmed,
    MIN(`Deaths`) AS Min_Deaths,
    MIN(`Recovered`) AS Min_Recovered
FROM virus_db.corona_virus
WHERE `Confirmed` != 0 
   AND `Deaths` != 0 
   AND `Recovered` != 0
GROUP BY `Year`
ORDER BY `Year` DESC;


-- FIND MAXIMUM VALUES OF CONFIRMED, DEATHS, RECOVERED PER YEAR

SELECT 
    DISTINCT YEAR(`Date`) AS `Year`,
    MAX(`Confirmed`) AS Max_Confirmed,
    MAX(`Deaths`) AS Max_Deaths,
    MAX(`Recovered`) AS Max_Recovered
FROM virus_db.corona_virus
WHERE `Confirmed` != 0 
   AND `Deaths` != 0 
   AND `Recovered` != 0
GROUP BY `Year`
ORDER BY `Year` DESC;

-- THE TOTAL NUMBER OF CASE OF CONFIRMED, DEATHS, RECOVERED EACH MONTH

SELECT DISTINCT DATE_FORMAT(`Date`, '%Y-%m') `MONTH`,     
SUM(`Confirmed`) AS Total_Confirmed,
SUM(`Deaths`) AS Total_Deaths,
SUM(`Recovered`) AS Total_Recovered FROM virus_db.corona_virus
GROUP BY `MONTH`
ORDER BY `MONTH` DESC;

-- FIND COUNTRY HAVING HIGHEST NUMBER OF THE CONFIRMED CASE

SELECT `Country/Region` AS Country, SUM(`Confirmed`) AS Total_Confirmed
FROM virus_db.corona_virus
GROUP BY Country
ORDER BY Total_Confirmed DESC
LIMIT 1;

-- FIND COUNTRY HAVING LOWEST NUMBER OF THE DEATH CASE
SELECT `Country/Region` AS Country, SUM(`Deaths`) AS Total_Deaths
FROM virus_db.corona_virus
WHERE Deaths!=0 
GROUP BY Country
ORDER BY Total_Deaths ASC
LIMIT 1;

-- FIND MOST FREQUENT VALUE FOR CONFIRMED, DEATHS, RECOVERED EACH 

-- TOP 5 COUNTRIES HAVING HIGHEST RECOVERED CASE

SELECT `Country/Region` AS Country, SUM(`Recovered`) AS Total_Recovered
FROM virus_db.corona_virus
WHERE `Recovered` !=0 
GROUP BY Country
ORDER BY Total_Recovered DESC
LIMIT 5;
