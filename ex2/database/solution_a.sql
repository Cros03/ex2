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
    product_price FLOAT NOT NULL,  -- S? d?ng FLOAT thay vì DOUBLE (SQL Server không h? tr? DOUBLE)
    product_description TEXT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME DEFAULT GETDATE(),  -- S? d?ng GETDATE() ?? l?y th?i gian hi?n t?i
    PRIMARY KEY (product_id)
);


CREATE TABLE orders (
    order_id INT NOT NULL, 
    user_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Ch? ??nh giá tr? m?c ??nh là th?i gian hi?n t?i
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Ch? ??nh giá tr? m?c ??nh là th?i gian hi?n t?i
    PRIMARY KEY (order_id)
);


CREATE TABLE order_details (
    order_detail_id INT NOT NULL, 
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Ch? ??nh giá tr? m?c ??nh là th?i gian hi?n t?i
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Ch? ??nh giá tr? m?c ??nh là th?i gian hi?n t?i
    PRIMARY KEY (order_detail_id)
);

-- T?o liên k?t gi?a b?ng orders và b?ng users
ALTER TABLE orders
ADD CONSTRAINT FK_orders_users FOREIGN KEY (user_id) REFERENCES users(user_id);

-- T?o liên k?t gi?a b?ng order_details và b?ng orders
ALTER TABLE order_details
ADD CONSTRAINT FK_order_details_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- T?o liên k?t gi?a b?ng order_details và b?ng products
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
