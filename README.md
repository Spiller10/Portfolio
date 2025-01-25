COVID-19 Data Analytics Portfolio Project

This project analyzes global COVID-19 data, focusing on mortality rates, vaccination progress, and the correlation with socioeconomic factors like GDP and healthcare infrastructure.
Using SQL, this project provides insights into the global pandemic's impact and highlights regional disparities.

OBJECTIVE

--To explore, analyze, and visualize the global effects of COVID-19 by:
--Calculating mortality rates (death rates) by country and over time.
--Evaluating vaccination progress and its effectiveness in reducing mortality.
--Investigating correlations between COVID-19 outcomes and socioeconomic indicators such as GDP and life expectancy.


Key SQL Queries and Analysis

1. Mortality Rate Calculation
Analyzed the percentage of deaths relative to cases to evaluate the severity of COVID-19 globally:

 SELECT Location, date, total_cases, total_deaths, 
       (total_deaths / total_cases) * 100 AS DeathRate
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2;




2. Vaccination Effectiveness
Compared vaccination rates to death rates to assess immunization program success:

SELECT Location, date, total_deaths, population, 
       (total_deaths / population) * 100 AS MortalityRate,
       vaccination_rate
FROM PortfolioProject..CovidVaccinations
WHERE vaccination_rate IS NOT NULL
ORDER BY 1, 2;



3. Socioeconomic Factors and COVID-19 Outcomes
Investigated the relationship between GDP per capita and mortality rates:

SELECT Location, gdp_per_capita, 
       AVG(total_deaths / total_cases) * 100 AS AvgDeathRate
FROM PortfolioProject..CovidDeaths
WHERE gdp_per_capita IS NOT NULL
GROUP BY Location, gdp_per_capita
ORDER BY AvgDeathRate DESC;















