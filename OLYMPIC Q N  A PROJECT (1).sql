--ANALYSIS OF 120 YEARS OF OLYMPIC DATA

SELECT*
FROM OlympicHistory
SELECT*
FROM OlympicRegions

--How many olympics games have been held?
SELECT COUNT( DISTINCT Games) AS No_Of_Olympic_Games
FROM OlympicHistory

--List down all Olympics games held so far
SELECT DISTINCT Games,City
FROM OlympicHistory
ORDER BY Games DESC

--Mention the total no of nations who participated in each olympics game?

SELECT COUNT(DISTINCT reg.region),Games
FROM OlympicHistory his
 JOIN OlympicRegions reg
	ON his.NOC = reg.NOC
	--where Games = '1896 summer'
	GROUP BY Games
	ORDER BY Games


--Which year saw the highest and lowest no of countries participating in olympics?
--HIGHEST NO OF COUNTRY
SELECT top 1 COUNT(DISTINCT reg.region),Games
FROM OlympicHistory his
 JOIN OlympicRegions reg
	ON his.NOC = reg.NOC
	--where Games = '1896 summer'
	GROUP BY Games
	ORDER BY Games DESC 

--LOWEST NO OF COUNTRY
SELECT top 1 COUNT(DISTINCT reg.region),Games
FROM OlympicHistory his
 JOIN OlympicRegions reg
	ON his.NOC = reg.NOC
	--where Games = '1896 summer'
	GROUP BY Games
	ORDER BY Games ASC

--WHICH NATION HAS PARTICIPATED IN ALL OF THE OLYMPIC GAMES?
SELECT  reg.region,COUNT( DISTINCT Games) AS TotalNoOfParticipatedGames 
FROM OlympicHistory his
JOIN OlympicRegions reg
	 ON his.NOC = reg.NOC
GROUP BY reg.region
HAVING COUNT(DISTINCT Games ) = (SELECT COUNT(DISTINCT Games) FROM OlympicHistory)



--IDENTIFY THE SPORTS THAT WAS PLAYED IN ALL OF SUMMER OLYMPICS
SELECT Sport, COUNT(DISTINCT Games) AS Total_Games
FROM OlympicHistory
WHERE Season = 'summer'
GROUP BY Sport
HAVING COUNT(DISTINCT Games ) = (SELECT COUNT(DISTINCT Games) FROM OlympicHistory WHERE Season = 'summer')

--WHICH SPORTS WERE PLAYED JUST ONCE IN THE OLYMPICS
SELECT Sport, MIN(Games) as Year_Played
FROM OlympicHistory
GROUP BY Sport
HAVING COUNT(DISTINCT Games) = 1











