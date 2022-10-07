
select 
    avg(tripcount) as avg_tripcount,
    avg(avg_Duration) as avg_Duration,
    member_id 
    into user_activity
from(
    select count(Duration) as tripcount,
        avg(Duration) as avg_Duration,
        member_id,
        MonthYear
    from Trip_Fact
    Join Calendar_dimension on (try_convert(DATE,start_at)=date)
    group by member_id,MonthYear
) AS T 
GROUP by member_id;

select 
    account_number,
    total_payment,
    avg_tripcount,
    avg_Duration
from user_activity 
JOIN(select 
        account_number,
        sum(amount) as total_payment
    from payment_fact 
    GROUP by account_number
) AS T1 
ON(T1.account_number = member_id);

drop table user_activity;