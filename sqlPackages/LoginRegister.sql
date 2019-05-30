CREATE OR REPLACE PACKAGE loginRegisterFunctions IS
    FUNCTION checkRegisterDuplicate(p_username accounts.account_name%TYPE) RETURN INTEGER;
    PROCEDURE registerUSER(p_username accounts.account_name%TYPE, p_password accounts.account_password%TYPE);
    
    FUNCTION  accountDoesExist(p_username accounts.account_name%TYPE, p_password accounts.account_password%TYPE) RETURN INTEGER;
END loginRegisterFunctions;

/
CREATE OR REPLACE PACKAGE BODY loginRegisterFunctions IS
 
/*
    Checks if the username is already taken
    p_username: the username to be searched for
    RETURNS: number of users found
*/
    FUNCTION checkRegisterDuplicate(p_username accounts.account_name%TYPE) RETURN INTEGER AS
        v_found Integer;
    BEGIN
        SELECT count(id) INTO v_found FROM accounts WHERE account_name = p_username;
        RETURN v_found;
    END;
    
/*
    Inserts an account into the accounts table. CREATED_AT, UPDATED_AT will use SYSDATE atm.
    p_username: username to be inserted
    p_password: password to be inserted
*/
    PROCEDURE registerUSER(p_username accounts.account_name%TYPE, p_password accounts.account_password%TYPE) AS
        temp_id accounts.id%TYPE;
    BEGIN
        SELECT MAX(id) INTO temp_id FROM accounts;
        temp_id := temp_id + 1;
        INSERT INTO accounts VALUES(temp_id, SYSDATE, SYSDATE, p_username, p_password);
    END registerUSER;

/*
    The current login function. Checks if the credentials are a match in the accounts table
    p_username: username to be checked
    p_password: password to be checked
    RETURNS: integer if username is found, -1 otherwise
*/ 
    FUNCTION accountDoesExist(p_username accounts.account_name%TYPE, p_password accounts.account_password%TYPE)RETURN INTEGER AS
        v_found accounts.id%TYPE;
    BEGIN
        SELECT COUNT(id) INTO v_found FROM accounts WHERE account_name = p_username AND account_password = p_password;
        if(SQL%NOTFOUND) THEN 
            RETURN -1;
        END IF;
        RETURN v_found;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN -1;
    END;
END loginRegisterFunctions;

