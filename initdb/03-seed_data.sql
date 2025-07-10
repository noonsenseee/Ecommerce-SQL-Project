-- Insert sample users
INSERT INTO users (full_name, email, password_hash, role)
VALUES 
('Alice Buyer', 'alice@example.com', 'hashed_pass_1', 'buyer'),
('Bob Seller', 'bob@example.com', 'hashed_pass_2', 'seller'),
('Admin Guy', 'admin@example.com', 'hashed_pass_3', 'admin');

-- Insert categories
INSERT INTO categories (name, description)
VALUES 
('Electronics', 'Phones, laptops, etc.'),
('Books', 'Fiction and non-fiction'),
('Clothing', 'Men and Women');

-- Insert products
INSERT INTO products (seller_id, category_id, name, description, price, stock_quantity)
VALUES
(2, 1, 'iPhone 14', 'Latest Apple iPhone', 999.99, 50),
(2, 2, 'Atomic Habits', 'Self-help book by James Clear', 14.99, 100),
(2, 3, 'Men T-shirt', 'Cotton T-shirt', 9.99, 200);

-- Insert an order
INSERT INTO orders (buyer_id, order_status, total_amount)
VALUES (1, 'confirmed', 1024.97);

-- Insert order items
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 999.99),
(1, 2, 1, 14.99),
(1, 3, 1, 9.99);

-- Insert payment
INSERT INTO payments (order_id, payment_method, payment_status, paid_at)
VALUES (1, 'card', 'success', NOW());

-- Insert review
INSERT INTO reviews (product_id, user_id, rating, comment)
VALUES 
(1, 1, 5, 'Excellent product!'),
(2, 1, 4, 'Good book but delivery was slow.');

-- Insert inventory logs
INSERT INTO inventory_logs (product_id, change_type, quantity_change)
VALUES
(1, 'remove', 1),
(2, 'remove', 1),
(3, 'remove', 1);
