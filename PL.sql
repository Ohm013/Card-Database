-- GROUP 65 Ohm Patel and Sienna Raigoza
-- Citation for the following code:
--  Date: 5/20/2025
-- scope: SP for INSERT, UPDATE, DELETE logic
-- Originality: Adapted from CREATE, UPDATE, DELETE Stored procedures on exploration page
-- Canvas, CS 340 Module 8, Exploration - Implementing CUD operations in your app
-- Adapted code was used for all entities cards, sets, orders, customers, orders_cards
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- =======================
-- =======================
-- cards CUD
-- =======================
-- =======================

-- #############################
-- CREATE pokemon card
-- #############################
DROP PROCEDURE IF EXISTS sp_CreateCard;

DELIMITER //
CREATE PROCEDURE sp_CreateCard(
    IN card_name VARCHAR(145), 
    IN card_rarity VARCHAR(145),
    IN card_condition ENUM('Mint', 'Near Mint', 'Good', 'Fair', 'Poor'),
    IN card_type VARCHAR(145),  
    IN card_price DECIMAL(10,2), 
    IN card_set INT,
    OUT card_num INT
)
BEGIN
    INSERT INTO cards (name, rarity, `condition`, type, price, set_id) 
    VALUES (card_name, card_rarity, card_condition, card_type, card_price, card_set);

    -- Store the ID of the last inserted row
    -- SELECT LAST_INSERT_ID() into card_num;
    -- Display the ID of the last inserted card.
    SELECT LAST_INSERT_ID() INTO card_num;
    SELECT card_num AS 'new_id';
    -- SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example:
        -- CALL sp_CreateCard('Pikachu', 'Rare', 'Near Mint', 'Electric', 15, @new_id);
        -- SELECT @new_id AS 'New Card ID';
END //
DELIMITER ;

-- #############################
-- UPDATE pokemon card
-- #############################
DROP PROCEDURE IF EXISTS sp_UpdateCard;

DELIMITER //
CREATE PROCEDURE sp_UpdateCard(
    IN u_card_id INT, 
    IN u_card_name VARCHAR(145), 
    IN u_card_rarity VARCHAR(145),
    IN u_card_condition ENUM('Mint', 'Near Mint', 'Good', 'Fair', 'Poor'),
    IN u_card_type VARCHAR(145),  
    IN u_card_price DECIMAL(10,2), 
    IN u_card_set INT
)
BEGIN
    UPDATE cards 
    SET 
    `name` = u_card_name, 
    rarity = u_card_rarity, 
    `condition` = u_card_condition, 
    `type` = u_card_type, 
    price = u_card_price, 
    set_id = u_card_set
    WHERE card_id = u_card_id;

END //
DELIMITER ;

-- #############################
-- DELETE Card
-- #############################
DROP PROCEDURE IF EXISTS sp_DeleteCard;

DELIMITER //
CREATE PROCEDURE sp_DeleteCard(IN u_card_id INT)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;
        -- Deleting the card by ID
        DELETE FROM cards WHERE card_id = u_card_id;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in cards for id: ', u_card_id);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- ================================================
-- ================================================
-- sets CU 
-- note that sets will not / should not be deleted
-- =================================================
-- =================================================

-- #############################
-- CREATE Set
-- #############################
DROP PROCEDURE IF EXISTS sp_CreateSet;

DELIMITER //
CREATE PROCEDURE sp_CreateSet(
    IN p_set_name VARCHAR(255), 
    IN p_release_date DATE,
    OUT new_id INT
) 

BEGIN
    INSERT INTO sets (set_name, release_date)
    VALUES (p_set_name, p_release_date);

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into new_id;
    -- Display the ID of the last inserted set.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created person:
        -- CALL sp_CreateSet('Paldean Fates', '2024-02-01', @new_id);
        -- SELECT @new_id AS 'New Set ID';
END //
DELIMITER ;

-- #############################
-- UPDATE set
-- #############################

DROP PROCEDURE IF EXISTS sp_UpdateSet;

DELIMITER //
CREATE PROCEDURE sp_UpdateSet(
    IN u_set_id INT, 
    IN u_set_name VARCHAR(255), 
    IN u_release_date DATE
    )

BEGIN
    UPDATE `sets` 
    SET 
    set_name = u_set_name,
    release_date = u_release_date
    WHERE set_id = u_set_id; 
END //
DELIMITER ;

-- =======================
-- =======================
-- customers CUD
-- =======================
-- =======================

-- #############################
-- CREATE customer
-- #############################
DROP PROCEDURE IF EXISTS sp_CreateCustomer;

DELIMITER //
CREATE PROCEDURE sp_CreateCustomer(
    IN p_first_name VARCHAR(255), 
    IN p_last_name VARCHAR(255), 
    IN p_email VARCHAR(255), 
    IN p_phone VARCHAR(255),
    OUT new_customer_id INT)
BEGIN
    INSERT INTO customers (first_name, last_name, email, phone_number)
    VALUES (p_first_name, p_last_name, p_email, p_phone);

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into new_customer_id;
    -- Display the ID of the last inserted customer.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example:
        -- CALL sp_CreateCustomer('Theresa', 'Evans', abc@example.com, 1234567, @new_id);
        -- SELECT @new_id AS 'New Customer ID';
END //
DELIMITER ;


-- #############################
-- UPDATE customer
-- #############################
DROP PROCEDURE IF EXISTS sp_UpdateCustomer;

DELIMITER //
CREATE PROCEDURE sp_UpdateCustomer(
    IN p_customer_id INT, 
    IN p_first_name VARCHAR(255), 
    IN p_last_name VARCHAR(255), 
    IN p_email VARCHAR(255), 
    IN p_phone VARCHAR(255)
    )

BEGIN
    UPDATE customers 
    SET 
    first_name = p_first_name, 
    last_name = p_last_name, 
    email = p_email, 
    phone_number = p_phone
    WHERE customer_id = p_customer_id;
END //
DELIMITER ;

-- #############################
-- DELETE customer
-- #############################
DROP PROCEDURE IF EXISTS sp_DeleteCustomer;

DELIMITER //
CREATE PROCEDURE sp_DeleteCustomer(IN p_customer_id INT)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;

        -- delete customers
        -- order history will keep the data but the customer id will be set to null
        DELETE FROM customers WHERE customer_id = p_customer_id;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in customers for id: ', p_customer_id);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- =======================
-- =======================
-- orders CUD
-- =======================
-- =======================

-- #############################
-- CREATE Order
-- #############################
DROP PROCEDURE IF EXISTS sp_CreateOrder;

DELIMITER //
CREATE PROCEDURE sp_CreateOrder(
    IN o_customer_id INT, 
    IN o_order_date DATE,
    IN o_quantity INT,
    IN o_card_id INT,
    OUT new_id INT
) 

BEGIN
    -- local variables
    DECLARE card_price DECIMAL(10,2);
    DECLARE order_total DECIMAL(10,2);

    START TRANSACTION;

    INSERT INTO orders (customer_id, order_date, quantity)
    VALUES (o_customer_id, o_order_date, o_quantity);

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into new_id;

    -- look up the price of the card
    SELECT price INTO card_price from cards WHERE card_id = o_card_id;

    -- calculate total
    SET order_total = card_price * o_quantity;

    -- insert into join table
    INSERT INTO orders_cards(order_id, card_id, price, quantity, total)
    VALUES (new_id, o_card_id, card_price, o_quantity, order_total);


    COMMIT;

    SELECT new_id AS 'new_id';

    -- Example:
        -- CALL sp_CreateOrder(1, '2024-02-01', 2, 5, @new_id);
        -- SELECT @new_id AS 'New Order ID';
END //
DELIMITER ;

-- Citation for the following code:
-- Date: 6/1/2025
-- scope: SP for orders table when recalculating quantity from join table
-- Originality: Adapted with AI, to fix and troubleshoot logic 
-- Summary of prompts used to generate PL/SQL:
-- (Explain degree of originality)
-- Using the following schema on MariaDB for Pokémon database DB [copy and paste the entire DDL for DDL.sql here], can you help me figure out why when 
-- I update an order in the sp_updateOrder.sql [copy and paste the entire DDL for DDL.sql here] why the quantity won't update when 
-- I update a card for an order that has multiple cards in it? 
-- I needed to find the total quantity using SUM() for all the orders_cards entries and use a subquery to update it in orders.
--  AI Source URL: https://chat.openai.com

-- #############################
-- UPDATE Orders
-- #############################

DROP PROCEDURE IF EXISTS sp_UpdateOrder;

DELIMITER //
CREATE PROCEDURE sp_UpdateOrder(
    IN p_order_card_id INT, 
    IN p_order_date DATE,
    IN p_quantity INT,
    IN p_card_id INT
    )

BEGIN
    -- local variables
    DECLARE card_price DECIMAL(10,2);
    DECLARE order_total DECIMAL(10,2);
    DECLARE o_id INT;
    
    START TRANSACTION;

    -- get the specific order ID
    SELECT order_id INTO o_id FROM orders_cards WHERE order_card_id = p_order_card_id;

    UPDATE orders 
    SET 
    order_date = p_order_date
    WHERE order_id = o_id; 

    -- look up the price of the card
    SELECT price INTO card_price from cards WHERE card_id = p_card_id;

    -- calculate total
    SET order_total = card_price * p_quantity;

    -- UPDATE join TABLE
    UPDATE orders_cards
    SET 
    card_id = p_card_id,
    price = card_price,
    quantity = p_quantity,
    total = order_total
    WHERE order_card_id = p_order_card_id;

    -- update the total quantity
    UPDATE orders
    SET quantity = (
        SELECT IFNULL(SUM(quantity), 0)
        FROM orders_cards
        WHERE order_id = o_id
    )
    WHERE order_id = o_id;

    COMMIT;

END //
DELIMITER ;

-- #############################
-- DELETE order
-- #############################
DROP PROCEDURE IF EXISTS sp_DeleteOrder;

DELIMITER //
CREATE PROCEDURE sp_DeleteOrder(IN o_id INT)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;

        --  Delete the order
        DELETE FROM orders WHERE order_id = o_id;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in order for id: ', o_id);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- =======================
-- =======================
-- orders_cards UPDATE
-- =======================
-- =======================

-- #############################
-- UPDATE orders_cards
-- #############################
DROP PROCEDURE IF EXISTS sp_UpdateOrderCard;

DELIMITER //
CREATE PROCEDURE sp_UpdateOrderCard(
    IN p_order_card_id INT, 
    IN p_card_id INT
)
BEGIN
    -- local variables
    DECLARE card_price DECIMAL(10,2);
    DECLARE new_total DECIMAL(10,2);
    DECLARE card_quantity INT;

    -- look up the price of the card
    SELECT price INTO card_price from cards WHERE card_id = p_card_id;

    -- get the quantity
    SELECT quantity INTO card_quantity FROM orders_cards WHERE order_card_id = p_order_card_id;

    -- calculate total
    SET new_total = card_price * card_quantity;

    UPDATE orders_cards 
    SET 
    card_id = p_card_id,
    price = card_price,
    total = new_total
    WHERE order_card_id = p_order_card_id;

END //
DELIMITER ;