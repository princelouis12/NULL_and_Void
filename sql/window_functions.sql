-- Query 1: Compare values with LAG() and LEAD()
SELECT
    customer_name,
    total_amount,
    LAG(total_amount) OVER (ORDER BY order_date) AS previous_amount,
    LEAD(total_amount) OVER (ORDER BY order_date) AS next_amount,
    CASE 
        WHEN total_amount > LAG(total_amount) OVER (ORDER BY order_date) THEN 'HIGHER'
        WHEN total_amount < LAG(total_amount) OVER (ORDER BY order_date) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS compare_with_previous
FROM sales_orders;

-- Query 2: Ranking with RANK() and DENSE_RANK()
SELECT
    region,
    customer_name,
    total_amount,
    RANK() OVER (PARTITION BY region ORDER BY total_amount DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY total_amount DESC) AS dense_rank
FROM sales_orders;

-- Query 3: Top 3 records per region
SELECT *
FROM (
    SELECT
        region,
        customer_name,
        total_amount,
        RANK() OVER (PARTITION BY region ORDER BY total_amount DESC) AS rnk
    FROM sales_orders
)
WHERE rnk <= 3;

-- Query 4: First 2 records per region by order_date
SELECT *
FROM (
    SELECT
        region,
        customer_name,
        order_date,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY order_date) AS rn
    FROM sales_orders
)
WHERE rn <= 2;

-- Query 5: Aggregation with window functions
SELECT
    region,
    customer_name,
    total_amount,
    MAX(total_amount) OVER (PARTITION BY region) AS max_per_region,
    MAX(total_amount) OVER () AS overall_max
FROM sales_orders;
