-- Citation for the following code:
--  Date: 5/29/2025
--  scope: SP for UPDATE logic
--  Originality: Adapted from UPDATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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