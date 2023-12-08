--select*
--from Y2018
--union
--select*
--from Y2019
--union
--select*
--from Y2020

--IS OUR HOTEL REVENUE GROWING YEARLY By hotel type ?
--ADR is daily rate

with Hotels as (
select* from Y2018
union
select* from Y2019
union
select* from Y2020
)
select arrival_date_year, hotel ,round(sum((stays_in_weekend_nights + stays_in_week_nights)* adr),2 )as Revenue 
from Hotels
group by arrival_date_year,hotel
order by arrival_date_year

--JOIN WITH THE MARKET SEGMENT TABLE

with Hotels as (
select* from Y2018
union
select* from Y2019
union
select* from Y2020
)
select*
from Hotels hot
left join MarketSegment mark
	on hot.market_segment = mark.market_segment
left join MealCost mea
	on Mea.meal = hot.meal

	select*
	from MarketSegment

