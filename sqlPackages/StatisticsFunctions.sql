CREATE OR REPLACE PACKAGE statisticsFunctions IS
    PROCEDURE getAttacksByGameId(p_gameId IN INTEGER, returnCursor OUT SYS_REFCURSOR);

END statisticsFunctions;

CREATE OR REPLACE PACKAGE BODY statisticsFunctions IS

    PROCEDURE getAttacksByGameId(p_gameId IN INTEGER, returnCursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN returnCursor FOR
            SELECT * FROM attacks WHERE id_game = p_gameId;
        RETURN returnCursor;
    END getAttacksByGameId;

END statisticsFunctions;