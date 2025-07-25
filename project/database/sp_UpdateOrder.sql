-- Citation for the following code:
--  Date: 5/30/2025
--  scope: SP for UPDATE logic
--  Originality: Adapted from UPDATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968
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