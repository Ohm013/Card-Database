-- Citation for the following code:
--  Date: 5/30/2025
--  scope: SP for INSERT logic
--  Originality: Adapted from CREATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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

    -- Example of how to get the ID of the newly created person:
        -- CALL sp_CreateOrder('Paldean Fates', '2024-02-01', @new_id);
        -- SELECT @new_id AS 'New Order ID';
END //
DELIMITER ;