set serveroutput on;

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'UPDATE_RESOURCES',
            job_type => 'STORED_PROCEDURE',
            job_action => 'STUDENT.GAMEFUNCTIONS.updateResources',
            start_date => SYSDATE,
            repeat_interval => 'FREQ=SECONDLY;INTERVAL=1',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Job to update resources values of villages from active game'
    );    
END;
    -- begin DBMS_SCHEDULER.enable('UPDATE_RESOURCES'); end;
    
    -- begin DBMS_SCHEDULER.disable('UPDATE_RESOURCES'); end;

    -- begin DBMS_SCHEDULER.DROP_JOB('UPDATE_RESOURCES'); end;

    -- begin DBMS_SCHEDULER.RUN_JOB('UPDATE_RESOURCES'); end;
    
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'MANAGE_AI',
            job_type => 'STORED_PROCEDURE',
            job_action => 'STUDENT.AIFunctions.manageAI',
            start_date => SYSDATE,
            repeat_interval => 'FREQ=SECONDLY;INTERVAL=1',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Job to run the AI functions'
    );  
END;
    -- begin DBMS_SCHEDULER.enable('MANAGE_AI'); end;
    
    -- begin DBMS_SCHEDULER.disable('MANAGE_AI'); end;

    -- begin DBMS_SCHEDULER.DROP_JOB('MANAGE_AI'); end;

    -- begin DBMS_SCHEDULER.RUN_JOB('MANAGE_AI'); end;