-- From the two separate tables below, write a query to show the sum of unique SKUs
-- purchased and total revenue by each department

-- SalesTable
-- +-------------+-------------+----------------------+-------------+-------------+
-- | visitorID   |transactionID| Product SKU          | quantity    | revenue     |
-- +-------------+-------------+----------------------+-------------+-------------+
-- | 15692456    | 14467578    | OEX-6908TS.WTA-PUMPG | 1           | 1204.5      |
-- | 13650284    | 34547632    | HD-LD53-TJ           | 2           | 1399        |
-- | 14590274    | 35476845    | 4H-IPQS-032          | 2           | 1593.90     |
-- | 13892640    | 23587651    | 4H-VATJ-769          | 1           | 2010        |
-- +-------------+-------------+----------------------+-------------+-------------+

-- ProductTable
-- +----------------------+-----------------------+-----------------+
-- | Product SKU          | Brand                 | Department      |
-- +----------------------+-----------------------+-----------------+
-- | OEX-6908TS.WTA-PUMPG | Essentials for Living | Furniture       |
-- | HD-LD53-TJ           | Halo Styles           | Outdoor         |
-- | 4H-IPQS-032          | Four Hands            | Mirrors and Art |
-- | 4H-VATJ-769          | Four Hands            | Furniture       |
-- | HD-LD73-EJ           | Halo Styles           | Rugs            |
-- +----------------------+-----------------------+-----------------+

-- Solution
SELECT
  p.Department,
  count(distinct s.Product_SKU) as `Unique SKUs`,
  sum(s.revenue) as `Total Revenue`
FROM `SalesTable` as s
LEFT JOIN `ProductTable` as p
ON p.Product_SKU = s.Product_SKU
GROUP BY Department
