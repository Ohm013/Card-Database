-- Citation for the following code:
--  Date: 5/31/2025
--  scope: SP for UPDATE logic
--  Originality: Adapted from UPDATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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