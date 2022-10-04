select
    account_number,
    amount,
    Calendar.MMYYYY as month ,
    concat(Calendar.year,Calendar.Quartername)as quarter,
    Calendar.year as year,
    DATEDIFF(hour,rider_stage.birthday,rider_stage.start_date)/8766 AS AccountStartAge
Into MoneySpentPerRide
from payment_stage
JOIN Calendar ON (TRY_CONVERT(DATE,payment_stage.date)=Calendar.Date)
JOIN rider_stage ON(rider_stage.rider_id=account_number)