-- Citation for the following code:
--  Date: 5/29/2025
--  scope: SP for INSERT logic
--  Originality: Adapted from CREATE Stored procedure on exploration page
-- Exploration - Implementing CUD operations in your app
-- Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

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
    -- Display the ID of the last inserted person.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created person:
        -- CALL sp_CreateSet('Paldean Fates', '2024-02-01', @new_id);
        -- SELECT @new_id AS 'New Set ID';
END //
DELIMITER ;