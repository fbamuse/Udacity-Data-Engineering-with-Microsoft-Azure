/*Per month, quarter, year*/
select
    AVG(amount) as avg_amount,
    sum(amount)as sum_amount,
    Year,
    Quarter,
    Month
from Payment_fact
JOIN Calendar_dimension ON (TRY_CONVERT(DATE,payment_fact.date)=Calendar_dimension.Date)
JOIN rider_dimension ON(rider_dimension.rider_id=account_number)
group by year,Quarter,month
order by year,Quarter,month;

/*Per member, based on the age of the rider at account start*/
select
    AVG(amount) as avg_amount,
    sum(amount)as sum_amount,
    count(amount)as count,
    AccountStartAge
from Payment_fact
JOIN Calendar_dimension ON (TRY_CONVERT(DATE,payment_fact.date)=Calendar_dimension.Date)
JOIN rider_dimension ON(rider_dimension.rider_id=account_number)
group by AccountStartAge
order by AccountStartAge;
