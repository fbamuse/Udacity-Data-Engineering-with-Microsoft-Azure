/* dimention table*/
CREATE TABLE  station_dimension
(
  station_id varchar(50) NOT NULL,
  name  varchar(100) NOT NULL
);

GO 

INSERT INTO station_dimension (station_id,name)
select
    station_id,
    name
from station_stage;


CREATE TABLE rider_dimension
(
  rider_id int ,
  birthday  Date NOT NULL,
  member bit NOT NULL,
  start_date Date NOT NULL,
  AccountStartAge TINYINT NOT NULL
)


INSERT  INTO rider_dimension(rider_id,birthday,member,start_date,AccountStartAge)
select
    rider_id,
    birthday,
    member,
    start_date,
    DATEDIFF(year,birthday,start_date) 
from rider_stage;

/*fact table*/


CREATE TABLE Payment_fact
(
    payment_id varchar(45)  NOT NULL ,
    date Date NOT NULL,
    amount bigint NOT NULL,
    account_number  int NOT NULL
)
ALTER TABLE Payment_fact ADD CONSTRAINT Payment_fact_customerid PRIMARY KEY NONCLUSTERED (payment_id) NOT ENFORCED;

GO;


INSERT INTO Payment_fact (payment_id,date,amount,account_number)
select
    payment_id,
    date,
    amount,
    account_number
from payment_stage;


CREATE TABLE Trip_fact
(
    trip_id varchar(50) NOT NULL,
    start_at varchar(50)NOT NULL,
    end_at varchar(50) NOT NULL,
    start_station_id varchar(50) NOT NULL,
    end_station_id varchar(50) NOT NULL,
    member_id int NOT NULL,
    TimeDay tinyint NOT NULL,
    Duration int NOT NULL,
    Age_at_Time_of_Trip tinyint NOT NULL
)

ALTER TABLE Trip_fact ADD CONSTRAINT Trip_fact_customerid PRIMARY KEY NONCLUSTERED (trip_id) NOT ENFORCED;

INSERT INTO Trip_fact( trip_id,start_at,end_at,start_station_id,end_station_id,member_id,TimeDay,Duration,Age_at_Time_of_Trip)
select
    trip_id,
    start_at,
    end_at,
    start_station_id,
    end_station_id,
    member_id,
    DATEPART(HOUR, start_at) AS TimeDay,
    DATEDIFF(MINUTE,start_at,end_at) as Duration,
    DATEDIFF(year,rider_dimension.birthday,start_at) AS Age_at_Time_of_Trip
from trip_stage
join rider_dimension on(member_id=rider_dimension.rider_id);



