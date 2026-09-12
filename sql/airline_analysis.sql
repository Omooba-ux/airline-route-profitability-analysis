-- =========================================================
-- AIRLINE ROUTE PROFITABILITY & OPERATIONS ANALYTICS
-- SQL ANALYSIS
-- Database: airline_analytics
-- Main table: airline_routes
-- =========================================================

USE airline_analytics;

-- =========================================================
-- 1. OVERALL PERFORMANCE
-- =========================================================

SELECT
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Total_Cost), 2) AS total_cost,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS overall_profit_margin,
    ROUND(AVG(Load_Factor) * 100, 2) AS avg_load_factor,
    COUNT(CASE WHEN Profit < 0 THEN 1 END) AS loss_making_flights,
    ROUND(
        COUNT(CASE WHEN Profit < 0 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS loss_rate
FROM airline_routes;

-- Compare recorded row-level profit margins with aggregate margin.
SELECT
    MIN(Profit_Margin) AS min_margin,
    MAX(Profit_Margin) AS max_margin,
    AVG(Profit_Margin) AS avg_margin,
    SUM(Profit) / SUM(Total_Revenue) * 100 AS overall_margin
FROM airline_routes;

-- =========================================================
-- 2. ROUTE PROFITABILITY
-- =========================================================

-- Top 10 routes by total profit.
SELECT
    Route,
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Total_Cost), 2) AS total_cost,
    ROUND(SUM(Profit), 2) AS total_profit
FROM airline_routes
GROUP BY Route
ORDER BY total_profit DESC
LIMIT 10;

-- Top 10 routes by profit margin.
SELECT
    Route,
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Route
ORDER BY profit_margin DESC
LIMIT 10;

-- Bottom 10 routes by profit margin.
SELECT
    Route,
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Route
ORDER BY profit_margin ASC
LIMIT 10;

-- Largest total route losses.
SELECT
    Route,
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Total_Cost), 2) AS total_cost,
    ROUND(SUM(Profit), 2) AS total_loss
FROM airline_routes
GROUP BY Route
HAVING SUM(Profit) < 0
ORDER BY total_loss ASC
LIMIT 10;

-- =========================================================
-- 3. ROUTE CATEGORY ANALYSIS
-- =========================================================

SELECT
    Route_Category,
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Total_Cost), 2) AS total_cost,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Route_Category
ORDER BY profit_margin DESC;

-- Average economics per flight.
SELECT
    Route_Category,
    ROUND(AVG(Total_Revenue), 2) AS avg_revenue_per_flight,
    ROUND(AVG(Total_Cost), 2) AS avg_cost_per_flight,
    ROUND(AVG(Profit), 2) AS avg_profit_per_flight
FROM airline_routes
GROUP BY Route_Category
ORDER BY avg_profit_per_flight DESC;

-- Average flight hours and profitability.
SELECT
    Route_Category,
    ROUND(AVG(Flight_Hours), 2) AS avg_flight_hours,
    ROUND(AVG(Profit), 2) AS avg_profit_per_flight,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Route_Category
ORDER BY avg_flight_hours;

-- =========================================================
-- 4. DEMAND & LOAD FACTOR
-- =========================================================

SELECT
    Demand_Level,
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Total_Cost), 2) AS total_cost,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Demand_Level
ORDER BY profit_margin DESC;

SELECT
    Demand_Level,
    ROUND(AVG(Load_Factor) * 100, 2) AS avg_load_factor,
    ROUND(AVG(Passengers), 0) AS avg_passengers,
    ROUND(AVG(Aircraft_Capacity), 0) AS avg_aircraft_capacity
FROM airline_routes
GROUP BY Demand_Level
ORDER BY avg_load_factor DESC;

SELECT
    Route_Category,
    COUNT(*) AS total_flights,
    ROUND(AVG(Load_Factor) * 100, 2) AS avg_load_factor,
    ROUND(AVG(Passengers), 0) AS avg_passengers,
    ROUND(AVG(Aircraft_Capacity), 0) AS avg_aircraft_capacity
FROM airline_routes
GROUP BY Route_Category
ORDER BY avg_load_factor DESC;

-- =========================================================
-- 5. OPERATING COST STRUCTURE
-- =========================================================

-- Average major cost components by route category.
SELECT
    Route_Category,
    ROUND(AVG(Fuel_Cost), 2) AS avg_fuel_cost,
    ROUND(AVG(Maintenance_Cost), 2) AS avg_maintenance_cost,
    ROUND(AVG(Crew_Cost), 2) AS avg_crew_cost,
    ROUND(AVG(Airport_Fees), 2) AS avg_airport_fees,
    ROUND(AVG(Handling_Cost), 2) AS avg_handling_cost,
    ROUND(AVG(Navigation_Fees), 2) AS avg_navigation_fees
FROM airline_routes
GROUP BY Route_Category
ORDER BY Route_Category;

-- Cost components as a percentage of revenue.
SELECT
    Route_Category,
    ROUND(SUM(Fuel_Cost) / SUM(Total_Revenue) * 100, 2) AS fuel_pct_revenue,
    ROUND(SUM(Maintenance_Cost) / SUM(Total_Revenue) * 100, 2) AS maintenance_pct_revenue,
    ROUND(SUM(Crew_Cost) / SUM(Total_Revenue) * 100, 2) AS crew_pct_revenue,
    ROUND(SUM(Airport_Fees) / SUM(Total_Revenue) * 100, 2) AS airport_pct_revenue,
    ROUND(SUM(Handling_Cost) / SUM(Total_Revenue) * 100, 2) AS handling_pct_revenue,
    ROUND(SUM(Navigation_Fees) / SUM(Total_Revenue) * 100, 2) AS navigation_pct_revenue
FROM airline_routes
GROUP BY Route_Category;

-- Total selected cost components by route category.
SELECT
    Route_Category,
    ROUND(SUM(Fuel_Cost), 2) AS fuel_cost,
    ROUND(SUM(Maintenance_Cost), 2) AS maintenance_cost,
    ROUND(SUM(Crew_Cost), 2) AS crew_cost,
    ROUND(SUM(Airport_Fees), 2) AS airport_fees,
    ROUND(SUM(Handling_Cost), 2) AS handling_cost,
    ROUND(SUM(Navigation_Fees), 2) AS navigation_fees,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue
FROM airline_routes
GROUP BY Route_Category
ORDER BY
    CASE Route_Category
        WHEN 'Long Haul' THEN 1
        WHEN 'Medium Haul' THEN 2
        WHEN 'Short Haul' THEN 3
    END;

-- =========================================================
-- 6. AIRCRAFT PERFORMANCE & FLEET ALLOCATION
-- =========================================================

SELECT
    Aircraft_Type,
    COUNT(*) AS total_flights,
    ROUND(AVG(Load_Factor) * 100, 2) AS avg_load_factor,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Aircraft_Type
ORDER BY profit_margin DESC;

-- Aircraft performance within each route category.
SELECT
    Route_Category,
    Aircraft_Type,
    COUNT(*) AS total_flights,
    ROUND(AVG(Load_Factor) * 100, 2) AS avg_load_factor,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Route_Category, Aircraft_Type
ORDER BY Route_Category, profit_margin DESC;

-- Fleet mix within each route category.
SELECT
    Route_Category,
    Aircraft_Type,
    COUNT(*) AS total_flights,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Route_Category),
        2
    ) AS pct_of_category
FROM airline_routes
GROUP BY Route_Category, Aircraft_Type
ORDER BY Route_Category, pct_of_category DESC;

-- =========================================================
-- 7. SEASONALITY
-- =========================================================

SELECT
    Season,
    COUNT(*) AS total_flights,
    ROUND(AVG(Load_Factor) * 100, 2) AS avg_load_factor,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin
FROM airline_routes
GROUP BY Season
ORDER BY
    CASE Season
        WHEN 'Peak' THEN 1
        WHEN 'Shoulder' THEN 2
        WHEN 'Normal' THEN 3
        WHEN 'Low' THEN 4
    END;

-- =========================================================
-- 8. LOSS ANALYSIS
-- =========================================================

-- Total losses, positive profit, and net profit.
SELECT
    ROUND(SUM(CASE WHEN Profit < 0 THEN Profit ELSE 0 END), 2) AS total_losses,
    ROUND(SUM(CASE WHEN Profit > 0 THEN Profit ELSE 0 END), 2) AS total_positive_profit,
    ROUND(SUM(Profit), 2) AS net_profit
FROM airline_routes;

-- Count profitable and loss-making flights.
SELECT
    COUNT(CASE WHEN Profit < 0 THEN 1 END) AS loss_making_flights,
    COUNT(CASE WHEN Profit >= 0 THEN 1 END) AS profitable_flights,
    COUNT(*) AS total_flights
FROM airline_routes;

-- Loss rate by route category.
SELECT
    Route_Category,
    COUNT(*) AS total_flights,
    COUNT(CASE WHEN Profit < 0 THEN 1 END) AS loss_making_flights,
    ROUND(
        COUNT(CASE WHEN Profit < 0 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS loss_rate
FROM airline_routes
GROUP BY Route_Category
ORDER BY loss_rate DESC;

-- Loss rate by aircraft type.
SELECT
    Aircraft_Type,
    COUNT(*) AS total_flights,
    COUNT(CASE WHEN Profit < 0 THEN 1 END) AS loss_making_flights,
    ROUND(
        COUNT(CASE WHEN Profit < 0 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS loss_rate
FROM airline_routes
GROUP BY Aircraft_Type
ORDER BY loss_rate DESC;

-- =========================================================
-- 9. ANCILLARY REVENUE
-- =========================================================

SELECT
    Route_Category,
    ROUND(SUM(Ticket_Revenue), 2) AS ticket_revenue,
    ROUND(SUM(Ancillary_Revenue), 2) AS ancillary_revenue,
    ROUND(
        SUM(Ancillary_Revenue) / SUM(Total_Revenue) * 100,
        2
    ) AS ancillary_pct_of_revenue
FROM airline_routes
GROUP BY Route_Category
ORDER BY ancillary_pct_of_revenue DESC;

-- =========================================================
-- 10. OPTIONAL ROUTE PERFORMANCE VIEW
-- =========================================================

CREATE OR REPLACE VIEW vw_route_performance AS
SELECT
    Route,
    COUNT(*) AS total_flights,
    ROUND(SUM(Total_Revenue), 2) AS total_revenue,
    ROUND(SUM(Total_Cost), 2) AS total_cost,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Total_Revenue) * 100, 2) AS profit_margin,
    ROUND(AVG(Load_Factor) * 100, 2) AS avg_load_factor,
    COUNT(CASE WHEN Profit < 0 THEN 1 END) AS loss_making_flights,
    ROUND(
        COUNT(CASE WHEN Profit < 0 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS loss_rate
FROM airline_routes
GROUP BY Route;

SELECT *
FROM vw_route_performance
ORDER BY total_profit DESC
LIMIT 10;
