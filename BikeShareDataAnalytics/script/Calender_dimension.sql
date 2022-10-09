DECLARE @StartDate DATE = (select min(CONVERT(DATE, start_at)) from trip_stage);
DECLARE @CutoffDate DATE = (select max(CONVERT(DATE, end_at)) from trip_stage);


CREATE TABLE #dimdate
(
  [date]         DATE,  
  [day]         tinyint,
  [month]       tinyint,
  [MonthName]  varchar(12),
  [WeekDay]     tinyint,
  [quarter]     tinyint,
  [year]        smallint
);


SET DATEFORMAT mdy;
SET LANGUAGE US_ENGLISH;




INSERT #dimdate([date]) 
SELECT d
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM 
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    -- on my system this would support > 5 million days
    ORDER BY s1.[object_id]
  ) AS x
) AS y;


UPDATE #DimDate 
set 
  [day]        = DATEPART(DAY,      [date]),
  [month]      = DATEPART(MONTH,    [date]),
  [MonthName]  = DATENAME(MONTH,    [date]),
  [WeekDay]    = DATEPART(WEEKDAY,  [date]),
  [quarter]    = DATEPART(QUARTER,  [date]),
  [year]       = DATEPART(YEAR,     [date])
;


CREATE  TABLE Calendar_dimension
with (
  DISTRIBUTION = ROUND_ROBIN
)
AS
SELECT
  [Date]        = [date],
  [Day]         = [day],
  [Weekday]     = [WeekDay],
  [Month]       = [month],
  [Quarter]     = [quarter],
  QuarterName   = CONVERT(VARCHAR(6), CASE [quarter] WHEN 1 THEN 'First' 
                  WHEN 2 THEN 'Second' WHEN 3 THEN 'Third' WHEN 4 THEN 'Fourth' END), 
  [Year]        = [year],
  MonthYear     = CONVERT(VARCHAR(20),  LEFT([MonthName], 3) + ' ' + CONVERT(VARCHAR(4),[Year]))
FROM #dimdate
;

DROP Table #dimdate;