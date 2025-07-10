-- 1. Total Sales Report (per product)
SELECT 
    p.name AS product,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM 
    order_items oi
JOIN 
    products p ON oi.product_id = p.id
GROUP BY 
    p.name
ORDER BY 
    total_revenue DESC;

-- 2. Top 3 Selling Categories
SELECT 
    c.name AS category,
    SUM(oi.quantity) AS total_sold
FROM 
    order_items oi
JOIN 
    products p ON oi.product_id = p.id
JOIN 
    categories c ON p.category_id = c.id
GROUP BY 
    c.name
ORDER BY 
    total_sold DESC
LIMIT 3;

-- 3. Customer Order History
SELECT 
    u.full_name,
    o.id AS order_id,
    o.order_status,
    o.total_amount,
    o.created_at
FROM 
    users u
JOIN 
    orders o ON u.id = o.buyer_id
ORDER BY 
    u.full_name, o.created_at DESC;

-- 4. Average Product Rating
SELECT 
    p.name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.id) AS total_reviews
FROM 
    reviews r
JOIN 
    products p ON r.product_id = p.id
GROUP BY 
    p.name
ORDER BY 
    avg_rating DESC;

-- 5. Low Stock Alert (<10 units)
SELECT 
    name,
    stock_quantity
FROM 
    products
WHERE 
    stock_quantity < 10;

-- 6. Daily Revenue Trend (last 7 days)
SELECT 
    DATE(p.paid_at) AS date,
    SUM(o.total_amount) AS revenue
FROM 
    payments p
JOIN 
    orders o ON p.order_id = o.id
WHERE 
    p.paid_at >= CURDATE() - INTERVAL 7 DAY
GROUP BY 
    DATE(p.paid_at)
ORDER BY 
    date DESC;

-- 7. Inventory Change Summary
SELECT 
    p.name,
    il.change_type,
    SUM(il.quantity_change) AS total_change
FROM 
    inventory_logs il
JOIN 
    products p ON il.product_id = p.id
GROUP BY 
    p.name, il.change_type
ORDER BY 
    p.name, il.change_type;
