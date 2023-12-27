SELECT*
FROM CovidDeaths
ORDER BY 3,4

SELECT*
FROM CovidVaccinations
ORDER BY 3,4

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM CovidDeaths
ORDER BY 1,2

--TOTAL CASES VS TOTAL DEATHS
--shows the chances of dying if you contract covid

SELECT location,date,total_cases,total_deaths,population, (total_deaths/total_cases)* 100 as DeathPercentage
FROM CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2

--TOTAL CASES VS POPULATION
SELECT location,date,total_cases,population, (total_cases/population)* 100 as PercentageInfected
FROM CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2

--COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION
SELECT location,population,max(total_cases) as HighestInfectionCount, (max(total_cases)/population)* 100 as MaxPercentageInfected
FROM CovidDeaths
--where location = 'Nigeria'
GROUP BY location,population
ORDER BY 4 DESC

--COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION
SELECT location,max(CAST(total_deaths AS int)) HighestDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY  location
ORDER BY 2 DESC

--LETS BREAK THINGS DOWN BY CONTINENT
SELECT continent,max(CAST(total_deaths AS int)) AS HighestDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC

--CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION
SELECT continent,max(CAST(total_deaths AS int)) AS HighestDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC 
--GLOBAL NUMBERS
SELECT date, sum(new_cases) AS GLOBALTOTTALCASES,sum(CAST(new_deaths AS int)) AS GLOBALTOTALDEATHS,
sum(CAST(new_deaths AS int))/sum(new_cases)*100 AS deathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

--TOTAL population VS VACCINATION
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(CAST(vac.new_vaccinations AS int))over (partition BY dea.location ORDER BY dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent IS NOT NULL
	ORDER BY 2,3 

--USE CTE
WITH POPvsVAC(continent,location,date,population,new_vaccinations,TOTALVACCINATION)
AS
(SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(CAST(vac.new_vaccinations AS int))over (partition BY dea.location ORDER BY dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent IS NOT NULL)
	--order by 2,3

SELECT*,(TOTALVACCINATION/population)*100 AS PercentPopulationVaccinated
FROM POPvsVAC

--OR USE A TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
TOTALVACCINATION numeric)
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(CAST(vac.new_vaccinations AS int))over (partition BY dea.location ORDER BY dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
	--where dea.continent is not null
	--order by 2,3 
SELECT*,(TOTALVACCINATION/population)*100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated

--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS
--VIEW PERCENT POPULATION VACCINATED

 CREATE VIEW PercentPopulationVaccinated AS
 select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(CAST(vac.new_vaccinations AS int))over (partition BY dea.location ORDER BY dea.location,dea.date) TOTALVACCINATION
--(TOTALVACCINATION/Population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--order by 2,3

SELECT*
FROM PercentPopulationVaccinated

--VIEW CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION
CREATE VIEW HighestDeathCount AS
SELECT continent,max(CAST(total_deaths AS int)) AS HighestDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
--order by 2 desc

SELECT*
FROM  HighestDeathCount

--VIEW GLOBAL TOTAL DEATHS
CREATE VIEW GLOBALTOTALDEATHS AS
SELECT date, sum(new_cases) AS GLOBALTOTTALCASES,sum(CAST(new_deaths AS int)) AS GLOBALTOTALDEATHS,
sum(CAST(new_deaths AS int))/Sum(new_cases)*100 AS deathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
--order by 1,2

SELECT*
FROM GLOBALTOTALDEATHS

--VIEW MAX PERCENTAGE INFECTED
CREATE VIEW MaxPercentageInfected AS
SELECT location,population,max(total_cases) AS HighestInfectionCount, (max(total_cases)/population)* 100 AS MaxPercentageInfected
FROM CovidDeaths
--where location = 'Nigeria'
GROUP BY location,population
--order by 4 desc

SELECT*
FROM MaxPercentageInfected

--VIEW AS DEATH PERCENTAGE
CREATE VIEW DeathPercentage AS
SELECT location,date,total_cases,total_deaths,population, (total_deaths/total_cases)* 100 as DeathPercentage
FROM CovidDeaths
WHERE location = 'Nigeria'
--order by 1,2

SELECT*
FROM DeathPercentage

























