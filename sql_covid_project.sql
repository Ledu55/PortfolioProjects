/*
Covid 19 Data Exploration 
Skills: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

Select *
From CovidProject..CovidDeaths
Where continent is not null 
order by 3,4


-- Exibindo os Daados que serão trabalhados no projeto

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidProject..CovidDeaths
Where continent is not null 
order by 1,2


-- Total de Casos vs Total de Mortes
-- Exibindo as o percentual de mortalidade por Covid no Brasil

Select Location, date, total_cases,total_deaths, (CAST(total_deaths as FLOAT)/CAST(total_cases as FLOAT))*100 as DeathPercentage
From CovidProject..CovidDeaths
Where location like '%brazil%'
and continent is not null 
order by 1,2


-- Total de Casos vs População
-- Exibindo percentual da população brasileira que contraiu covid

Select Location, date, Population, total_cases,  (CAST(total_cases as FLOAT)/population)*100 as PercentPopulationInfected
From CovidProject..CovidDeaths
Where location like '%brazil%'
order by 1,2


-- Países com maior taxa de infecção por população

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max(CAST(total_cases as FLOAT)/population)*100 as PercentPopulationInfected
From CovidProject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc


-- Países com maior mortalidade por população

Select Location, MAX(cast(Total_deaths as FLOAT)) as TotalDeathCount
From CovidProject..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc



-- ANALISANDO POR CONTINENTE 

-- Exibindo continentes com maior número de mortes por população

Select continent, MAX(cast(Total_deaths as FLOAT)) as TotalDeathCount
From CovidProject..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-- Números Globais
-- Avanços dos Casos ao Longo do Tempo

Select date, SUM(CAST(new_cases as FLOAT)) as Total_Cases, SUM(CAST(new_deaths as FLOAT)) as Total_Deaths
,SUM(CAST(new_deaths as FLOAT))/SUM(CAST(new_cases as FLOAT)) * 100 as DeathPercentage
From CovidProject..CovidDeaths
Where continent is not null
Group By date
order by 1,2

-- Números Totais atuais

Select SUM(CAST(new_cases as FLOAT)) as Total_Cases, SUM(CAST(new_deaths as FLOAT)) as Total_Deaths
,SUM(CAST(new_deaths as FLOAT))/SUM(CAST(new_cases as FLOAT)) * 100 as DeathPercentage
From CovidProject..CovidDeaths
Where continent is not null
--Group By date
order by 1,2

-- Total da população x número de vacinação

With PopxVac (location, population, date, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.location, dea.population, dea.date, vac.new_vaccinations
, SUM(Convert(FLOAT, vac.new_vaccinations)) OVER (Partition By dea.Location Order By dea.location, dea.date) as RollingPeopleVaccinated
From CovidProject..CovidDeaths dea join CovidProject..CovidVaccinattions vac
	on dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null
--order by 1,3
)

Select * , (RollingPeopleVaccinated/population)*100 as RollingVaccinationPercent
from PopxVac

-- Criando uma view para armazenar dados para futuras visualizações 

Create View PercentPopulationVaccinated as 
Select dea.location, dea.population, dea.date, vac.new_vaccinations
, SUM(Convert(FLOAT, vac.new_vaccinations)) OVER (Partition By dea.Location Order By dea.location, dea.date) as RollingPeopleVaccinated
From CovidProject..CovidDeaths dea join CovidProject..CovidVaccinattions vac
	on dea.location = vac.location 
	and dea.date = vac.date
Where dea.continent is not null

-- Visualizando a view criada

Select * 
From PercentPopulationVaccinated 
Order by date