-- Citation for the following code:
--  Date: 5/20/2025
--  scope: SP for INSERT logic
--  Originality: Adapted from CREATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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

    -- Example of how to get the ID of the newly created person:
        -- CALL sp_CreatePerson('Theresa', 'Evans', 2, 48, @new_id);
        -- SELECT @new_id AS 'New Person ID';
END //
DELIMITER ;