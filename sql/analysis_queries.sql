SELECT * 
FROM blood_inventory;

-- 1. BLOOD GROUP WITH THE HIGHEST SHORTAGE RATE
SELECT 
   blood_group,
   COUNT(*) as total_Units,
   SUM(shortage_flag= 'YES') AS shortage_count,
   ROUND( 
           SUM(shortage_flag= 'YES')*100 / COUNT(*)
		,2) AS shortage_rate
FROM blood_inventory
GROUP BY blood_group
ORDER BY shortage_rate DESC;

-- 2. BLOOD GROUP WITH THE HIGHEST WASTAGE
SELECT
    blood_group,
    COUNT(*) AS expired_units
FROM blood_inventory
WHERE status='Expired'
GROUP BY blood_group
ORDER BY expired_units DESC;

-- 3. HOSPITAL DEPARTMENT THAT CONSUMES THE MOST BLOOD
SELECT
    hospital_department,
    COUNT(*) AS transfusions
FROM blood_inventory
WHERE status='Transfused'
GROUP BY hospital_department
ORDER BY transfusions DESC;

-- 4. HOSPITAL WITH THE HIGHEST SHORTAGE BURDEN
SELECT
    hospital_name,
    COUNT(*) AS shortages
FROM blood_inventory
WHERE shortage_flag='Yes'
GROUP BY hospital_name
ORDER BY shortages DESC;

-- 5. INVENTORY RISK DISTRIBUTION
SELECT
    inventory_risk,
    COUNT(*) AS units
FROM blood_inventory
GROUP BY inventory_risk;

-- 6. MONTHLY DEMAND TREND 
SELECT
    `year`,
    `month`,
    SUM(daily_units_demanded) AS demand
FROM blood_inventory
GROUP BY `year`, `month`
ORDER BY `year`;

-- 7. HOSPITAL EFFICIENCY SCORE
SELECT
    hospital_name,
    SUM(status='Transfused') AS transfused,
    SUM(status='Expired') AS expired,
    ROUND(
        SUM(status='Transfused')*100/
        COUNT(*),
        2
    ) AS utilization_rate
FROM blood_inventory
GROUP BY hospital_name
ORDER BY utilization_rate DESC;

-- 8. O- SHORTAGE INVESTIGATION
SELECT
    hospital_department,
    COUNT(*) AS o_negative_transfusions
FROM blood_inventory
WHERE blood_group = 'O-'
AND status = 'Transfused'
GROUP BY hospital_department
ORDER BY o_negative_transfusions DESC;

SELECT
    blood_group,
    COUNT(*) AS inventory,
    SUM(status='Transfused') AS transfused,
    ROUND(
        SUM(status='Transfused')*100.0 /
        COUNT(*),
        2
    ) AS utilization_rate
FROM blood_inventory
GROUP BY blood_group
ORDER BY utilization_rate DESC;





































