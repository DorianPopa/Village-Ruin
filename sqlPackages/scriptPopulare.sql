DROP TABLE accounts CASCADE CONSTRAINTS;
/

DROP TABLE villages CASCADE CONSTRAINTS;
/

DROP TABLE games CASCADE CONSTRAINTS;
/

DROP TABLE attacks CASCADE CONSTRAINTS;
/

CREATE TABLE attacks (
    id int NOT NULL PRIMARY KEY,
    id_account INT NOT NULL,
    id_game INT NOT NULL,
    position_x INT NOT NULL,
    position_y INT NOT NULL,
    time_stamp DATE
);

CREATE TABLE accounts (
    id INT NOT NULL PRIMARY KEY,
    created_at DATE,
    updated_at DATE,
    account_name VARCHAR2(30) NOT NULL,
    account_password VARCHAR2(100) NOT NULL
);
/

CREATE TABLE games (
    id INT NOT NULL PRIMARY KEY,
    id_account INT NOT NULL,
    CONSTRAINT fk_games_id_account FOREIGN KEY (id_account) REFERENCES accounts(id)
);
/

CREATE TABLE villages (
    id INT NOT NULL PRIMARY KEY,
    id_account INT,
    id_game INT NOT NULL,
    village_name VARCHAR2(30),
    created_at DATE,
    updated_at DATE,
    position_x INT NOT NULL,
    position_y INT NOT NULL,

    village_level INT NOT NULL,
    health INT NOT NULL,
    troop_number INT NOT NULL,
    resources INT NOT NULL,
    CONSTRAINT no_duplicates_coords UNIQUE (position_x, position_y),
    CONSTRAINT fk_villages_id_account FOREIGN KEY (id_account) REFERENCES accounts(id),
    CONSTRAINT fk_villages_id_game FOREIGN KEY (id_game) REFERENCES games(id)
);
/

SET SERVEROUTPUT ON;
DECLARE
	TYPE varr IS VARRAY(1000) OF varchar2(30);
	lista_useri varr := varr('Adina','Alexandra','Alina','Ana','Anca','Anda','Andra','Andreea','Andreia','Antonia','Bianca','Camelia','Claudia','Codrina','Cristina','Daniela','Daria','Delia','Denisa','Diana','Ecaterina','Elena','Eleonora','Elisa','Ema','Emanuela','Emma','Gabriela','Georgiana','Ileana','Ilona','Ioana','Iolanda','Irina','Iulia','Iuliana','Larisa','Laura','Loredana','Madalina','Malina','Manuela','Maria','Mihaela','Mirela','Monica','Oana','Paula','Petruta','Raluca','Sabina','Sanziana','Simina','Simona','Stefana','Stefania','Tamara','Teodora','Theodora','Vasilica','Xena');
	lista_parole varr := varr('Adrian','Alex','Alexandru','Alin','Andreas','Andrei','Aurelian','Beniamin','Bogdan','Camil','Catalin','Cezar','Ciprian','Claudiu','Codrin','Constantin','Corneliu','Cosmin','Costel','Cristian','Damian','Dan','Daniel','Danut','Darius','Denise','Dimitrie','Dorian','Dorin','Dragos','Dumitru','Eduard','Elvis','Emil','Ervin','Eugen','Eusebiu','Fabian','Filip','Florian','Florin','Gabriel','George','Gheorghe','Giani','Giulio','Iaroslav','Ilie','Ioan','Ion','Ionel','Ionut','Iosif','Irinel','Iulian','Iustin','Laurentiu','Liviu','Lucian','Marian','Marius','Matei','Mihai','Mihail','Nicolae','Nicu','Nicusor','Octavian','Ovidiu','Paul','Petru','Petrut','Radu','Rares','Razvan','Richard','Robert','Roland','Rolland','Romanescu','Sabin','Samuel','Sebastian','Sergiu','Silviu','Stefan','Teodor','Teofil','Theodor','Tudor','Vadim','Valentin','Valeriu','Vasile','Victor','Vlad','Vladimir','Vladut');
	lista_nume_sate varr := varr('Ababei','Acasandrei','Adascalitei','Afanasie','Agafitei','Agape','Aioanei','Alexandrescu','Alexandru','Alexe','Alexii','Amarghioalei','Ambroci','Andonesei','Andrei','Andrian','Andrici','Andronic','Andros','Anghelina','Anita','Antochi','Antonie','Apetrei','Apostol','Arhip','Arhire','Arteni','Arvinte','Asaftei','Asofiei','Aungurenci','Avadanei','Avram','Babei','Baciu','Baetu','Balan','Balica','Banu','Barbieru','Barzu','Bazgan','Bejan','Bejenaru','Belcescu','Belciuganu','Benchea','Bilan','Birsanu','Bivol','Bizu','Boca','Bodnar','Boistean','Borcan','Bordeianu','Botezatu','Bradea','Braescu','Budaca','Bulai','Bulbuc-aioanei','Burlacu','Burloiu','Bursuc','Butacu','Bute','Buza','Calancea','Calinescu','Capusneanu','Caraiman','Carbune','Carp','Catana','Catiru','Catonoiu','Cazacu','Cazamir','Cebere','Cehan','Cernescu','Chelaru','Chelmu','Chelmus','Chibici','Chicos','Chilaboc','Chile','Chiriac','Chirila','Chistol','Chitic','Chmilevski','Cimpoesu','Ciobanu','Ciobotaru','Ciocoiu','Ciofu','Ciornei','Citea','Ciucanu','Clatinici','Clim','Cobuz','Coca','Cojocariu','Cojocaru','Condurache','Corciu','Corduneanu','Corfu','Corneanu','Corodescu','Coseru','Cosnita','Costan','Covatariu','Cozma','Cozmiuc','Craciunas','Crainiceanu','Creanga','Cretu','Cristea','Crucerescu','Cumpata','Curca','Cusmuliuc','Damian','Damoc','Daneliuc','Daniel','Danila','Darie','Dascalescu','Dascalu','Diaconu','Dima','Dimache','Dinu','Dobos','Dochitei','Dochitoiu','Dodan','Dogaru','Domnaru','Dorneanu','Dragan','Dragoman','Dragomir','Dragomirescu','Duceac','Dudau','Durnea','Edu','Eduard','Eusebiu','Fedeles','Ferestraoaru','Filibiu','Filimon','Filip','Florescu','Folvaiter','Frumosu','Frunza','Galatanu','Gavrilita','Gavriliuc','Gavrilovici','Gherase','Gherca','Ghergu','Gherman','Ghibirdic','Giosanu','Gitlan','Giurgila','Glodeanu','Goldan','Gorgan','Grama','Grigore','Grigoriu','Grosu','Grozavu','Gurau','Haba','Harabula','Hardon','Harpa','Herdes','Herscovici','Hociung','Hodoreanu','Hostiuc','Huma','Hutanu','Huzum','Iacob','Iacobuta','Iancu','Ichim','Iftimesei','Ilie','Insuratelu','Ionesei','Ionesi','Ionita','Iordache','Iordache-tiroiu','Iordan','Iosub','Iovu','Irimia','Ivascu','Jecu','Jitariuc','Jitca','Joldescu','Juravle','Larion','Lates','Latu','Lazar','Leleu','Leon','Leonte','Leuciuc','Leustean','Luca','Lucaci','Lucasi','Luncasu','Lungeanu','Lungu','Lupascu','Lupu','Macariu','Macoveschi','Maftei','Maganu','Mangalagiu','Manolache','Manole','Marcu','Marinov','Martinas','Marton','Mataca','Matcovici','Matei','Maties','Matrana','Maxim','Mazareanu','Mazilu','Mazur','Melniciuc-puica','Micu','Mihaela','Mihai','Mihaila','Mihailescu','Mihalachi','Mihalcea','Mihociu','Milut','Minea','Minghel','Minuti','Miron','Mitan','Moisa','Moniry-abyaneh','Morarescu','Morosanu','Moscu','Motrescu','Motroi','Munteanu','Murarasu','Musca','Mutescu','Nastaca','Nechita','Neghina','Negrus','Negruser','Negrutu','Nemtoc','Netedu','Nica','Nicu','Oana','Olanuta','Olarasu','Olariu','Olaru','Onu','Opariuc','Oprea','Ostafe','Otrocol','Palihovici','Pantiru','Pantiruc','Paparuz','Pascaru','Patachi','Patras','Patriche','Perciun','Perju','Petcu','Pila','Pintilie','Piriu','Platon','Plugariu','Podaru','Poenariu','Pojar','Popa','Popescu','Popovici','Poputoaia','Postolache','Predoaia','Prisecaru','Procop','Prodan','Puiu','Purice','Rachieru','Razvan','Reut','Riscanu','Riza','Robu','Roman','Romanescu','Romaniuc','Rosca','Rusu','Samson','Sandu','Sandulache','Sava','Savescu','Schifirnet','Scortanu','Scurtu','Sfarghiu','Silitra','Simiganoschi','Simion','Simionescu','Simionesei','Simon','Sitaru','Sleghel','Sofian','Soficu','Sparhat','Spiridon','Stan','Stavarache','Stefan','Stefanita','Stingaciu','Stiufliuc','Stoian','Stoica','Stoleru','Stolniceanu','Stolnicu','Strainu','Strimtu','Suhani','Tabusca','Talif','Tanasa','Teclici','Teodorescu','Tesu','Tifrea','Timofte','Tincu','Tirpescu','Toader','Tofan','Toma','Toncu','Trifan','Tudosa','Tudose','Tuduri','Tuiu','Turcu','Ulinici','Unghianu','Ungureanu','Ursache','Ursachi','Urse','Ursu','Varlan','Varteniuc','Varvaroi','Vasilache','Vasiliu','Ventaniuc','Vicol','Vidru','Vinatoru','Vlad','Voaides','Vrabie','Vulpescu','Zamosteanu','Zazuleac');

	CURSOR cursor_villages IS
        SELECT id FROM villages;
    v_cursor_line cursor_villages%ROWTYPE;

	v_user VARCHAR2(30);
	v_parola VARCHAR2(30);
	v_nume_sat VARCHAR2(30);
	v_id INT;
	v_px INT;
	v_py INT;

	v_level INT;
	v_troop_number INT;
	v_resources INT;
BEGIN
	--Inseram conturile
    FOR v_i IN 1..2 LOOP
        v_user := lista_useri(TRUNC(DBMS_RANDOM.VALUE(0, lista_useri.count)) + 1);
        v_parola := lista_parole(TRUNC(DBMS_RANDOM.VALUE(0, lista_parole.count)) + 1);
        INSERT INTO accounts VALUES(v_i, SYSDATE, SYSDATE, v_user, v_parola);
    END LOOP;

    INSERT INTO games VALUES(1, 1);

    --Inseram SATELE
    FOR v_i IN 1..1000 LOOP
        v_nume_sat := lista_nume_sate(TRUNC(DBMS_RANDOM.VALUE(0, lista_nume_sate.count)) + 1);
        v_px := DBMS_RANDOM.VALUE(0, 20);
        v_py := DBMS_RANDOM.VALUE(0, 20);

        v_level := DBMS_RANDOM.VALUE(1, 20);
        v_troop_number := DBMS_RANDOM.VALUE(1, 1000);
        v_resources := DBMS_RANDOM.VALUE(1, 1000);
        DECLARE
        BEGIN
            INSERT INTO villages VALUES(v_i, NULL, 1, v_nume_sat, SYSDATE, SYSDATE, v_px, v_py, v_level, 100, v_troop_number, v_resources);
            EXCEPTION WHEN OTHERS THEN NULL;
        END;
    END LOOP;

BEGIN
    FOR v_i IN 1..100 LOOP
        FOR v_j IN 1..5000 LOOP
            INSERT INTO attacks VALUES ((SELECT max(id)+1 FROM attacks), DBMS_RANDOM.VALUE(1, 8), v_i, DBMS_RANDOM.VALUE(0, 20), DBMS_RANDOM.VALUE(0, 20), SYSDATE);
        END LOOP;
    END LOOP;
END;
END;
/