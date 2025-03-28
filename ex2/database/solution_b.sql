create database Ex2 

CREATE TABLE users (
    user_id INT  NOT NULL,
    user_name VARCHAR(25) NOT NULL,
    user_email VARCHAR(55) NOT NULL,
    user_pass VARCHAR(255) NOT NULL,
    updated_at DATETIME,
    created_at DATETIME,
    PRIMARY KEY (user_id)
);

CREATE TABLE products (
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_price FLOAT NOT NULL,  -- Sử dụng FLOAT thay vì DOUBLE (SQL Server không hỗ trợ DOUBLE)
    product_description TEXT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME DEFAULT GETDATE(),  -- Sử dụng GETDATE() để lấy thời gian hiện tại
    PRIMARY KEY (product_id)
);


CREATE TABLE orders (
    order_id INT NOT NULL, 
    user_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Chỉ định giá trị mặc định là thời gian hiện tại
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Chỉ định giá trị mặc định là thời gian hiện tại
    PRIMARY KEY (order_id)
);


CREATE TABLE order_details (
    order_detail_id INT NOT NULL, 
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Chỉ định giá trị mặc định là thời gian hiện tại
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Chỉ định giá trị mặc định là thời gian hiện tại
    PRIMARY KEY (order_detail_id)
);

-- Tạo liên kết giữa bảng orders và bảng users
ALTER TABLE orders
ADD CONSTRAINT FK_orders_users FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Tạo liên kết giữa bảng order_details và bảng orders
ALTER TABLE order_details
ADD CONSTRAINT FK_order_details_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- Tạo liên kết giữa bảng order_details và bảng products
ALTER TABLE order_details
ADD CONSTRAINT FK_order_details_products FOREIGN KEY (product_id) REFERENCES products(product_id);

INSERT INTO users (user_id, user_name, user_email, user_pass, updated_at, created_at) 
VALUES 
(1, 'John Doe', 'johndoe@gmail.com', 'password123', GETDATE(), GETDATE()),
(2, 'Jane Smith', 'janesmith@gmail.com', 'password123', GETDATE(), GETDATE()),
(3, 'Michael Brown', 'michaelbrown@gmail.com', 'password123', GETDATE(), GETDATE()),
(4, 'Emily Davis', 'emilydavis@yahoo.com', 'password123', GETDATE(), GETDATE()),
(5, 'Sarah Lee', 'sarahlee@gmail.com', 'password123', GETDATE(), GETDATE());

INSERT INTO products (product_id, product_name, product_price, product_description, updated_at, created_at) 
VALUES
(1, 'Samsung Galaxy S21', 799.99, 'Latest model of Samsung Galaxy S series', GETDATE(), GETDATE()),
(2, 'Apple iPhone 13', 999.99, 'Newest iPhone with A15 Bionic chip', GETDATE(), GETDATE()),
(3, 'MacBook Pro 13', 1299.99, 'Apple laptop with M1 chip', GETDATE(), GETDATE()),
(4, 'Apple Watch Series 7', 399.99, 'Smartwatch by Apple with health tracking features', GETDATE(), GETDATE()),
(5, 'Sony WH-1000XM4', 348.00, 'Wireless Noise Cancelling Headphones', GETDATE(), GETDATE());


INSERT INTO orders (order_id, user_id, updated_at, created_at) 
VALUES
(1, 1, GETDATE(), GETDATE()),
(2, 2, GETDATE(), GETDATE()),
(3, 3, GETDATE(), GETDATE()),
(4, 4, GETDATE(), GETDATE()),
(5, 5, GETDATE(), GETDATE());

INSERT INTO order_details (order_detail_id, order_id, product_id, updated_at, created_at) 
VALUES
(1, 1, 1, GETDATE(), GETDATE()),  -- John Doe bought Samsung Galaxy S21
(2, 1, 3, GETDATE(), GETDATE()),  -- John Doe also bought MacBook Pro 13
(3, 2, 2, GETDATE(), GETDATE()),  -- Jane Smith bought iPhone 13
(4, 3, 1, GETDATE(), GETDATE()),  -- Michael Brown bought Samsung Galaxy S21
(5, 3, 4, GETDATE(), GETDATE()),  -- Michael Brown also bought Apple Watch Series 7
(6, 4, 5, GETDATE(), GETDATE()),  -- Emily Davis bought Sony WH-1000XM4
(7, 5, 2, GETDATE(), GETDATE());  -- Sarah Lee bought iPhone 13

--cau a

--1
SELECT * FROM users
ORDER BY user_name ASC;

--2
SELECT TOP 7 * FROM users
ORDER BY user_name ASC;

--3
SELECT * FROM users
WHERE user_name LIKE '%a%'
ORDER BY user_name ASC;

--4
SELECT * FROM users
WHERE user_name LIKE 'm%'
ORDER BY user_name ASC;


--5
SELECT * FROM users
WHERE user_name LIKE '%i'
ORDER BY user_name ASC;


--6
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com';


--7
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE 'm%';


--8
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE '%i%'
AND LEN(user_name) > 5;


--9
SELECT * FROM users
WHERE user_name LIKE '%a%'
AND LEN(user_name) BETWEEN 5 AND 9
AND user_email LIKE '%@gmail.com'
AND user_email LIKE '%i%';


--10
SELECT * FROM users
WHERE (user_name LIKE '%a%' AND LEN(user_name) BETWEEN 5 AND 9)
OR (user_name LIKE '%i%' AND LEN(user_name) < 9)
OR (user_email LIKE '%@gmail.com' AND user_email LIKE '%i%');


-- cau b
--1
SELECT o.order_id, u.user_id, u.user_name
FROM orders o
JOIN users u ON o.user_id = u.user_id;


--2
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS order_count
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.user_name;

--3
SELECT o.order_id, COUNT(od.order_detail_id) AS product_count
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;


--4
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id, u.user_id;


--5
SELECT TOP 7 u.user_id, u.user_name, COUNT(o.order_id) AS order_count
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.user_name
ORDER BY order_count DESC;


--6
SELECT TOP 7 u.user_id, u.user_name, o.order_id, p.product_name
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%'
ORDER BY o.order_id;


--7
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_price
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;


--8
WITH MaxOrderPrice AS (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_price
    FROM orders o
    JOIN users u ON o.user_id = u.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_price
FROM MaxOrderPrice
WHERE total_price = (SELECT MAX(total_price) FROM MaxOrderPrice WHERE user_id = MaxOrderPrice.user_id);


--9
WITH MinOrderPrice AS (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_price, COUNT(od.order_detail_id) AS product_count
    FROM orders o
    JOIN users u ON o.user_id = u.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_price, product_count
FROM MinOrderPrice
WHERE total_price = (SELECT MIN(total_price) FROM MinOrderPrice WHERE user_id = MinOrderPrice.user_id);

--10
WITH MaxProductCount AS (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_price, COUNT(od.order_detail_id) AS product_count
    FROM orders o
    JOIN users u ON o.user_id = u.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_price, product_count
FROM MaxProductCount
WHERE product_count = ( SELECT MAX(product_count)
    FROM MaxProductCount AS subquery
    WHERE subquery.user_id = MaxProductCount.user_id
);

