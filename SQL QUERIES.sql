



-- load factor by monthly--
SELECT
    Year,
    MonthNo AS Month,
    Month_Name,
    ROUND(
        SUM(Transported_Passengers) * 100.0 /
        NULLIF(SUM(Available_Seats), 0),
        2
    ) AS load_factor_percentage
FROM main_data
GROUP BY Year, MonthNo, Month_Name
ORDER BY Year, MonthNo;

-- load factor by year--
SELECT
    Year,
    ROUND(
        SUM(Transported_Passengers) * 100.0 /
        NULLIF(SUM(Available_Seats), 0),
        2
    ) AS load_factor_percentage
FROM main_data
GROUP BY Year
ORDER BY Year;

-- Load factor by quarterly--
SELECT
    Year,
    Quarter,
    ROUND(
        SUM(Transported_Passengers) * 100.0 /
        NULLIF(SUM(Available_Seats), 0),
        2
    ) AS load_factor_percentage
FROM main_data
GROUP BY Year, Quarter
ORDER BY Year, Quarter;

-- load factor by carrier name--
SELECT
    Carrier_Name,
    ROUND(
        SUM(Transported_Passengers) * 100.0 /
        NULLIF(SUM(Available_Seats), 0),
        2
    ) AS load_factor_percentage
FROM main_data
GROUP BY Carrier_Name
ORDER BY load_factor_percentage DESC;

-- Top 10 carrier Names in passanger preferances--
SELECT
    Carrier_Name,
    SUM(Transported_Passengers) AS total_passengers,
    ROUND(
        SUM(Transported_Passengers) * 100.0 /
        SUM(SUM(Transported_Passengers)) OVER (),
        2
    ) AS passenger_share_pct
FROM main_data
GROUP BY Carrier_Name
ORDER BY total_passengers DESC
LIMIT 10;

--  Top 15 routes from_to_city--
SELECT
    From_To_City,
    SUM(Departures_Performed) AS total_flights
FROM main_data
GROUP BY From_To_City
ORDER BY total_flights DESC
LIMIT 15;

-- Load factor by weekend and weekdays--
SELECT
    CASE
        WHEN Weekday_Name IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    ROUND(
        SUM(Transported_Passengers) * 100.0 /
        NULLIF(SUM(Available_Seats), 0),
        2
    ) AS load_factor_percentage
FROM main_data
GROUP BY day_type;

-- Flights By Distance Group--
SELECT
    dg.Distance_Interval,
    SUM(md.Departures_Performed) AS number_of_flights
FROM main_data md
JOIN distance_groups dg
    ON md.Distance_Group_ID = dg.Distance_Group_ID
GROUP BY dg.Distance_Interval
ORDER BY number_of_flights DESC;








