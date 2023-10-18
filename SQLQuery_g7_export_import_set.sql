-- SKILLS USED : 
  -- JOINS, CTE'S , AGGREGATE FUNCTION =CONVERTING DTAT TYPE ,CLEANING TABLE
  
--LOOKING TO EXPLORE OUR DATA
SELECT * 
FROM world_export_import..['34_years_world_export_import_da$']


-- LOOKING TO CLEAN THE TABLE BY REMOVE THE EXTRA SPACE IN THE WORD 'WORLD'
UPDATE dbo.['34_years_world_export_import_da$']
SET country ='World'
WHERE country =' World'


-- LOOKING FOR TOTAL EXPORT VALUE FOR G7 COUNTRIES FROM YEAR 2019 TILL YEAR 2022

SELECT country,year,export,
SUM(export) OVER (PARTITION BY country) AS total_export
FROM world_export_import..['34_years_world_export_import_da$']
WHERE country IN ('United States', 'United Kingdom', 'Japan', 'Germany','France', 'Italy','CanAda') AND year> '2018'
ORDER BY country DESC


-- LOOKING FOR TOTAL IMPORT VALUE FOR G7 COUNTRIES FORM YEAR 2019 TILL 2022

SELECT country,year,import,
SUM(import) OVER (PARTITION BY country) AS total_import
FROM world_export_import..['34_years_world_export_import_da$']
WHERE country IN ('United States', 'United Kingdom', 'Japan', 'Germany','France', 'Italy','CanAda') AND year> '2018'
ORDER BY country DESC

-- LOOKING FOR THE TRADE SURPLIS / DEFICIT RATE FOR G7 COUNTRIES

SELECT country,year,ROUND((export- import),1) AS deficit_surplus_per_year ,
ROUND (SUM (export-import) OVER (PARTITION BY country),1) AS deficit_surplus
FROM world_export_import..['34_years_world_export_import_da$']
WHERE country IN ('United States', 'United Kingdom', 'Japan', 'Germany','France', 'Italy','CanAda') AND year> '2018'
ORDER BY deficit_surplus DESC

-- LOOKING TO HOW THE UNITED STATES RATE OF GROWTH IN EXPORT 2002 - 2022

WITH CTE AS ( 
SELECT country,year,export,ROW_NUMBER () OVER(ORDER BY year) AS aly
FROM world_export_import..['34_years_world_export_import_da$']
WHERE country = 'United States'
)
SELECT T1.country,T1.year,T1.export,
ROUND((T1.export-T2.export)*1.0 /T2.export,3) AS growth_rate
FROM CTE AS T1
 LEFT JOIN CTE AS T2 ON T1.year = T2.year +1 
 WHERE T1.country IN ('United States') AND T2.year >'2000'
ORDER BY T2.year 

-- LOOKING TO HOW THE UNITED STATES RATE OF GROWTH IN IMPORT 2002 - 2022
WITH CTE AS ( 
SELECT country,year,import,ROW_NUMBER () OVER(ORDER BY year) AS aly
FROM world_export_import..['34_years_world_export_import_da$']
WHERE country = 'United States'
)
SELECT T3.country,T3.year,T3.import,
ROUND((T3.import-T4.import)*1.0 /T4.import,3) AS growth_rate
FROM CTE AS T3
 LEFT JOIN CTE AS T4 ON T3.year = T4.year +1 
 WHERE T3.country IN ('United States') AND T4.year >'2000'
ORDER BY T4.year 

-- LOOKING TO HOW THE ENTIRE WORLD RATE OF GROWTH IN EXPORT 2002 - 2022
WITH CTE AS ( 
SELECT country,year,export,ROW_NUMBER () OVER(ORDER BY year) AS aly
FROM world_export_import..['34_years_world_export_import_da$']
WHERE country = 'World'
)
SELECT T1.country,T1.year,T1.export,
ROUND((T1.export-T2.export)*1.0 /T2.export,3) AS growth_rate
FROM CTE AS T1
 LEFT JOIN CTE AS T2 ON T1.year = T2.year +1 
 WHERE T1.country IN ('World') AND T2.year >'2000'
ORDER BY T2.year 



-- LOOKING TO HOW THE ENTIRE RATE OF GROWTH IN IMPORT 2002-2022 
WITH CTE AS ( 
SELECT country,year,import,ROW_NUMBER () OVER(ORDER BY year) AS aly
FROM world_export_import..['34_years_world_export_import_da$']
WHERE country = 'World'
)
SELECT T3.country,T3.year,T3.import,
ROUND((T3.import-T4.import)*1.0 /T4.import,3) AS growth_rate
FROM CTE AS T3
 LEFT JOIN CTE AS T4 ON T3.year = T4.year +1 
 WHERE T3.country IN ('World') AND T4.year >'2000'
ORDER BY T4.year 

-- LOOKING TO ENTIRE WORLD PREFORMANCE FOR LAST 10 YEARS
SELECT country
FROM world_export_import..['34_years_world_export_import_da$']
