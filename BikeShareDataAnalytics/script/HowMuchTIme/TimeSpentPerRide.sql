select 
    DATEDIFF(MINUTE,start_at,end_at)as SpentTime,
    DATEPART(HOUR, start_at) AS TimeDay,
    Calendar.Weekday as WeekDay,
    start_station.name as start_station,
    end_station.name as end_station,
    DATEDIFF(hour,rider_stage.birthday,GETDATE())/8766 AS Age,
    rider_stage.member as member_flag
Into TimeSpentPerRide
from trip_stage
JOIN Calendar ON (TRY_CONVERT(DATE,start_at)=Calendar.Date)
JOIN station_stage AS start_station ON(start_station.station_id=start_station_id)
JOIN station_stage AS end_station ON(end_station.station_id=end_station_id)
JOIN rider_stage ON(rider_stage.rider_id=member_id)



