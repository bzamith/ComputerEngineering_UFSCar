-- Visão: Pró-Reitor 
-- Consultar Reunião e Pauta (Views)
CREATE OR REPLACE VIEW proReitorReuniao AS 
	SELECT cod_reuniao, prioridade, local, hora, minuto, data, tipo, ata
	FROM Reuniao;

CREATE OR REPLACE VIEW proReitorReuniaoPauta AS SELECT 
	r.cod_reuniao, p.nome FROM Pauta_Reuniao p JOIN proReitorReuniao r ON p.cod_reuniao = r.cod_reuniao;

-- Inserir Ata (Trigger e Procedure)
CREATE OR REPLACE TRIGGER atualizaAta
	BEFORE UPDATE ON Reuniao
	FOR EACH ROW
	BEGIN
		IF :old.ata IS NOT NULL THEN
			RAISE_APPLICATION_ERROR(-20001,'Ata já foi inserida anteriormente!');
		ELSIF :new.ata IS NULL THEN
			RAISE_APPLICATION_ERROR(-20002,'Ata não pode ser vazia!');
		END IF;
	END;
/

CREATE OR REPLACE PROCEDURE adicionaAta
	(cod_reuniao_in IN NUMBER, nro_pessoa_in IN NUMBER, siape_in IN NUMBER, data_inicio_in IN DATE, data_fim_in IN DATE, ata_in IN VARCHAR)
	IS 
	v_codreuniao NUMBER(20);
	v_nropessoa NUMBER;
	v_siape NUMBER(7);
	v_datainicio DATE;
	BEGIN
		SELECT cod_reuniao, nro_pessoa_pro_reitor, siape_pro_reitor, data_inicio_pro_reitor INTO v_codreuniao, v_nropessoa, v_siape, v_datainicio 
			FROM Reuniao WHERE cod_reuniao = cod_reuniao_in AND nro_pessoa_pro_reitor = nro_pessoa_in AND 
			siape_pro_reitor = siape_in AND data_inicio_pro_reitor = data_inicio_in;
		IF checaDataFim(data_fim_in) = '1' THEN
			UPDATE Reuniao SET ata = ata_in WHERE cod_reuniao = cod_reuniao_in;
		ELSE
			RAISE_APPLICATION_ERROR(-20003,'Você não pode mais inserir ata (seu período de Pró-Reitor esgotou)!');
		END IF;
		EXCEPTION WHEN no_data_found THEN 
			RAISE_APPLICATION_ERROR(-20004,'Código de Reunião não encontrado!');
	END;
/

-- Inserir Reunião (Trigger e Procedure)
CREATE OR REPLACE TRIGGER insereReuniao
	BEFORE INSERT ON Reuniao
	FOR EACH ROW
	BEGIN
		IF :new.data < :new.data_convocacao THEN
			RAISE_APPLICATION_ERROR(-20005,'Data inválida');
		END IF;
		IF :new.prioridade NOT LIKE 'Alta' AND :new.prioridade NOT LIKE 'Baixa' 
			AND :new.prioridade NOT LIKE 'Media' THEN
			RAISE_APPLICATION_ERROR(-20006,'Prioridade inválida');
		END IF;
		IF :new.tipo NOT LIKE 'CaEx' AND :new.tipo NOT LIKE 'CoEx' THEN
			RAISE_APPLICATION_ERROR(-20007,'Tipo inválido');
		END IF;
		IF :new.hora < 0 OR :new.hora > 23 THEN
			RAISE_APPLICATION_ERROR(-20008,'Hora inválida');
		END IF;
		IF :new.minuto < 0 OR :new.minuto > 59 THEN
			RAISE_APPLICATION_ERROR(-20009,'Minuto inválido');
		END IF;
	END;
/

CREATE OR REPLACE TRIGGER inserePauta
	BEFORE INSERT ON Pauta_Reuniao
	FOR EACH ROW
	DECLARE v_codreuniao NUMBER(20);
	BEGIN
		SELECT cod_reuniao INTO v_codreuniao FROM Reuniao WHERE cod_reuniao = :new.cod_reuniao;
		RAISE_APPLICATION_ERROR(-20010,'Problema na inserção da Reunião!');
	END;
/

CREATE OR REPLACE PROCEDURE convocaReuniao
	(nro_pr IN NUMBER, siape_pr IN NUMBER, data_inicio_pr IN DATE, data_fim_pr IN DATE,
		tipo_in IN VARCHAR, prioridade_in IN VARCHAR, local_in IN VARCHAR,
		hora_in IN INT, minuto_in IN INT, data_in IN DATE, 
		pauta1 IN VARCHAR2, pauta2 IN VARCHAR2, pauta3 IN VARCHAR2)
	IS 
	v_sysdate DATE;
	v_codreuniao NUMBER(20);
	BEGIN
		IF checaDataFim(data_fim_pr) = '1' THEN	
			SELECT SYSDATE INTO v_sysdate FROM Dual; 
			SELECT MAX(cod_reuniao)+1 INTO v_codreuniao FROM Reuniao;
			INSERT INTO Reuniao
				(cod_reuniao, nro_pessoa_pro_reitor, siape_pro_reitor, data_inicio_pro_reitor,
				tipo,prioridade,local,hora,minuto,data,data_convocacao)
				VALUES (v_codreuniao, nro_pr, siape_pr, data_inicio_pr, tipo_in, prioridade_in, local_in,
					hora_in, minuto_in, data_in, v_sysdate);
			COMMIT;
			IF pauta1 IS NOT NULL THEN 
				INSERT INTO Pauta_Reuniao VALUES (pauta1,v_codreuniao);
			END IF;
			IF pauta2 IS NOT NULL THEN 
				INSERT INTO Pauta_Reuniao VALUES (pauta2,v_codreuniao);
			END IF;
			IF pauta3 IS NOT NULL THEN 
				INSERT INTO Pauta_Reuniao VALUES (pauta3,v_codreuniao);
			END IF;
		ELSE 
			RAISE_APPLICATION_ERROR(-20011,'Você não pode mais convocar reuniões (seu período de Pró-Reitor esgotou)!');
		END IF;
	END;
/

-- Cadastrar Pró-Reitor
CREATE OR REPLACE TRIGGER insereProReitor
	BEFORE INSERT ON Pro_Reitor FOR EACH ROW
	DECLARE v_datafim DATE;
	v_sysdate DATE;
	BEGIN
		SELECT MAX(data_fim) INTO v_datafim FROM Pro_Reitor;
		SELECT SYSDATE INTO v_sysdate FROM Dual;
		IF v_sysdate < v_datafim THEN
			RAISE_APPLICATION_ERROR(-20012,'Voce so pode cadastrar um Pro-Reitor ao fim do seu periodo de chefia!');
		END IF;
		IF :new.data_inicio > :new.data_fim THEN
			RAISE_APPLICATION_ERROR(-20013,'Data de fim inválida!');
		END IF;
		IF :new.data_inicio IS NULL THEN
			RAISE_APPLICATION_ERROR(-20014,'Data de inicio não pode ser nula!');
		END IF;
		IF :new.data_fim IS NULL THEN
			RAISE_APPLICATION_ERROR(-20015,'Data de fim não pode ser nula!');
		END IF;
	END inserirProReitor;
/

CREATE OR REPLACE PROCEDURE cadastraProReitor(siape_in IN NUMBER, data_fim_in IN DATE)
	IS
	v_nropessoa NUMBER;
	v_sysdate DATE;
	BEGIN
		SELECT nro_pessoa INTO v_nropessoa FROM Servidor WHERE SIAPE = siape_in;
		SELECT SYSDATE INTO v_sysdate FROM Dual;
		INSERT INTO Pro_Reitor VALUES (v_nropessoa,siape_in,v_sysdate,data_fim_in);
		EXCEPTION WHEN no_data_found THEN
			RAISE_APPLICATION_ERROR(-20016,'Servidor não encontrado!');
	END;
/