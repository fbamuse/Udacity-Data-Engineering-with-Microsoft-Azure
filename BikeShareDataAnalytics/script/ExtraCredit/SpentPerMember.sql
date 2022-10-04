
select avg(CountTrip)as CountTripPerMonth,avg(SpentTime) as SpentTime,member_id Into member_behavior from
    (select count(trip_id)as CountTrip,AVG(DATEDIFF(MINUTE,start_at,end_at)) as SpentTime,member_id,Calendar.MMYYYY
        from trip_stage
        Join Calendar on (try_convert(DATE,start_at)=date)
        group by member_id,Calendar.MMYYYY
    ) AS T1 
    group by member_id;

GO

select account_number,total_payment,countTripPerMonth,SpentTime Into SpentPerMember from member_behavior 
JOIN(select account_number,sum(amount) as total_payment from payment_stage GROUP by account_number) AS T1 
ON(T1.account_number = member_id);



DROP Table member_behavior;