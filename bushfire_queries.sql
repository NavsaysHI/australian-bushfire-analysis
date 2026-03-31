-- ============================================================
-- Australian Bushfire Analysis — September 2019
-- NASA FIRMS VIIRS Satellite Data
-- Tool: SQLite / DB Browser for SQLite
-- Author: Navdeep (Nav)
-- ============================================================

-- ============================================================
-- QUERY 1 — Daily Hotspot Count and Fire Intensity Trend
-- Shows how fire activity built up day by day through September
-- ============================================================

SELECT 
    acq_date,
    COUNT(*) AS total_hotspots,
    ROUND(AVG(frp), 2) AS avg_fire_intensity,
    ROUND(MAX(frp), 2) AS peak_fire_intensity
FROM bushfire_clean
GROUP BY acq_date
ORDER BY acq_date;

-- Key Finding:
-- Peak activity: 6-9 September (6,000-6,800 hotspots/day)
-- Highest peak intensity: 10 September at 479.2 MW
-- Quietest day: 21 September with 1,025 hotspots


-- ============================================================
-- QUERY 2 — Hotspots by Australian Region
-- Uses latitude bands to approximate state boundaries
-- ============================================================

SELECT
    CASE
        WHEN latitude BETWEEN -44 AND -39 THEN 'Tasmania'
        WHEN latitude BETWEEN -39 AND -34 THEN 'Victoria'
        WHEN latitude BETWEEN -34 AND -29 THEN 'NSW/ACT'
        WHEN latitude BETWEEN -29 AND -23 THEN 'Queensland'
        WHEN latitude BETWEEN -23 AND -14 THEN 'Northern Territory'
        WHEN longitude BETWEEN 114 AND 130 THEN 'Western Australia'
        ELSE 'Other'
    END AS region,
    COUNT(*) AS total_hotspots,
    ROUND(AVG(frp), 2) AS avg_intensity,
    ROUND(MAX(frp), 2) AS peak_intensity
FROM bushfire_clean
GROUP BY region
ORDER BY total_hotspots DESC;

-- Key Finding:
-- NT most active with 30,409 hotspots (peak 575 MW)
-- NSW/ACT second with 26,186 hotspots (peak 479.2 MW)
-- QLD had highest average intensity at 10.26 MW


-- ============================================================
-- QUERY 3 — Fire Detection by Hour of Day
-- Reveals when satellite detections peak and when fires burn hottest
-- ============================================================

SELECT
    CAST(SUBSTR(acq_time, 1, 
        CASE WHEN LENGTH(acq_time) = 3 THEN 1 ELSE 2 END) AS INTEGER) AS hour,
    COUNT(*) AS total_detections,
    ROUND(AVG(frp), 2) AS avg_intensity
FROM bushfire_clean
GROUP BY hour
ORDER BY hour;

-- Key Finding:
-- Most detections: 2am-6am (satellite pass window over Australia)
-- Highest avg intensity: Hour 7 at 28.7 MW
-- Afternoon hours (13-18) show lower intensity as fires wind down


-- ============================================================
-- QUERY 4 — Top 10 Most Intense Single Fire Events
-- Identifies the most catastrophic fire hotspots in the dataset
-- ============================================================

SELECT
    acq_date,
    ROUND(latitude, 4) AS latitude,
    ROUND(longitude, 4) AS longitude,
    frp AS fire_radiative_power_mw,
    bright_ti4 AS brightness_temp_kelvin,
    confidence
FROM bushfire_clean
ORDER BY frp DESC
LIMIT 10;

-- Key Finding:
-- #1: NT, 30 Sept at -15.49, 134.61 — 575 MW
-- #2: NSW, 10 Sept at -29.00, 152.26 — 479.2 MW (Tenterfield/Northern Rivers)
-- #3-6: NSW cluster on 12 Sept around -29.8, 152.1 — 445.3 MW


-- ============================================================
-- QUERY 5 — Detection Confidence Breakdown
-- Shows quality distribution of satellite detections
-- ============================================================

SELECT
    confidence,
    COUNT(*) AS total_hotspots,
    ROUND(AVG(frp), 2) AS avg_intensity,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bushfire_clean), 1) AS percentage
FROM bushfire_clean
GROUP BY confidence
ORDER BY total_hotspots DESC;

-- Key Finding:
-- 90.9% nominal confidence (n) — avg intensity 7.6 MW
-- 9.1% high confidence (h) — avg intensity 26.61 MW
-- High confidence detections are 3.5x more intense than nominal
