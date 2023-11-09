select*
from CovidDeaths
order by 3,4

select*
from CovidVaccinations
order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from CovidDeaths
order by 1,2

--TOTAL CASES VS TOTAL DEATHS
--shows the chances of dying if you contract covid

select location,date,total_cases,total_deaths,population, (total_deaths/total_cases)* 100 as DeathPercentage
from CovidDeaths
where location = 'Nigeria'
order by 1,2

--TOTAL CASES VS POPULATION
select location,date,total_cases,population, (total_cases/population)* 100 as PercentageInfected
from CovidDeaths
where location = 'Nigeria'
order by 1,2

--COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION
select location,population,max(total_cases) as HighestInfectionCount, (max(total_cases)/population)* 100 as MaxPercentageInfected
from CovidDeaths
--where location = 'Nigeria'
group by location,population
order by 4 desc

--COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION
select location,max(cast(total_deaths as int)) HighestDeathCount
from CovidDeaths
where continent is not null
group by location
order by 2 desc

--LETS BREAK THINGS DOWN BY CONTINENT
select continent,max(cast(total_deaths as int)) as HighestDeathCount
from CovidDeaths
where continent is not null
group by continent
order by 2 desc

--CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION
select continent,max(cast(total_deaths as int)) as HighestDeathCount
from CovidDeaths
where continent is not null
group by continent
order by 2 desc

--GLOBAL NUMBERS
select date, sum(new_cases) as GLOBALTOTTALCASES,sum(cast(new_deaths as int)) as GLOBALTOTALDEATHS,
sum(cast(new_deaths as int))/sum(new_cases)*100 as deathPercentage
from CovidDeaths
where continent is not null
group by date
order by 1,2

--TOTAL population VS VACCINATION
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))over (partition by dea.location order by dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3 

--USE CTE
with POPvsVAC(continent,location,date,population,new_vaccinations,TOTALVACCINATION)
as
(select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))over (partition by dea.location order by dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null)
	--order by 2,3

select*,(TOTALVACCINATION/population)*100 as PercentPopulationVaccinated
from POPvsVAC

--OR USE A TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
TOTALVACCINATION numeric)
insert into #PercentPopulationVaccinated
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))over (partition by dea.location order by dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	--where dea.continent is not null
	--order by 2,3 
select*,(TOTALVACCINATION/population)*100 as PercentPopulationVaccinated
from #PercentPopulationVaccinated

--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS
--VIEW PERCENT POPULATION VACCINATED

 create view PercentPopulationVaccinated as
 select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))over (partition by dea.location order by dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select*
from PercentPopulationVaccinated

--VIEW CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION
Create view HighestDeathCount as
select continent,max(cast(total_deaths as int)) as HighestDeathCount
from CovidDeaths
where continent is not null
group by continent
--order by 2 desc

select*
from HighestDeathCount

--VIEW GLOBAL TOTAL DEATHS
Create view GLOBALTOTALDEATHS as
select date, sum(new_cases) as GLOBALTOTTALCASES,sum(cast(new_deaths as int)) as GLOBALTOTALDEATHS,
sum(cast(new_deaths as int))/sum(new_cases)*100 as deathPercentage
from CovidDeaths
where continent is not null
group by date
--order by 1,2

select*
from GLOBALTOTALDEATHS

--VIEW MAX PERCENTAGE INFECTED
create view MaxPercentageInfected as
select location,population,max(total_cases) as HighestInfectionCount, (max(total_cases)/population)* 100 as MaxPercentageInfected
from CovidDeaths
--where location = 'Nigeria'
group by location,population
--order by 4 desc

select*
from MaxPercentageInfected

--VIEW AS DEATH PERCENTAGE
create view DeathPercentage as
select location,date,total_cases,total_deaths,population, (total_deaths/total_cases)* 100 as DeathPercentage
from CovidDeaths
where location = 'Nigeria'
--order by 1,2

select*
from DeathPercentage

























