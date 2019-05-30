DROP TABLE accounts CASCADE CONSTRAINTS;
/

DROP TABLE villages CASCADE CONSTRAINTS;
/

DROP TABLE empire CASCADE CONSTRAINTS;
/

DROP TABLE troop_stats CASCADE CONSTRAINTS;
/

DROP TABLE building_stats CASCADE CONSTRAINTS;
/

DROP TABLE building_upgrades CASCADE CONSTRAINTS;
/

DROP TABLE troop_movements CASCADE CONSTRAINTS;
/

DROP TABLE troop_recruitments CASCADE CONSTRAINTS;
/

CREATE TABLE accounts (
	id INT NOT NULL PRIMARY KEY,
	created_at DATE,
	updated_at DATE,
	account_name VARCHAR2(30) NOT NULL,
	account_password VARCHAR2(100) NOT NULL
);
/

CREATE TABLE villages (
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR2(30),
	created_at DATE,
	updated_at DATE, 
	position_x INT NOT NULL,
	position_y INT NOT NULL,
	
	level_cladire_principala INT NOT NULL,
	level_baraca INT NOT NULL,
	level_mina INT NOT NULL,
	level_ferma INT NOT NULL,
	level_moara_de_cherestea INT NOT NULL,
	level_zid INT NOT NULL,
	
	number_prastie INT NOT NULL,
	number_topor INT NOT NULL,
	number_sabie INT NOT NULL,
	number_arcas INT NOT NULL,
	number_cavalerie_usoara INT NOT NULL,
	number_cavalerie_grea INT NOT NULL,
	number_tunuri INT NOT NULL,
	CONSTRAINT no_duplicates_coords UNIQUE (position_x, position_y)
);
/

CREATE TABLE empire (
	id_account INT NOT NULL,
	id_village INT NOT NULL PRIMARY KEY,
	CONSTRAINT fk_empire_id_account FOREIGN KEY (id_account) REFERENCES accounts(id),
	CONSTRAINT fk_empire_id_village FOREIGN KEY (id_village) REFERENCES villages(id)
);
/

CREATE TABLE troop_stats (
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR2(30) NOT NULL,
	travel_speed INT NOT NULL,
	
	attack_power INT NOT NULL,
	defence_power INT NOT NULL,
	
	food_req INT NOT NULL,
	wood_req INT NOT NULL,
	metal_req INT NOT NULL,
	time_req INT NOT NULL
);
/

CREATE TABLE building_stats (
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR2(30) NOT NULL,
	
	food_req INT NOT NULL,
	wood_req INT NOT NULL,
	metal_req INT NOT NULL,
	time_req INT NOT NULL
);
/

CREATE TABLE troop_movements (
	id INT NOT NULL PRIMARY KEY,
	id_source_village INT NOT NULL,
	id_destination_village INT NOT NULL,
	purpose INT NOT NULL,
	
	number_prastie INT NOT NULL,
	number_topor INT NOT NULL,
	number_sabie INT NOT NULL,
	number_arcas INT NOT NULL,
	number_cavalerie_usoara INT NOT NULL,
	number_cavalerie_grea INT NOT NULL,
	number_tunuri INT NOT NULL,
	
	launching_time DATE,
	finishing_time DATE,
  
	CONSTRAINT fk_tm_id_s_village FOREIGN KEY (id_source_village) REFERENCES villages(id),
	CONSTRAINT fk_tm_id_d_village FOREIGN KEY (id_destination_village) REFERENCES villages(id)
);
/

CREATE TABLE troop_recruitments (
	id INT NOT NULL PRIMARY KEY,
	id_village NOT NULL,
	id_troop INT NOT NULL,
	quantity INT NOT NULL,
	
	launching_time DATE,
	finishing_time DATE,
	
	CONSTRAINT fk_tr_id_village FOREIGN KEY (id_village) REFERENCES villages(id),
	CONSTRAINT fk_tr_id_troop FOREIGN KEY (id_troop) REFERENCES troop_stats(id)
);
/

CREATE TABLE building_upgrades (
	id INT NOT NULL PRIMARY KEY,
	id_village NOT NULL,
	id_building INT NOT NULL,
	
	launching_time DATE,
	finishing_time DATE,
	
	CONSTRAINT fk_b_upgrades_id_village FOREIGN KEY (id_village) REFERENCES villages(id),
	CONSTRAINT fk_b_upgrades_id_building FOREIGN KEY (id_building) REFERENCES building_stats(id)
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
	v_id2 INT;
	v_purpose INT;
	v_id_orders INT;
	v_px INT;
	v_py INT;
	
	v_level_cp INT;
	v_level_mina INT;
	v_level_ferma INT;
	v_level_mdc INT;
	v_level_baraca INT;
	v_level_zid INT;
	
	v_number_prastie INT;
	v_number_sabie INT;
	v_number_topor INT;
	v_number_arcas INT;
	v_number_cu INT;
	v_number_cg INT;
	v_number_tun INT;
BEGIN
	--Inseram conturile
	for v_i IN 1..1000 LOOP
		v_user := lista_useri(TRUNC(DBMS_RANDOM.VALUE(0, lista_useri.count)) + 1);
		v_parola := lista_parole(TRUNC(DBMS_RANDOM.VALUE(0, lista_parole.count)) + 1);
		INSERT INTO accounts VALUES(v_i, SYSDATE, SYSDATE, v_user, v_parola);
	END LOOP;
	
	--Inseram SATELE
	for v_i IN 1..15000 LOOP
		v_nume_sat := lista_nume_sate(TRUNC(DBMS_RANDOM.VALUE(0, lista_nume_sate.count)) + 1);
		v_px := DBMS_RANDOM.VALUE(0, 1000);
		v_py := DBMS_RANDOM.VALUE(0, 1000);
		
		v_level_cp := DBMS_RANDOM.VALUE(1, 20);
		v_level_mina := DBMS_RANDOM.VALUE(1, 20);
		v_level_ferma := DBMS_RANDOM.VALUE(1, 20);
		v_level_mdc := DBMS_RANDOM.VALUE(1, 20);
		v_level_baraca := DBMS_RANDOM.VALUE(1, 20);
		v_level_zid := DBMS_RANDOM.VALUE(1, 20);
		
		v_number_prastie := DBMS_RANDOM.VALUE(1, 1000);
		v_number_sabie := DBMS_RANDOM.VALUE(1, 1000);
		v_number_topor := DBMS_RANDOM.VALUE(1, 1000);
		v_number_arcas := DBMS_RANDOM.VALUE(1, 1000);
		v_number_cu := DBMS_RANDOM.VALUE(1, 1000);
		v_number_cg := DBMS_RANDOM.VALUE(1, 1000);
		v_number_tun := DBMS_RANDOM.VALUE(1, 1000);
		
		DECLARE
		BEGIN
			INSERT INTO villages VALUES(v_i, v_nume_sat, SYSDATE, SYSDATE, v_px, v_py, v_level_cp, v_level_baraca, v_level_mina, v_level_ferma, v_level_mdc,  v_level_zid, 
										v_number_prastie, v_number_topor, v_number_sabie, v_number_arcas, v_number_cu, v_number_cg, v_number_tun);
			EXCEPTION WHEN OTHERS THEN NULL;
		END;
	END LOOP;
	
	--Asociem satele cu conturile
	FOR v_cursor_line IN cursor_villages
    LOOP
        v_id := DBMS_RANDOM.VALUE(1, 1000);
		INSERT INTO empire VALUES(v_id, v_cursor_line.id);
    END LOOP;
	
	--Date despre trupe
	INSERT INTO troop_stats VALUES(1, 'Prastie', 10, 5, 1, 2, 10, 1, 25);
	INSERT INTO troop_stats VALUES(2, 'Topor', 8, 12, 5, 8, 25, 10, 45);
	INSERT INTO troop_stats VALUES(3, 'Sabie', 9, 8, 7, 3, 15, 5, 40);
	INSERT INTO troop_stats VALUES(4, 'Arcas', 10, 4, 15, 3, 20, 2, 35);
	INSERT INTO troop_stats VALUES(5, 'Cavalerie usoara', 25, 20, 10, 15, 15, 15, 65);
	INSERT INTO troop_stats VALUES(6, 'Cavalerie grea', 15, 55, 30, 35, 25, 350, 120);
	INSERT INTO troop_stats VALUES(7, 'Tunuri', 2, 30, 115, 2, 10, 6000, 115);
	
	--Date despre sate
	INSERT INTO building_stats VALUES(1, 'Cladire principala', 15, 5, 1, 9);
	INSERT INTO building_stats VALUES(2, 'Baraca', 22, 17, 8, 12);
	INSERT INTO building_stats VALUES(3, 'Mina', 26, 19, 5, 23);
	INSERT INTO building_stats VALUES(5, 'Moara de cherestea', 4, 15, 17, 6);
	INSERT INTO building_stats VALUES(4, 'Ferma', 11, 30, 18, 21);
	INSERT INTO building_stats VALUES(6, 'Zid', 12, 44, 35, 6);
	
	--Inseram upgradeurile pentru cladiri
	FOR v_cursor_line IN cursor_villages
    LOOP
		SELECT MAX(id) INTO v_id FROM building_upgrades;
		IF (v_id IS NULL) THEN 
			v_id := 0;
		END IF;
        IF (DBMS_RANDOM.VALUE(0,100)<60) THEN 
			INSERT INTO building_upgrades VALUES(v_id + 1, v_cursor_line.id, DBMS_RANDOM.VALUE(1, 6), SYSDATE, SYSDATE);
			IF (DBMS_RANDOM.VALUE(0,100)<40) THEN 
				INSERT INTO building_upgrades VALUES(v_id + 2, v_cursor_line.id, DBMS_RANDOM.VALUE(1, 6), SYSDATE, SYSDATE);
			END IF;
		END IF;
    END LOOP;
	
	--Inseram upgradeurile pentru cladiri
	FOR v_cursor_line IN cursor_villages
    LOOP
		SELECT MAX(id) INTO v_id FROM troop_recruitments;
		IF (v_id IS NULL) THEN 
			v_id := 0;
		END IF;
        IF (DBMS_RANDOM.VALUE(0,100)<60) THEN 
			INSERT INTO troop_recruitments VALUES(v_id + 1, v_cursor_line.id, DBMS_RANDOM.VALUE(1, 7), DBMS_RANDOM.VALUE(10, 1000), SYSDATE, SYSDATE);
			IF (DBMS_RANDOM.VALUE(0,100)<40) THEN 
				INSERT INTO troop_recruitments VALUES(v_id + 2, v_cursor_line.id, DBMS_RANDOM.VALUE(1, 7), DBMS_RANDOM.VALUE(10, 1000), SYSDATE, SYSDATE);
				IF (DBMS_RANDOM.VALUE(0,100)<20) THEN 
					INSERT INTO troop_recruitments VALUES(v_id + 3, v_cursor_line.id, DBMS_RANDOM.VALUE(1, 7), DBMS_RANDOM.VALUE(10, 1000), SYSDATE, SYSDATE);
				END IF;
			END IF;
		END IF;
    END LOOP;
	
	--Inseram miscarile de trupe
	FOR v_cursor_line IN cursor_villages
    LOOP
		SELECT MAX(id) INTO v_id FROM troop_movements;
		IF (v_id IS NULL) THEN 
			v_id := 0;
		END IF;
        IF (DBMS_RANDOM.VALUE(0,100)<80) THEN 
			LOOP
				v_id2 := DBMS_RANDOM.VALUE(1, 1000);
				EXIT WHEN v_cursor_line.id<>v_id2;
			END LOOP;
			
			v_number_prastie := DBMS_RANDOM.VALUE(1, 1000);
			v_number_sabie := DBMS_RANDOM.VALUE(1, 1000);
			v_number_topor := DBMS_RANDOM.VALUE(1, 1000);
			v_number_arcas := DBMS_RANDOM.VALUE(1, 1000);
			v_number_cu := DBMS_RANDOM.VALUE(1, 1000);
			v_number_cg := DBMS_RANDOM.VALUE(1, 1000);
			v_number_tun := DBMS_RANDOM.VALUE(1, 1000);
		
			INSERT INTO troop_movements VALUES(v_id + 1, v_cursor_line.id, v_id2, DBMS_RANDOM.VALUE(1, 2),
											   v_number_prastie, v_number_topor, v_number_sabie, v_number_arcas, v_number_cu, v_number_cg, v_number_tun, SYSDATE, SYSDATE);
		END IF;
    END LOOP;
END;
/