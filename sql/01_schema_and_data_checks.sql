-- ============================================
-- Table inspection
-- ============================================
SELECT * FROM category_translation;
SELECT * FROM customers;
SELECT * FROM order_items;
SELECT * FROM order_payments;
SELECT * FROM order_reviews;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM sellers;

-- ============================================
-- Data quality checks
-- ============================================

-- Check 1: nulls in delivery date
SELECT COUNT(*)
FROM orders
WHERE order_delivered_customer_date IS NULL;

-- Check 2: orphan order_items (products that don't exist)
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Check 3: duplicate orders
SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check 4: order status breakdown
SELECT order_status,
       COUNT(*)
FROM orders
GROUP BY order_status
ORDER BY COUNT(*) DESC;
