-- GROUP 65 Ohm Patel and Sienna Raigoza
-- the ':' is a stand in value for CREATE, UPDATE and DELETE queries
-- The values will change when the project is updated
-- =====================================================================

-- =====================================
-- sets - Data Manipulation Queries
-- =====================================

-- CREATE: Add a new set
INSERT INTO sets (set_name, release_date)
VALUES (:set_name, :release_date);

-- READ: Get all the sets 
SELECT set_id, set_name, release_date 
FROM sets;

-- READ: Get a specific set by the ID
SELECT set_id, set_name, release_date 
FROM sets
WHERE set_id = :set_id;

-- UPDATE: update a specific set
UPDATE sets
SET set_name = :set_name, release_date = :release_date 
WHERE set_id = :set_id;

-- DELETE: Remove a set 
-- Currently not implemnted, sets will no longer be deleted on the UI
DELETE FROM sets
WHERE set_id = :set_id;

-- =====================================
-- cards - Data Manipulation Queries
-- =====================================

-- CREATE: Add a card
INSERT INTO cards (set_id, name, rarity, `condition`, type, price)
VALUES (:set_id, :name, :rarity, :condition, :type, :price);

-- READ: Get all the cards with corresponding set names
SELECT cards.card_id, cards.name, sets.set_name, cards.rarity, cards.condition, cards.type, cards.price
FROM cards
INNER JOIN sets on cards.set_id = sets.set_id;

-- READ: Get a card by the ID
SELECT cards.card_id, cards.name, sets.set_name, cards.rarity, cards.condition, cards.type, cards.price
FROM cards
INNER JOIN sets on cards.set_id = sets.set_id
WHERE cards.card_id = :card_id;

-- UPDATE: update a specific card
UPDATE cards
SET set_id = :set_id, name = :name, rarity = :rarity, `condition` = :condition, type = :type, price = :price
WHERE card_id = :card_id;

-- DELETE: deletes a card
DELETE FROM cards
WHERE card_id = :card_id;


-- =======================================
-- customers - Data Manipulation Queries
-- =======================================

-- CREATE: Add a new customer
INSERT INTO customers (first_name, last_name, email, phone_number)
VALUES (:first_name, :last_name, :email, :phone_number);

-- READ: Get all the customer information
SELECT customer_id, first_name, last_name, email, phone_number 
FROM customers;

-- READ: Get a specific customer information
SELECT customer_id, first_name, last_name, email, phone_number 
FROM customers 
WHERE customer_id = :customer_id;

-- UPDATE: Update a customer
UPDATE customers
SET first_name = :first_name, last_name = :last_name, email = :email, phone_number = :phone_number
WHERE customer_id = :customer_id;

-- DELETE: delete a customer
DELETE FROM customers
WHERE customer_id = :customer_id;

-- =====================================
-- orders - Data Manipulation Queries
-- =====================================

-- CREATE: Add a new order
INSERT INTO orders (customer_id, order_date, quantity)
VALUES (:customer_id, :order_date, :quantity);

-- READ: Get all the orders with customers names
SELECT orders.order_id, customers.first_name, customers.last_name, orders.order_date, orders.quantity
FROM orders
INNER JOIN customers on orders.customer_id = customers.customer_id;

-- READ: Get a specific Order
SELECT orders.order_id, customers.first_name, customers.last_name, orders.order_date, orders.quantity
FROM orders
INNER JOIN customers on orders.customer_id = customers.customer_id
WHERE orders.order_id = :order_id;

-- UPDATE: Update an order 
UPDATE orders
SET customer_id = :customer_id, order_date = :order_date, quantity = :quantity
WHERE order_id = :order_id;


-- DELETE: Delete an order
DELETE FROM orders
WHERE order_id = :order_id;

-- =========================================
-- orders_cards - Data Manipulation Queries
-- =========================================

-- CREATE: Add a new order-card entry
INSERT INTO orders_cards (order_id, card_id, price, quantity, total)
VALUES (:order_id, :card_id, :price, :quantity, :total);

-- READ: Get order details from the join table (orders_cards) with order and card info
SELECT orders_cards.order_card_id, orders_cards.order_id, orders_cards.card_id, cards.name AS card_name,
        orders_cards.price, orders_cards.quantity, orders_cards.total
FROM orders_cards
LEFT JOIN cards ON orders_cards.card_id = cards.card_id;

-- READ: Get order details from the primary key
SELECT orders_card_id, order_id card_id, price, quantity, total
FROM orders_cards
WHERE order_card_id= :order_card_id 

-- UPDATE: update a card id for an order-card entry
UPDATE orders_cards
SET card_id = :card_id
WHERE order_card_id = :order_card_id;

-- DELETE: delete an entry
-- Delete is not implemented in the UI, deleting is done on the order table now for MM 
DELETE FROM orders_cards
WHERE order_card_id = :order_card_id;

