--portafolio project
-- A datawise likelihood of dying due to covid-totalcases vs totaldeaths in Dominican Republic.
select date,total_cases,total_deaths from "CovidDeaths" where location like '%Dominican Republic'
--B total % of deaths out of entire population in Dominican Republic.
select (max(total_deaths)/avg (cast(population as integer))*100) from"CovidDeaths" where location like '%Dominican Republic%'
--C. verify b by getting info separetely
select total_deaths, population from "CovidDeaths" where location like '%Dominican Republic%'
--D. Country with the highest death % in population
select location,(max(total_deaths)/avg(cast(population as bigint))* 100)as percentage from "CovidDeaths" group by location order by percentage desc;
-- e total % of covid +ve cases in Dominican Republic
select max(total_cases)/avg(cast(population as bigint))*100 as percentagepositive from "CovidDeaths" where location like '%Dominican Republic%'
-- f total percentage of covid +ve cases in the world
select location, max(total_cases)/avg(cast(population as bigint))*100 as percentagepositive from "CovidDeaths" group by location order by percentagepositive desc;
-- continent wise +ve cases
select location, max (total_cases) as total_case from "CovidDeaths" where continent is null group by location order by total_case desc;
--continent wise deaths.
select location, max (total_deaths) as total_death from "CovidDeaths" where continent is null group by location order by total_death desc;
--daily newcases vs hospitalization vs icu_patient- Dominican Republic 
select date,new_cases,hosp_patient,icu_patient from "CovidDeaths" where location like '%Dominican Republic%'
--J. countrywise Age 65>
select "CovidDeaths".date,"CovidDeaths".location,"CovidVaccinations".aged_65_older from "CovidDeaths" join "CovidVaccinations" on "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date
--k, countrywise total vaccinated persons
select "CovidDeaths". location as country, (max("CovidVaccinations".people_fully_vaccinated)) as Fully_Vaccinated from "CovidDeaths" join "CovidVaccinations" on "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date where "CovidDeaths".continent is not null group by country order by Fully_vaccinated desc