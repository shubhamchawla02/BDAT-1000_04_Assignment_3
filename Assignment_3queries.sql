SELECT * FROM Stackoverflow

------------------------Question 1------------------------------------------------------------------
SELECT COUNT(Respondent) as 'Total Respondents'
FROM Stackoverflow

-----------------------Question 2-------------------------------------------------------------------
SELECT MIN(AGE) AS "Youngest Person's Age"
FROM Stackoverflow

-----------------------Question 2 More Likely Solution ---------------------------------------------
SELECT MIN(AGE) AS "Youngest Person's Age"
FROM Stackoverflow
WHERE AGE >= 10 and AGE <=100

-----------------------Question 3-------------------------------------------------------------------
SELECT COUNT(JobSat) AS 'People who are satisfied with their job'
FROM Stackoverflow
WHERE JobSat NOT LIKE '%dissatisfied%' AND JobSat NOT LIKE 'NA'

-----------------------Question 4-------------------------------------------------------------------
--https://www.mssqltips.com/sqlservertip/1958/sql-server-cross-apply-and-outer-apply/---------------
SELECT TOP(5) Lang.value as 'Top 5 Languages', COUNT(Lang.value) as 'Number of Users'
FROM Stackoverflow  AS S
CROSS APPLY STRING_SPLIT(S.LanguageWorkedWith,';') AS Lang
GROUP BY Lang.value
ORDER BY COUNT(Lang.value) DESC

-----------------------Question 5-------------------------------------------------------------------
SELECT COUNT(MainBranch) AS 'Total Number of Developers'
FROM Stackoverflow
WHERE MainBranch = 'I am a developer by profession'

-----------------------Question 6-------------------------------------------------------------------
SELECT Max(Opsys) 'Operating System', MAX([User Count]) As 'Number of Users'
FROM (SELECT OpSys, COUNT(OpSys) As 'User Count' FROM Stackoverflow GROUP BY OpSys) T

-----------------------Question 7-------------------------------------------------------------------
ALTER TABLE Stackoverflow ALTER COLUMN YearsCode INT;

SELECT MAX(YearsCode) AS 'Max Total Years of Code'
FROM Stackoverflow

-----------------------Question 8-------------------------------------------------------------------
SELECT TOP(5) web.value as 'Top 5 Web Frameworks', COUNT(web.value) as 'Number of Users'
FROM Stackoverflow  AS S
CROSS APPLY STRING_SPLIT(S.WebframeWorkedWith,';') AS web
WHERE web.value <> 'NA'
GROUP BY web.value
ORDER BY COUNT(web.value) DESC

-----------------------Question 9-------------------------------------------------------------------
UPDATE
    Stackoverflow
SET
    EdLevel = REPLACE(EdLevel,'â€™','')


SELECT EdLevel, COUNT(EdLevel) as 'Number of developers'
FROM Stackoverflow
WHERE MainBranch = 'I am a developer by profession' AND EdLevel <> 'NA'
GROUP BY EdLevel
ORDER BY [Number of developers] DESC

-----------------------Question 10-------------------------------------------------------------------
SELECT t1.Country, t2.pct AS Percentage
FROM Stackoverflow t1
INNER JOIN ( SELECT country, ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
    FROM Stackoverflow
    GROUP BY Country
) t2
ON t1.country = t2.country
WHERE t2.pct > 1.5
GROUP BY t1.Country, t2.pct
ORDER BY t2.pct DESC

-----------------------Question 11-------------------------------------------------------------------
SELECT gen.value as 'Gender', ROUND(AVG(WorkWeekHrs),0) AS 'Average work hours'
FROM Stackoverflow  AS S
CROSS APPLY STRING_SPLIT(S.Gender,';') AS gen
WHERE gen.value <> 'NA'
GROUP BY gen.value
ORDER BY COUNT(gen.value) DESC