-- ============================================
-- 1. Which product categories generate the most revenue?
-- ============================================
SELECT c.product_category_name_english,
       SUM(o.price) AS revenue
FROM products p
JOIN order_items o
     ON p.product_id = o.product_id
JOIN category_translation c
     ON p.product_category_name = c.product_category_name
JOIN orders o1
     ON o.order_id = o1.order_id
WHERE lower(o1.order_status) = 'delivered'
GROUP BY 1
ORDER BY revenue DESC;

-- ============================================
-- 2. Does delivery delay affect review scores?
-- ============================================
SELECT
    CASE
        WHEN o.order_delivered_customer_date IS NULL THEN 'Not Delivered'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    ROUND(AVG(o1.review_score), 2) AS average_review,
    COUNT(*) AS num_orders
FROM orders o
JOIN order_reviews o1
    ON o.order_id = o1.order_id
GROUP BY 1
ORDER BY average_review;

-- ============================================
-- 3. Which states generate the highest sales?
-- ============================================
SELECT c.customer_state,
       SUM(o1.price) AS total_sales
FROM orders o
JOIN order_items o1
     ON o.order_id = o1.order_id
JOIN customers c
     ON o.customer_id = c.customer_id
WHERE lower(o.order_status) = 'delivered'
GROUP BY customer_state
ORDER BY total_sales DESC;

-- ============================================
-- 4. What is the average order value by payment type?
-- ============================================
SELECT payment_type,
       ROUND(AVG(payment_value), 2) AS avg_payment
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment DESC;
