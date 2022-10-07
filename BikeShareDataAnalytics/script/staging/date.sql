
DECLARE @StartDate DATE = (select min(CONVERT(DATE, start_at)) from trip_stage);
DECLARE @CutoffDate DATE = (select max(CONVERT(DATE, end_at)) from trip_stage);
-- prevent set or regional settings from interfering with 
-- interpretation of dates / literals

CREATE TABLE #dimdate
(
  [date]       DATE,  
  [day]        tinyint,
  [month]      tinyint,
  FirstOfMonth date,
  [MonthName]  varchar(12),
  [week]       tinyint,
  [ISOweek]    tinyint,
  [DayOfWeek]  tinyint,
  [quarter]    tinyint,
  [year]       smallint,
  FirstOfYear  date,
  Style112     char(8),
  Style101     char(10)
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
  FirstOfMonth = CONVERT(DATE, DATEADD(MONTH, DATEDIFF(MONTH, 0, [date]), 0)),
  [MonthName]  = DATENAME(MONTH,    [date]),
  [week]       = DATEPART(WEEK,     [date]),
  [ISOweek]    = DATEPART(ISO_WEEK, [date]),
  [DayOfWeek]  = DATEPART(WEEKDAY,  [date]),
  [quarter]    = DATEPART(QUARTER,  [date]),
  [year]       = DATEPART(YEAR,     [date]),
  FirstOfYear  = CONVERT(DATE, DATEADD(YEAR,  DATEDIFF(YEAR,  0, [date]), 0)),
  Style112     = CONVERT(CHAR(8),   [date], 112),
  Style101     = CONVERT(CHAR(10),  [date], 101)
;


CREATE  TABLE Calendar_dimension
WITH
(
    DISTRIBUTION = ROUND_ROBIN
)
AS
SELECT
  [Date]        = [date],
  [Day]         = CONVERT(TINYINT, [day]),
  [Weekday]     = CONVERT(TINYINT, [DayOfWeek]),
  [Month]       = CONVERT(TINYINT, [month]),
  [Quarter]     = CONVERT(TINYINT, [quarter]),
  QuarterName   = CONVERT(VARCHAR(6), CASE [quarter] WHEN 1 THEN 'First' 
                  WHEN 2 THEN 'Second' WHEN 3 THEN 'Third' WHEN 4 THEN 'Fourth' END), 
  [Year]        = [year],
  MonthYear     = CONVERT(CHAR(8), LEFT([MonthName], 3) + ' ' + LEFT(Style112, 4))
FROM #dimdate
;

DROP Table #dimdate;