-- Citation for the following code:
--  Date: 5/20/2025
--  scope: SP for INSERT logic
--  Originality: Adapted from CREATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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
    -- Display the ID of the last inserted person.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created person:
        -- CALL sp_CreateCustomer('Theresa', 'Evans', abc@example.com, 1234567, @new_id);
        -- SELECT @new_id AS 'New Customer ID';
END //
DELIMITER ;