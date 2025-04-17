📊 SQL Queries Using Window Functions

In this project, we implemented various SQL window functions such as LAG(), LEAD(), RANK(), DENSE_RANK(), and ROW_NUMBER() to work with a sales dataset. Below are the queries, their explanations, the output, and their real-life applications.

1. LAG() and LEAD() Functions

Query:

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

Explanation:
LAG() returns the value of the previous row in the result set.

LEAD() returns the value of the next row in the result set.

This query compares each order’s total amount with the previous and next orders, displaying whether it is higher, lower, or equal.

Output:

Real-life Application:
Comparison of sales over time: This can be used to track whether sales are increasing or decreasing from one period to the next, enabling businesses to detect patterns and make informed decisions.

2. Ranking with RANK() and DENSE_RANK() Functions

Query:

SELECT
    region,
    customer_name,
    total_amount,
    RANK() OVER (PARTITION BY region ORDER BY total_amount DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY total_amount DESC) AS dense_rank
FROM sales_orders;

Explanation:
RANK() assigns ranks with gaps in the ranking if there are ties.

DENSE_RANK() assigns ranks without any gaps, even if there are ties.

This query partitions the data by region and ranks the sales orders based on the total amount.

Output:

Real-life Application:
Employee Performance Ranking: In a sales environment, this could rank employees based on the amount of sales they generate, identifying top performers and offering them rewards or incentives.

3. Top 3 Records per Region

Query:

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


Explanation:
This query ranks sales orders within each region and retrieves the top 3 orders based on the total amount.

It uses the RANK() function to rank the records and filters out the top 3.

Output:

Real-life Application:
Sales Performance Tracking: For example, a company may want to track the top 3 customers or top 3 products per region to better understand which customers or products are driving the most revenue.

4. First 2 Records per Region by order_date

Query:

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

Explanation:
ROW_NUMBER() assigns a unique sequential integer to rows within a partition.

This query retrieves the first 2 records for each region based on the order_date.

Output:

Real-life Application:
Prioritizing Orders: This can be used to prioritize the first two orders placed in each region, useful for understanding initial sales trends and handling early customer demands.

5. Aggregation with Window Functions

Query:

SELECT
    region,
    customer_name,
    total_amount,
    MAX(total_amount) OVER (PARTITION BY region) AS max_per_region,
    MAX(total_amount) OVER () AS overall_max
FROM sales_orders;

Explanation:
This query calculates the maximum total amount for each region (max_per_region) and the overall maximum (overall_max) for the entire dataset.

The MAX() function is applied using window functions to compute the results without grouping the data.

Output:

Real-life Application:
Regional Sales Analysis: By analyzing the maximum sales within each region and across the entire dataset, businesses can identify regions with the highest sales and strategize accordingly, such as increasing product availability in high-performing regions.

🧠 Findings
The use of window functions such as LAG(), LEAD(), RANK(), DENSE_RANK(), and ROW_NUMBER() significantly improved the ability to perform complex queries without the need for multiple subqueries or joins.

These functions help analyze trends, rankings, and aggregations in data over time or within partitions of the dataset.

📷 Screenshots
Here are the screenshots of the SQL query outputs and visual results:

## 📸 Creation of table data Screenshot
![Create](./screenshots/Screenshot%202025-04-17%20023043.png)

## 📸 Insertation data Screenshot
![Insert](./screenshots/Screenshot%202025-04-17%20023214.png)

## 📸 Queries Result Screenshot

-- Query 1: Compare values with LAG() and LEAD()
![Compare values with LAG() and LEAD() - Part 1](./screenshots/Screenshot%202025-04-17%20023705.png)  
![Compare values with LAG() and LEAD() - Part 2](./screenshots/Screenshot%202025-04-17%20024950.png)

-- Query 2: Ranking with RANK() and DENSE_RANK()
![Ranking with RANK() and DENSE_RANK()](./screenshots/Screenshot%202025-04-17%20025402.png)

-- Query 3: Top 3 records per region
![Top 3 Records per Region](./screenshots/Screenshot%202025-04-17%20025850.png)

-- Query 4: First 2 records per region by order_date
![First 2 Records per Region](./screenshots/Screenshot%202025-04-17%20030600.png)

-- Query 5: Aggregation with window functions
![Aggregation with Window Functions](./screenshots/Screenshot%202025-04-17%20030718.png)


Ranking with RANK() and DENSE_RANK()

Top 3 Records per Region

First 2 Records per Region

Aggregation with Window Functions

🔗 Real-Life Applications of Window Functions
Trend Analysis: Window functions allow businesses to analyze data over time without the need to aggregate everything into a single summary, making them useful for monitoring trends like sales, performance, and customer behavior.

Ranking and Prioritization: Functions like RANK() and ROW_NUMBER() help businesses rank products, customers, or employees, enabling targeted strategies such as rewards, promotions, or inventory management.

Data Aggregation: Window functions are essential for comparing aggregated data, like calculating region-wise sales maximas, with minimal query complexity.

Notes:
Findings: The ability to efficiently rank, compare, and aggregate data with minimal code makes window functions an essential tool in advanced SQL querying.

Challenges: Understanding when and how to use partitioning in window functions can be tricky, but once mastered, they significantly improve query performance and readability.