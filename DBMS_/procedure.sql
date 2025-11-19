-- Stored Procedure
DELIMITER $$

CREATE PROCEDURE MergeRollCalls()
BEGIN
    DECLARE v_roll INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_exists INT;
    DECLARE done INT DEFAULT 0;

    DECLARE cur CURSOR FOR SELECT Roll_No, Name FROM N_Roll_Call;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_roll, v_name;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT COUNT(*) INTO v_exists 
        FROM O_Roll_Call WHERE Roll_No = v_roll;

        IF v_exists = 0 THEN
            INSERT INTO O_Roll_Call (Roll_No, Name) VALUES (v_roll, v_name);
            SELECT CONCAT('Inserted: ', v_roll, ' - ', v_name) AS Message;
        ELSE
            SELECT CONCAT('Skipped (Duplicate): ', v_roll) AS Message;
        END IF;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;

-- Run the procedure
CALL MergeRollCalls();
