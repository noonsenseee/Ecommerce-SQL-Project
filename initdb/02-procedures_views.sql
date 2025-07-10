-- VIEW: Sales Summary
CREATE OR REPLACE VIEW view_sales_summary AS
SELECT 
    p.name AS product,
    c.name AS category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM 
    order_items oi
JOIN 
    products p ON oi.product_id = p.id
JOIN 
    categories c ON p.category_id = c.id
GROUP BY 
    p.id, p.name, c.name;

-- PROCEDURE: Place Order
DELIMITER $$

CREATE PROCEDURE place_order(
    IN buyerId INT,
    IN productId INT,
    IN quantity INT
)
BEGIN
    DECLARE price DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    -- Get product price
    SELECT p.price INTO price
    FROM products p
    WHERE p.id = productId;

    -- Calculate total
    SET total = price * quantity;

    -- Create order
    INSERT INTO orders (buyer_id, total_amount)
    VALUES (buyerId, total);

    -- Get last order_id
    SET @order_id = LAST_INSERT_ID();

    -- Insert order items
    INSERT INTO order_items (order_id, product_id, quantity, price)
    VALUES (@order_id, productId, quantity, price);

    -- Insert payment
    INSERT INTO payments (order_id, payment_method, payment_status, paid_at)
    VALUES (@order_id, 'card', 'success', NOW());

    -- Update stock
    UPDATE products
    SET stock_quantity = stock_quantity - quantity
    WHERE id = productId;

    -- Inventory log
    INSERT INTO inventory_logs (product_id, change_type, quantity_change)
    VALUES (productId, 'remove', quantity);
END $$

DELIMITER ;

-- PROCEDURE: Adjust Stock
DELIMITER $$

CREATE PROCEDURE adjust_stock(
    IN productId INT,
    IN changeType ENUM('add', 'remove', 'adjust'),
    IN quantity INT
)
BEGIN
    IF changeType = 'add' THEN
        UPDATE products SET stock_quantity = stock_quantity + quantity WHERE id = productId;
    ELSEIF changeType = 'remove' THEN
        UPDATE products SET stock_quantity = stock_quantity - quantity WHERE id = productId;
    ELSE
        UPDATE products SET stock_quantity = quantity WHERE id = productId;
    END IF;

    -- Inventory log
    INSERT INTO inventory_logs (product_id, change_type, quantity_change)
    VALUES (productId, changeType, quantity);
END $$

DELIMITER ;
