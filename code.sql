-- Exercise 1

SELECT 
COUNT(DISTINCT utm_campaign) AS 'Number of Campaigns', 
COUNT(DISTINCT utm_source) AS 'Number of Sources'
FROM page_visits;

SELECT 
utm_campaign AS 'Campaign Name', 
utm_source AS 'Campaign Source'
FROM page_visits
GROUP BY 1
;

-- Exercise 2

SELECT 
DISTINCT page_name AS 'Website Pages'
FROM page_visits
;

-- Exercise 3

WITH first_touch AS (
    SELECT 
	user_id,
    MIN(timestamp) AS first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
utm_campaign as 'Campaign', 
count(ft.user_id) AS 'Number of First Touches'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
  GROUP BY 1
  ORDER BY 2 DESC
;

-- Exercise 4

WITH last_touch AS (
    SELECT 
	user_id,
    MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
utm_campaign AS 'Campaign', 
COUNT(lt.user_id) AS 'Number of Last Touches'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
  GROUP BY 1
  ORDER BY 2 DESC
;

-- Exercise 5

SELECT 
COUNT(DISTINCT user_id) AS 'Visitors who made a purchase'
FROM page_visits
WHERE page_name = '4 - purchase'
;


-- Exercise 6

WITH last_touch AS (
    SELECT 
	user_id,
    MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
utm_campaign AS 'Campaign', 
COUNT(lt.user_id) AS 'Purchases per campaign'
FROM last_touch lt

JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    WHERE pv.page_name = '4 - purchase'
  GROUP BY 1
  ORDER BY 2 DESC
;