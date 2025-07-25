-- GROUP 65 Ohm Patel and Sienna Raigoza
-- this file corresponds to the CS340 Portfolio Project deliverables
-- Date: 5/20/2025
-- scope: Wrapper for Pl/SQL
-- Originality: Adapted from CREATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968


DROP PROCEDURE IF EXISTS sp_reset_db;

DELIMITER //
CREATE PROCEDURE sp_reset_db()
BEGIN
-- Disable foreign key checks and autocommit 
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

-- Drop tables if they exist to avoid errors
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS orders_cards;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS cards;
DROP TABLE IF EXISTS sets;

-- =======================
-- TABLES
-- =======================

-- Table sets: 
-- Description: The pokemon cards come from a set of cards, customers can buy the set or individual cards
CREATE TABLE sets (
    set_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    set_name VARCHAR(145) NOT NULL,
    release_date DATE NOT NULL
);

-- Table cards:
-- Description: The details of the pokemon card (price, condition, name, etc)
CREATE TABLE cards (
    card_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    set_id INT, 
    name VARCHAR(145) NOT NULL,
    rarity VARCHAR(145) NOT NULL,
    `condition` ENUM('Mint', 'Near Mint', 'Good', 'Fair', 'Poor') NOT NULL,
    type VARCHAR(145) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(set_id) REFERENCES sets(set_id) ON DELETE SET NULL
);

-- Table customers:
-- Description: records the details for the customer
CREATE TABLE customers (
    customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(145) NOT NULL,
    last_name VARCHAR(145) NOT NULL,
    email VARCHAR(145) NOT NULL,
    phone_number VARCHAR(145) NOT NULL
);

-- Table orders:
-- Description: Records teh details of a order made by a customer
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,  
    customer_id INT,
    order_date DATETIME NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL
);

-- Table order_cards:
-- Description: A join table that combines orders and cards
CREATE TABLE orders_cards (
	order_card_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    card_id INT,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY(card_id) REFERENCES cards(card_id) ON DELETE SET NULL
);

-- ===================
-- Inserting DATA
-- ===================

-- Insert customers
INSERT INTO customers (first_name, last_name, email, phone_number)
VALUES 
    ('James', 'King', 'jamesk@gmail.com', '489-657-0219'),
    ('Britney', 'Gonazales', 'britg1@gmail.com', '210-456-9378'),
    ('Nick', 'Hill', 'nick_h@gmail.com', '818-768-2341'),
    ('Elizabeth', 'Rodriguez', 'elizabethr@gmail.com', '832-723-9432');

-- Insert sets
INSERT INTO sets (set_name, release_date)
VALUES
('Surging Sparks', '2024-11-08'),
('Paldean Fates', '2024-01-26'),
('Scarlet & Violet 151', '2023-09-22');

-- Insert cards
INSERT INTO cards (set_id, name, rarity, `condition`, type, price)
VALUES
((SELECT set_id FROM sets WHERE set_name = 'Surging Sparks'), 'Pikachu EX', 'Rare', 'Near Mint', 'Electric', 318.00),
((SELECT set_id FROM sets WHERE set_name = 'Paldean Fates'), 'Mew EX', 'Rare', 'Good', 'Psychic', 300.00),
((SELECT set_id FROM sets WHERE set_name = 'Scarlet & Violet 151'), 'Charizard ex', 'Rare', 'Good', 'Fire', 205.00),
((SELECT set_id FROM sets WHERE set_name = 'Surging Sparks'), 'Milotic ex', 'Rare', 'Near Mint', 'Water', 150.00);

-- Insert orders
-- Order 1: Britney
-- Order 2: Nick
-- Order 3: Elizabeth
INSERT INTO orders(customer_id, order_date, quantity)
VALUES
    ((SELECT customer_id FROM customers WHERE email = 'britg1@gmail.com'), '2025-04-30 10:30:00', 2),
    ((SELECT customer_id FROM customers WHERE email = 'nick_h@gmail.com'), '2025-02-14 08:30:00', 3),
    ((SELECT customer_id FROM customers WHERE email = 'elizabethr@gmail.com'), '2025-03-15 11:30:00', 4);

-- Insert orders_cards data
-- Order 1: Britney - 2x Pikachu EX
INSERT INTO orders_cards (order_id, card_id, price, quantity, total)
VALUES
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'britg1@gmail.com') 
AND order_date = '2025-04-30 10:30:00'), 
(SELECT card_id FROM cards WHERE name = 'Pikachu EX'), 318.00, 2, 636.00);

-- Order 2: Nick - 2x Charizard ex, 1x Mew EX
INSERT INTO orders_cards (order_id, card_id, price, quantity, total)
VALUES
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'nick_h@gmail.com') 
AND order_date = '2025-02-14 08:30:00'), 
(SELECT card_id FROM cards WHERE name = 'Charizard ex'), 205.00, 2, 410.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'nick_h@gmail.com') 
AND order_date = '2025-02-14 08:30:00'), 
(SELECT card_id FROM cards WHERE name = 'Mew EX'), 300.00, 1, 300.00);

-- Order 3: Elizabeth - 2x Pikachu EX, 1x Mew EX, 1x Milotic ex
INSERT INTO orders_cards (order_id, card_id, price, quantity, total)
VALUES
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'elizabethr@gmail.com') 
AND order_date = '2025-03-15 11:30:00'), 
(SELECT card_id FROM cards WHERE name = 'Pikachu EX'), 318.00, 2, 636.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'elizabethr@gmail.com') 
AND order_date = '2025-03-15 11:30:00'), 
(SELECT card_id FROM cards WHERE name = 'Mew EX'), 300.00, 1, 300.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'elizabethr@gmail.com') 
AND order_date = '2025-03-15 11:30:00'), 
(SELECT card_id FROM cards WHERE name = 'Milotic ex'), 150.00, 1, 150.00);

-- enable foreing key check 
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;

end //

DELIMITER  ;
