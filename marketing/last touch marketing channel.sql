-- From the below table, write a query to show the last touch channel marketing channel,
-- how many visits it took to convert and how many marketing channels the visitor utilized
-- to visit the website for only visitors that converted.

-- SalesTable
-- +-------------+-------------+------------------+-------------+
-- | visitorID   | visitNumber | marketingChannel | revenue     |
-- +-------------+-------------+------------------+-------------+
-- | 14590274    | 1           | Direct           |             |
-- | 15692456    | 1           | Paid Search      | 1204.5      |
-- | 13650284    | 3           | Paid Search      | 1399        |
-- | 13892640    | 1           | SEO              |             |
-- | 14590274    | 2           | Display          |             |
-- | 14590274    | 3           | Email            | 1593.90     |
-- | 13892640    | 2           | Affiliates       | 2010        |
-- +-------------+-------------+------------------+-------------+


-- Solution 1
SELECT
  a.visitorID, 
  last_value(a.marketingChannel) over (
    partition by a.visitorID
    order by a.visitNumber
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) as `last_touch_channel`,  
  a.visitNumber as `visits_to_convert`,
  count(distinct b.marketingChannel) as `channels_utilized`
FROM `SalesTable` as a
LEFT JOIN `SalesTable` as b
ON a.visitorID = b.visitorID
WHERE a.revenue > 0
GROUP BY a.visitorID, a.marketingChannel, a.visitNumber


-- Solution 2
WITH table_1 as (
SELECT 
  visitorID, 
  last_value(marketingChannel) over (
    partition by visitorID
    order by visitNumber
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) as `last_touch_channel`,  
  visitNumber
FROM `SalesTable`
WHERE revenue > 0
),

table_2 as (
Select
  visitorID,
  count(marketingChannel) as `number_of_channels`
FROM `SalesTable`
GROUP BY visitorID
)

SELECT
  table_1.visitorID,
  table_1.last_touch_channel,
  table_1.visitNumber as `number_of_visits`,
  table_2.number_of_channels
FROM table_1
LEFT JOIN table_2 on table_1.visitorID = table_2.visitorID
