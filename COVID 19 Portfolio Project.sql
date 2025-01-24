SELECT * from PortfolioProjcet..CovidDeaths
order by 3,4

--SELECT * from PortfolioProjcet..CovidVaccinations
--order by 3,4

SELECT Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProjcet..CovidDeaths
order by 1,2

--looking at total cases vs total deaths
--shows the percentage of you dying if you get covid in the country your living it
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRate
from PortfolioProjcet..CovidDeaths
where location like '%states%'
order by 1,2


-- looking at Total cases vs population 
-- shows the population that has contacted covid
SELECT Location, date, total_cases, population, (total_cases/population)*100 as PopulationPercentage
from PortfolioProjcet..CovidDeaths
--where location like '%states%'
order by 1,2


--looking at countries with the highest infection rate vs population
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 as InfectedPopulationPercent
from PortfolioProjcet..CovidDeaths
Group by location, population
order by InfectedPopulationPercent desc

-- looking for countries with highest death count per population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProjcet..CovidDeaths
where continent is not null
Group by location
order by TotalDeathCount desc

--LOOKING SAME DEATH COUNT BUT BY CONTINENT NOW

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProjcet..CovidDeaths
where continent is not null
Group by continent
order by TotalDeathCount desc

--NOW LOOKING AT GLOBAL NUMBER MEANING NUMBER FOR THE WHOLE WORLD

SELECT SUM(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from PortfolioProjcet..CovidDeaths
where continent is not null
order by 1,2



----------NOW WE ARE JOINING THE  VACCINATION DATA WITH THE COVID DATA
----------AND LOOKING AT TOTAL POPULATION VS VACCINATION
 
 -- 

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM (CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
dea.date) as PeopleVaccinated

from PortfolioProjcet..CovidDeaths dea
JOIN PortfolioProjcet..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3


--- CREARTING A VIEW FOR DATA VISUALIZATION.
--Drop Table if exists #PeopleVaccinated
Create View PeopleVaccinated1 as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM (CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
dea.date) as PeopleVaccinated

from PortfolioProjcet..CovidDeaths dea
JOIN PortfolioProjcet..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null

SELECT *
FROM PeopleVaccinated