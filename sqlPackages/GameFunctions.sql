create or replace PACKAGE gameFunctions IS
    PROCEDURE updateResources;

    PROCEDURE getVillagesByAccountIdCursor(p_accountId IN villages.id_account%TYPE, returnCursor OUT SYS_REFCURSOR);
    PROCEDURE getAllVillages(p_gameId IN games.id%TYPE , returnCursor OUT SYS_REFCURSOR);
    FUNCTION  getAccountIdByName(p_accountName accounts.account_name%TYPE) RETURN INTEGER;
END gameFunctions;
/

CREATE OR REPLACE PACKAGE BODY gameFunctions IS

    /* Procedure to be called by SCHEDULED JOB to update the resources for the latest active game*/
    PROCEDURE updateResources IS
        /*
        v_resources INTEGER;
        CURSOR villages_cursor IS 
            SELECT resources, village_level, id FROM villages where id_game = (select max(id) from games); 
        v_village_row villages_cursor%ROWTYPE;
        */
    BEGIN
    /*
    -- CURSORUL NU E REFERINTA :'(
        FOR v_village_row IN villages_cursor LOOP
            if(v_village_row.resources < 1000) THEN
                SELECT resources INTO v_resources FROM villages where v_village_row.id = id;
                    DBMS_output.put_line('old: '||v_resources);
                v_village_row.resources := v_village_row.resources + v_village_row.village_level;
                SELECT resources INTO v_resources FROM villages where v_village_row.id = id;
                    DBMS_output.put_line('new: '||v_resources);
            END IF;
        END LOOP;
    */
    
        UPDATE villages SET resources = LEAST(resources + village_level, 2000) WHERE id_game = (SELECT max(id) FROM games);
        
        
        INSERT INTO update_log VALUES ((SELECT max(log_id) FROM update_log) + 1, 'Resources updated', SYSDATE);
    END updateResources;
    
    

    /* PROCEDURE to get villages CURSOR REFERENCE by account_id */
    PROCEDURE getVillagesByAccountIdCursor(p_accountId IN villages.id_account%TYPE, returnCursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN returnCursor FOR
            SELECT * FROM villages WHERE id_account = p_accountId;
    END getVillagesByAccountIdCursor;
    
    /* PROCEDURE to get all villages CURSOR REFERENCE*/
    PROCEDURE getAllVillages(p_gameId IN games.id%TYPE , returnCursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN returnCursor FOR
            SELECT * FROM villages WHERE id_game = p_gameId ORDER BY position_x, position_y;
    END getAllVillages;

    /**/
    FUNCTION  getAccountIdByName(p_accountName accounts.account_name%TYPE) RETURN INTEGER IS
        returnId INTEGER;
    BEGIN
        SELECT id INTO returnId FROM accounts WHERE account_name = p_accountName;
        RETURN returnId;
    END;
    
    
END gameFunctions;

