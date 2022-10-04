select  
avg(total_payment) as avg_total_payment,
sum(total_payment) as sum_total_payment,
countTripPerMonth
from SpentPerMember
GROUP BY countTripPerMonth
ORDER BY countTripPerMonth;

GO

select  
avg(total_payment) as avg_total_payment,
sum(total_payment) as sum_total_payment,
SpentTime
from SpentPerMember
GROUP BY SpentTime
ORDER BY SpentTime;