CREATE OR REPLACE PACKAGE gameFunctions IS
    FUNCTION getVillagesByAccountId(p_accountId empire.id_account%TYPE) RETURN villages%ROWTYPE;
    PROCEDURE getVillagesByAccountIdCursor(p_accountId IN empire.id_account%TYPE, returnCursor OUT SYS_REFCURSOR);
END gameFunctions;
/

CREATE OR REPLACE PACKAGE BODY gameFunctions IS

    FUNCTION getVillagesByAccountId(p_accountId empire.id_account%TYPE)  RETURN villages%ROWTYPE AS
        CURSOR villages_cursor IS
            SELECT v.* FROM empire e JOIN villages v ON v.id = e.id_village AND e.id_account = p_accountId;
        villages_row villages_cursor%ROWTYPE;

        TYPE villageList IS VARRAY(1000000) OF villages_cursor%ROWTYPE;
        returnList villageList := villageList();
        contor INTEGER := 0;
    BEGIN
        FOR villages_row IN villages_cursor LOOP
            contor := contor + 1;
            returnList.extend;
            returnList(contor) := villages_row;
            --DBMS_OUTPUT.PUT_LINE(villages_row.id || villages_row.name || villages_row.position_x || villages_row.position_y);
        END LOOP;
    END;
    
    PROCEDURE getVillagesByAccountIdCursor(p_accountId IN empire.id_account%TYPE, returnCursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN returnCursor FOR
            SELECT v.* FROM empire e JOIN villages v ON v.id = e.id_village AND e.id_account = p_accountId;
    END getVillagesByAccountIdCursor;


END gameFunctions;

