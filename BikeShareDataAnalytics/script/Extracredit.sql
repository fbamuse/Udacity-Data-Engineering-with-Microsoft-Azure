
select 
    avg(tripcount) as avg_tripcount,
    avg(SpentTime) as avg_spentTime,
    member_id 
    into user_activity
from(
    select count(SpentTime) as tripcount,
        avg(SpentTime)as SpentTime,
        member_id,
        MonthYear
    from trip_Fact
    Join Calendar on (try_convert(DATE,start_at)=date)
    group by member_id,MonthYear
) AS T 
GROUP by member_id;

select 
    account_number,
    total_payment,
    avg_tripcount,
    avg_spentTime
from user_activity 
JOIN(select 
        account_number,
        sum(amount) as total_payment
    from payment_fact 
    GROUP by account_number
) AS T1 
ON(T1.account_number = member_id);

drop table user_activity;