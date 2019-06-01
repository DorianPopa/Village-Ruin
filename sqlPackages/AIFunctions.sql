set serveroutput on;
CREATE OR REPLACE PACKAGE AIFunctions IS
    PROCEDURE manageAI;
    PROCEDURE AIAttack(p_villageId villages.id%TYPE, p_positionX INTEGER, p_positionY INTEGER, p_troopNumber INTEGER);
    PROCEDURE AIEvolve(p_villageId villages.id%TYPE, p_troopNumber INTEGER, p_level INTEGER);

END AIFunctions;

CREATE OR REPLACE PACKAGE BODY AIFunctions IS
    PROCEDURE manageAI AS
        CURSOR villages_cursor IS 
            SELECT village_level, id, position_x, position_y, troop_number FROM villages where id_game = (select max(id) from games) AND id_account = 1; 
        v_village_row villages_cursor%ROWTYPE;
    BEGIN
        FOR v_village_row IN villages_cursor LOOP
            IF(TRUNC(DBMS_RANDOM.value(0,2)) = 1) THEN
                AIAttack(v_village_row.id, v_village_row.position_x, v_village_row.position_y, v_village_row.troop_number);
            END IF;
            IF(TRUNC(DBMS_RANDOM.value(0,2)) = 0) THEN
                AIEvolve(v_village_row.id, v_village_row.troop_number, v_village_row.village_level);
            END IF;
        END LOOP;
        -- DBMS_OUTPUT.PUT_LINE('chestie worked');
        --CLOSE villages_cursor;
    END manageAI;
    
    
    PROCEDURE AIAttack(p_villageId villages.id%TYPE, p_positionX INTEGER, p_positionY INTEGER, p_troopNumber INTEGER) AS
        v_id INTEGER;
        v_troopNumber INTEGER;
    BEGIN
        SELECT id, troop_number INTO v_id, v_troopNumber FROM 
            (SELECT COALESCE(id, 0) AS id, troop_number, id_account FROM villages WHERE id_account != 1 AND ABS(p_positionX - position_x) <= 2 AND ABS(p_positionY - position_y) <= 2 AND id != p_villageId ORDER BY 2) WHERE ROWNUM < 2;
        IF(p_troopNumber > v_troopNumber) THEN
            gamefunctions.attackvillage(p_villageId, v_id);
        END IF;
    END AIAttack;
    
    
    PROCEDURE AIEvolve(p_villageId villages.id%TYPE, p_troopNumber INTEGER, p_level INTEGER) as
    BEGIN
        IF(p_level * 5 < p_troopNumber) THEN
            gamefunctions.increasevillagelevelbyid(p_villageId);
        ELSE
            gamefunctions.recruitTroopAtVillageById(p_villageId);
        END IF;    
    END AIEvolve;
    
END AIFunctions;