-- Citation for the following code:
--  Date: 5/29/2025
--  scope: SP for UPDATE logic
--  Originality: Adapted from UPDATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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