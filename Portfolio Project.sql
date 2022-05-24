Select*
From PortfolioProject..CovidDeaths

Select location, date, population,total_cases, new_cases, total_deaths
from dbo.CovidDeaths
order by 1,2

--Total Cases VS Total Deaths

Select location, date, population,total_cases, total_deaths, (total_deaths/total_cases)*100 as PercentageDeath
from dbo.CovidDeaths
Where location Like '%albania%'
order by 1,2

--Total Case VS Population

Select location, date, population,total_cases, total_deaths, (total_cases/population)*100 as PercentagePopulation
from dbo.CovidDeaths
Where location Like '%albania%'
order by 2,3


--Highest Infection rates compared to population by location

Select location, population,MAX (total_cases) as HighestInfectionCount, MAX (total_cases/population)*100 as PercentagePopulationInfected
from dbo.CovidDeaths
Group by location, population
order by 4 desc

--Countries with highest Death Count/Percentage

Select location, population,MAX (total_deaths) as HighestDeaths, MAX (total_deaths/population)*100 as PercentageHighestDeaths
from dbo.CovidDeaths
Group by location, population
order by 4 desc


Select location,MAX (cast(total_deaths as int)) as HighestDeaths
from dbo.CovidDeaths
where continent is not null
Group by location
order by HighestDeaths desc


Select location,MAX (cast(total_deaths as int)) as HighestDeaths
from dbo.CovidDeaths
where location is not null
Group by location
order by HighestDeaths desc



--Continent with highest death count

Select continent,MAX (cast(total_deaths as int)) as HighestDeaths
from dbo.CovidDeaths
where continent is not null
Group by continent
order by HighestDeaths desc


--Global New cases and Total deaths by date


Select date, SUM( new_cases) as TotalNewCases, SUM(cast(total_deaths as int)) as TotalDeaths, SUM(cast(total_deaths as int))/sum(new_cases)*100 as GlobalDeathPercentage
from dbo.CovidDeaths
Where continent is not null
Group by date
order by 1,2


Select*
From PortfolioProject..CovidVaccinations
Order by total_vaccinations

Select location, date, total_vaccinations
From PortfolioProject..CovidVaccinations
Order by 1,2

Select*
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
order by 2




Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
order by 2,3




Select dea.continent, dea.location, dea.date, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int))
OVER (Partition by dea.location Order by dea.location, dea.date) as RollingCountVaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where vac.new_vaccinations is not null
order by 2,3

