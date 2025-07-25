-- Citation for the following code:
--  Date: 5/20/2025
--  scope: SP for UPDATE logic
--  Originality: Adapted from UPDATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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