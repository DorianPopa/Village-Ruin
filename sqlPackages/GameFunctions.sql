CREATE OR REPLACE PACKAGE gameFunctions IS
    PROCEDURE closeCursor(cursorToBeClosed IN SYS_REFCURSOR);
    PROCEDURE updateResources;

    PROCEDURE getVillagesByAccountIdCursor(p_accountId IN villages.id_account%TYPE, returnCursor OUT SYS_REFCURSOR);
    PROCEDURE getAllVillages(p_gameId IN games.id%TYPE , returnCursor OUT SYS_REFCURSOR);
    FUNCTION  getAccountIdByName(p_accountName accounts.account_name%TYPE) RETURN INTEGER;
    PROCEDURE recruitTroopAtVillageById(p_villageId villages.id%TYPE);
    PROCEDURE increaseVillageLevelById(p_villageId villages.id%TYPE);
    PROCEDURE attackVillage(p_originVillage villages.id%TYPE, p_targetVillage villages.id%TYPE);
END gameFunctions;
/

CREATE OR REPLACE PACKAGE BODY gameFunctions IS

    PROCEDURE closeCursor(cursorToBeClosed IN SYS_REFCURSOR) AS
    BEGIN
        CLOSE cursorToBeClosed;
    END closeCursor;

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
    
    PROCEDURE recruitTroopAtVillageById(p_villageId villages.id%TYPE) AS
        targetVillage villages%ROWTYPE;
        TROOP_COST INTEGER := 5;
    BEGIN
        SELECT * INTO targetVillage FROM villages WHERE id = p_villageId;
        IF(targetVillage.resources >= TROOP_COST) THEN
            UPDATE villages SET resources = resources - TROOP_COST, troop_number = troop_number + 1 WHERE id = p_villageId;
        END IF;
        
    END recruitTroopAtVillageById;
    
    PROCEDURE increaseVillageLevelById(p_villageId villages.id%TYPE) AS
        targetVillage villages%ROWTYPE;
        LEVEL_COST_INCREASE INTEGER := 2;
        totalLevelUpCost INTEGER;
    BEGIN
        SELECT * INTO targetVillage FROM villages WHERE id = p_villageId;
        totalLevelUpCost := targetVillage.village_level * LEVEL_COST_INCREASE;
        IF(targetVillage.resources >= totalLevelUpCost) THEN
            UPDATE villages SET resources = resources - totalLevelUpCost, village_level = village_level + 1 WHERE id = p_villageId;
        END IF;
        
    END increaseVillageLevelById;
    
    PROCEDURE attackVillage(p_originVillage villages.id%TYPE, p_targetVillage villages.id%TYPE) AS
        ATTACK_RANGE INTEGER := 2;
        v_originTroops INTEGER;
        v_targetTroops INTEGER;
        v_originAccountId INTEGER;
        v_targetAccountId INTEGER;
        v_targetHealth INTEGER;
        v_totalAttackPower INTEGER;
        v_totalDefensivePower INTEGER;
        v_originX INTEGER;
        v_originY INTEGER;
        v_targetX INTEGER;
        v_targetY INTEGER;
        
        v_minX INTEGER;
        v_minY INTEGER;
        v_maxX INTEGER;
        v_maxY INTEGER;
    BEGIN
        SELECT troop_number, id_account, position_x, position_y INTO v_originTroops, v_originAccountId, v_originX, v_originY FROM villages WHERE id = p_originVillage;
        SELECT troop_number, id_account, health, position_x, position_y INTO v_targetTroops, v_targetAccountId, v_targetHealth, v_targetX, v_targetY FROM villages WHERE id = p_targetVillage;
        
        v_minX := GREATEST(0, v_originX - ATTACK_RANGE);
        v_maxX := LEAST(20, v_originX + ATTACK_RANGE);
        v_minY := GREATEST(0, v_originY - ATTACK_RANGE);
        v_maxY := LEAST(20, v_originY + ATTACK_RANGE);
        
        IF(v_originAccountId != v_targetAccountId) THEN
            IF(v_minX <= v_targetX AND v_targetX <= v_maxX AND v_minY <= v_targetY AND v_targetY <= v_maxY) THEN
                v_totalAttackPower := GREATEST(0, v_originTroops - v_targetTroops);
                v_totalDefensivePower := GREATEST(0, v_targetTroops - v_originTroops);
                
                IF(v_targetHealth - v_totalAttackPower <= 0) THEN
                    v_targetHealth := 1;
                    UPDATE villages SET id_account = v_originAccountId, troop_number = v_totalDefensivePower, health = v_targetHealth WHERE id = p_targetVillage;
                ELSE
                    v_targetHealth := v_targetHealth - v_totalAttackPower;
                    UPDATE villages SET troop_number = v_totalAttackPower WHERE id = p_originVillage;
                    UPDATE villages SET troop_number = v_totalDefensivePower, health = v_targetHealth WHERE id = p_targetVillage;
                END IF;
            END IF;
        END IF;
    END attackVillage;
    
END gameFunctions;

