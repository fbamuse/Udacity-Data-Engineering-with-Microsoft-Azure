select 
AVG(SpentTime) as avg_SpentTime,
sum(SpentTime)as sum_SpentTime,
TimeDay 
from  TimeSpentPerRide
GROUP by TimeDay
ORDER BY TimeDay;

GO

select 
AVG(SpentTime) as avg_SpentTime,
sum(SpentTime)as sum_SpentTime,
WeekDay 
from  TimeSpentPerRide
GROUP by WeekDay
ORDER BY WeekDay;

GO

select 
AVG(SpentTime) as avg_SpentTime,
sum(SpentTime)as sum_SpentTime,
start_station 
from  TimeSpentPerRide
GROUP by start_station
ORDER BY start_station;

GO

select 
AVG(SpentTime) as avg_SpentTime,
sum(SpentTime)as sum_SpentTime,
Age 
from  TimeSpentPerRide
GROUP by Age
ORDER BY Age;

GO

select 
AVG(SpentTime) as avg_SpentTime,
sum(SpentTime)as sum_SpentTime,
member_flag 
from  TimeSpentPerRide
GROUP by member_flag
ORDER BY member_flag;

