create or replace PACKAGE gameFunctions IS
    PROCEDURE getVillagesByAccountIdCursor(p_accountId IN villages.id_account%TYPE, returnCursor OUT SYS_REFCURSOR);
    PROCEDURE getAllVillages(p_gameId IN games.id%TYPE , returnCursor OUT SYS_REFCURSOR);
    FUNCTION  getAccountIdByName(p_accountName accounts.account_name%TYPE) RETURN INTEGER;
END gameFunctions;
/

CREATE OR REPLACE PACKAGE BODY gameFunctions IS

    PROCEDURE getVillagesByAccountIdCursor(p_accountId IN villages.id_account%TYPE, returnCursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN returnCursor FOR
            SELECT * FROM villages WHERE id_account = p_accountId;
    END getVillagesByAccountIdCursor;
    
    PROCEDURE getAllVillages(p_gameId IN games.id%TYPE , returnCursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN returnCursor FOR
            SELECT * FROM villages WHERE id_game = p_gameId ORDER BY position_x, position_y;
    END getAllVillages;

    FUNCTION  getAccountIdByName(p_accountName accounts.account_name%TYPE) RETURN INTEGER IS
        returnId INTEGER;
    BEGIN
        SELECT id INTO returnId FROM accounts WHERE account_name = p_accountName;
        RETURN returnId;
    END;
END gameFunctions;

