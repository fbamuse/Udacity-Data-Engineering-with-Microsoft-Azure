/* dimention table*/
select
    station_id,
    name
Into station_dimension
from station_stage;

select
    rider_id,
    birthday,
    member,
    start_date,
    DATEDIFF(year,birthday,start_date) AS AccountStartAge
into rider_dimension
from rider_stage;


/*fact table*/
select
    payment_id,
    date,
    amount,
    account_number
Into Payment_fact
from payment_stage;

GO

select
    trip_id,
    start_at,
    end_at,
    start_station_id,
    end_station_id,
    member_id,
    DATEPART(HOUR, start_at) AS TimeDay,
    DATEDIFF(MINUTE,start_at,end_at) as SpentTime,
    DATEDIFF(year,rider_dimension.birthday,start_at) AS AgeAtTrip
Into Trip_Fact
from trip_stage
join rider_dimension on(member_id=rider_dimension.rider_id);


