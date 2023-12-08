--ANALYSIS OF 120 YEARS OF OLYMPIC DATA

select*
from OlympicHistory
select*
from OlympicRegions

--How many olympics games have been held?
select count( distinct Games) as No_Of_Olympic_Games
from OlympicHistory

--List down all Olympics games held so far
select distinct Games,City
from OlympicHistory
order by Games desc

--Mention the total no of nations who participated in each olympics game?

select count(distinct reg.region),Games
from OlympicHistory his
 join OlympicRegions reg
	on his.NOC = reg.NOC
	--where Games = '1896 summer'
	group by Games
	order by Games


--Which year saw the highest and lowest no of countries participating in olympics?
--HIGHEST NO OF COUNTRY
select top 1 count(distinct reg.region),Games
from OlympicHistory his
 join OlympicRegions reg
	on his.NOC = reg.NOC
	--where Games = '1896 summer'
	group by Games
	order by Games desc 

--LOWEST NO OF COUNTRY
select top 1 count(distinct reg.region),Games
from OlympicHistory his
 join OlympicRegions reg
	on his.NOC = reg.NOC
	--where Games = '1896 summer'
	group by Games
	order by Games asc

--Which nation has participated in all of the olympic games?
select  reg.region,count( distinct Games) as TotalNoOfParticipatedGames 
from OlympicHistory his
join OlympicRegions reg
	 on his.NOC = reg.NOC
group by reg.region
having count(distinct Games ) = (select count(distinct Games) from OlympicHistory)



--Identify the sport which was played in all summer olympics
select Sport, count(distinct Games) as Total_Games
from OlympicHistory
where Season = 'summer'
group by Sport
having count(distinct Games ) = (select count(distinct Games) from OlympicHistory where Season = 'summer')

--Which Sports were just played only once in the olympics?
select Sport, MIN(Games) as Year_Played
from OlympicHistory
group by Sport
having count(distinct Games) = 1









