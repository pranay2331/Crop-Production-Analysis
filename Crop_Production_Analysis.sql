SELECT * FROM crop_production_db.apy;

#Beginner Level:
#What are the top three crops grown in India based on total production?
select crop,sum(production) as total_production from apy
group by crop
order by total_production desc
limit 3;

#Which state has the highest average yield per hectare for rice cultivation?
select state_name,avg(production/area) as average_yield
from apy
where crop = 'rice'
group by State_Name
order by average_yield desc
limit 1;

#What is the most commonly cultivated crop during the Kharif season?
select crop,sum(area) as total_area 
from apy
where Season = 'Kharif     '
group by crop
order by total_area desc
limit 1;
;

#How has the total area under cultivation changed from 1997 to 2014?
select (sum(case when crop_year = 2014 then area else 0 end) - sum(case when crop_year = 1997 then area else 0 end)) as change_in_area
from apy
where crop_year in (1997, 2014);

#Which district has the highest production of coconut in the year 2010?
select district_name,sum(production) as total_production
from apy
where crop = 'Coconut ' and crop_year = 2010
group by district_name
order by total_production desc
limit 1;

#What is the overall trend in the production of sugarcane in India over the years?
select crop_year,sum(production) as total_production
from apy
where crop = 'Sugarcane'
group by crop_year
order by crop_year;

#Which state shows the highest variability in the production of wheat?
select state_name,round(variance(production),2) as production_variance
from apy
where crop = 'Wheat'
group by state_name
order by production_variance desc;

#Average Production per Year
select crop_year,round(AVG(production),2) as AverageProduction
from apy
group by crop_year
order by crop_year;

#District with Highest Production
select District_Name,max(production) as highestproduction
from apy
group by District_Name
order by highestproduction desc;

#crop area vs production
select crop,round(avg(area),2) as average_area,round(avg(production),2) as average_production
from apy
group by crop
order by crop;

#year with Highest Production
select crop_year,max(production) as highest_production
from apy
group by crop_year
order by highest_production desc;

#Analyze the trend of coconut production in coastal states versus non-coastal states.
select state_name,
	case when state_name in ('Andhra Pradesh','Gujarat','Karnataka','Kerala','Andaman and Nicobar Islands','Maharashtra','Odisha','Tamil Nadu','West Bengal','Goa','Puducherry') then 'Coastal'
    else 'Non_Coastal' end as coastalType,
    round(avg(production),2) as AverageProduction
from apy
where crop = 'Coconut '
group by State_Name,coastalType
order by AverageProduction desc; 

#Investigate if there's a relationship between the area under cultivation and the production of major crops in a particular region.
SELECT 
    Crop,
    SUM(Area) AS Total_Area,
    SUM(Production) AS Total_Production,
    CASE 
        WHEN SUM(Area) > 0 THEN SUM(Production) / SUM(Area)
        ELSE 0
    END AS Production_Per_Area
FROM apy
WHERE State_Name = 'Andaman and Nicobar Islands' 
  AND District_Name = 'NICOBARS'
GROUP BY Crop
ORDER BY Production_Per_Area DESC;


