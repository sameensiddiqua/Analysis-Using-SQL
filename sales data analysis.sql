/*  total revnue*/
select sum(total_price) as total_revenue from pizzadb.pizza;
/* Average Order Value */
select (sum(total_price)/ count(distinct order_id)) as avg_order_value from pizzadb.pizza;
/* total pizzas sold */
select sum(quantity) as total_pizza_sold from pizzadb.pizza;
/* total orders */
select count(distinct order_id) as total_orders from pizzadb.pizza;
/*Average pizzas per order */
SELECT CAST(SUM(quantity) AS DECIMAL(10, 2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS avg_pizzas_per_order
FROM pizzadb.pizza;
/*  Daily Trend for Total Orders*/
SELECT 
  CASE 
    WHEN DAYNAME(STR_TO_DATE(order_date, '%e-%c-%Y')) = 'Monday' THEN 'Monday'
    WHEN DAYNAME(STR_TO_DATE(order_date, '%e-%c-%Y')) = 'Tuesday' THEN 'Tuesday'
    WHEN DAYNAME(STR_TO_DATE(order_date, '%e-%c-%Y')) = 'Wednesday' THEN 'Wednesday'
    WHEN DAYNAME(STR_TO_DATE(order_date, '%e-%c-%Y')) = 'Thursday' THEN 'Thursday'
    WHEN DAYNAME(STR_TO_DATE(order_date, '%e-%c-%Y')) = 'Friday' THEN 'Friday'
    WHEN DAYNAME(STR_TO_DATE(order_date, '%e-%c-%Y')) = 'Saturday' THEN 'Saturday'
    WHEN DAYNAME(STR_TO_DATE(order_date, '%e-%c-%Y')) = 'Sunday' THEN 'Sunday'
  END AS order_day,
  COUNT(DISTINCT order_id) AS total_orders 
FROM pizzadb.pizza
GROUP BY order_day
order by total_orders;
/*Monthly Trend for Orders*/
SELECT 
  MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_name, 
  COUNT(DISTINCT order_id) AS total_orders
FROM pizzadb.pizza
WHERE order_date IS NOT NULL
GROUP BY month_name;
/* % of Sales by Pizza Category */
select pizza_category, cast(sum(total_price) as decimal(10,2))as total_revenue, cast(sum(total_price)*100/ (SELECT SUM(total_price) from pizzadb.pizza
) AS DECIMAL(10,2)) AS PCT
FROM pizzadb.pizza
GROUP BY pizza_category;
/* % sales by pizza size */
select pizza_size, cast(sum(total_price) as decimal(10,2))as total_revenue, cast(sum(total_price)*100/ (SELECT SUM(total_price) from pizzadb.pizza
) AS DECIMAL(10,2)) AS PCT
FROM pizzadb.pizza
GROUP BY pizza_size;
/*Total pizzas sold by pizza category*/
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizzadb.pizza
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;
/*Top 5 Pizzas by Revenue*/
SELECT pizza_name, SUM(total_price) AS total_revenue FROM pizzadb.pizza
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;
/*Bottom 5 Pizzas by Revenue*/
SELECT pizza_name, SUM(total_price) AS total_revenue FROM pizzadb.pizza
GROUP BY pizza_name
ORDER BY total_revenue asc
LIMIT 5;
/* Top 5 Pizzas by Quantity*/
SELECT pizza_name, SUM(quantity) AS total_quantity FROM pizzadb.pizza
GROUP BY pizza_name
ORDER BY total_quantity desc
LIMIT 5;
/* Bottom 5 Pizzas by Quantity*/
SELECT pizza_name, SUM(quantity) AS total_quantity FROM pizzadb.pizza
GROUP BY pizza_name
ORDER BY total_quantity asc
LIMIT 5;
/*Top 5 Pizzas by Total Orders*/
SELECT pizza_name, count(distinct order_id) total_orders FROM pizzadb.pizza
GROUP BY pizza_name
ORDER BY total_orders desc
LIMIT 5;
/* Bottom 5 Pizzas by Total Orders*/
SELECT pizza_name, count(distinct order_id) total_orders FROM pizzadb.pizza
GROUP BY pizza_name
ORDER BY total_orders asc
LIMIT 5;







  
