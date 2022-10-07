/*Based on date and time factors such as day of week and time of day*/
select 
    avg(Duration) as avg_Duration,
    TimeDay,
    Weekday 
from trip_fact
JOIN Calendar ON (TRY_CONVERT(DATE,start_at)=Calendar.Date)
group by TimeDay,Weekday
order by  Weekday,TimeDay;

/*Based on which station is the starting and / or ending station*/

select 
    avg(Duration) as avg_Duration,
    name 
from trip_fact
JOIN station_dimension ON(station_dimension.station_id=start_station_id)
group by name

/*Based on whether the rider is a member or a casual rider*/
select 
    avg(Duration) as avg_Duration,
    member 
from trip_fact
JOIN rider_dimension ON(rider_dimension.rider_id=member_id)
group by member

/*Based on age of the rider at time of the ride*/
select 
    avg(Duration) as avg_Duration,
    Age_at_Time_of_Trip 
from trip_fact
JOIN rider_dimension ON(rider_dimension.rider_id=member_id)
group by Age_at_Time_of_Trip
order by Age_at_Time_of_Trip