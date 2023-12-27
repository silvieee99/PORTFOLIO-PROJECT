SELECT*
FROM Y2018
UNION
SELECT*
FROM Y2019
UNION
SELECT*
FROM Y2020

--IS OUR HOTEL REVENUE GROWING YEARLY By hotel type ?
--ADR is daily rate

WITH Hotels AS (
SELECT* FROM Y2018
UNION
SELECT* FROM Y2019
union
SELECT* FROM Y2020
)
SELECT arrival_date_year, hotel ,round(sum((stays_in_weekend_nights + stays_in_week_nights)* adr),2 )as Revenue 
FROM Hotels
GROUP BY arrival_date_year,hotel
ORDER BY arrival_date_year

--JOIN WITH THE MARKET SEGMENT TABLE

WITH Hotels AS (
SELECT* FROM Y2018
UNION
SELECT* FROM Y2019
UNION
SELECT* FROM Y2020
)
SELECT*
FROM Hotels hot
LEFT JOIN MarketSegment mark
	ON hot.market_segment = mark.market_segment
LEFT JOIN MealCost mea
	ON Mea.meal = hot.meal

	SELECT*
	FROM MarketSegment

