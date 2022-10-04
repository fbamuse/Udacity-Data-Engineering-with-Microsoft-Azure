select 
AVG(amount) as avg_amount,
sum(amount)as sum_amount,
month 
from  MoneySpentPerRide
GROUP by month
ORDER BY month;

Go

select 
AVG(amount) as avg_amount,
sum(amount)as sum_amount,
QUARTER 
from  MoneySpentPerRide
GROUP by QUARTER
ORDER BY QUARTER;

GO

select 
AVG(amount) as avg_amount,
sum(amount)as sum_amount,
YEAR 
from  MoneySpentPerRide
GROUP by YEAR
ORDER BY YEAR;


GO

select 
AVG(amount) as avg_amount,
sum(amount)as sum_amount,
AccountStartAge 
from  MoneySpentPerRide
GROUP by AccountStartAge
ORDER BY AccountStartAge;
