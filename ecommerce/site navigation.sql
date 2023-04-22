-- Write a query to show each distinct event category, event action and event label from the
-- nested hits array, the number of times each event occurred and the month that the event
-- occurred– for all event labels containing "NAV"

-- EventsTable
-- +-------------+--------------------------------------------------------------+-------------+
-- |VisitID      | Hits                                                         | date        |
-- +-------------+--------------------------------------------------------------+-------------+
-- | 15692456    | "eventInfo": {"eventCategory": "NAV-Furniture-Living_Room",  | 20220201    |
-- |             |               "eventAction": "click",                        |             |
-- |             |               "eventLabel" : "NAV : Sofas & Sectionals"}     |             |
-- | 13650284    | "eventInfo": {"eventCategory": "NAV-Furniture-Bedroom",      | 20221011    |
-- |             |               "eventAction": "click",                        |             |
-- |             |               "eventLabel" : "NAV : Beds"}                   |             |
-- | 14590274    | "eventInfo": {"eventCategory": "Customer Type",              | 20220515    |
-- |             |               "eventAction": "Logged In",                    |             |
-- |             |               "eventLabel" : "Trade"}                        |             |
-- | 13892640    | "eventInfo": {"eventCategory": "HP-Hero_Slider",             | 20220603    |
-- |             |               "eventAction": "click",                        |             |
-- |             |               "eventLabel" : "HP Slider : SHOP DINING"}      |             |
-- | 15692456    | "eventInfo": {"eventCategory": " Vedran-Partnership-LP",     | 20220605    |
-- |             |               "eventAction": "click",                        |             |
-- |             |               "eventLabel" : "Bedroom Makeover : Designer"}  |             |
-- | 14590274    | "eventInfo": {"eventCategory": "NAV-Lighting",               | 20220516    |
-- |             |               "eventAction":"click",                         |             |
-- |             |               "eventLabel" : "NAV : Table Lamps"}            |             |
-- | 14590274    | "eventInfo": {"eventCategory": "Carousel Clicks",            | 20220201    |
-- |             |               "eventAction":"Best Sellers",                  |             |
-- |             |               "eventLabel" : "/Product/Detail"}              |             |
-- +-------------+--------------------------------------------------------------+-------------+

-- Solution
SELECT DISTINCT
  format_date('%B %Y', parse_DATE('%Y%m%d', date)) as `month`,
  json_extract(Hits, '$.eventInfo.eventCategory') as `event_category`,
  json_extract(Hits, '$.eventInfo.eventAction') as `event_action`,
  json_extract(Hits, '$.eventInfo.eventLabel') as `event_label`,
  count(*) as `event_count`
FROM `Events`
WHERE json_extract(Hits, '$.eventInfo.eventLabel') LIKE '%NAV%'
GROUP BY month, event_category, event_action, event_label
ORDER BY month
