-- (Bruna) RF 88
CREATE OR REPLACE VIEW membroCoexCaexPropostaPrograma AS SELECT 
	proj.id_proposta,proj.titulo, proj.nro_versao, proj.nro_do_processo, proj.abrangencia, proj.data_inicio_prevista, 
	proj.data_termino_previsto, proj.outros_setores, proj.linha_programática, proj.grande_area,
	proj.area_tematica_principal, proj.area_tematica_secundaria, proj.resumo, proj.publico_alvo,
	proj.palavra_chave1, proj.palavra_chave2, proj.palavra_chave3, proj.comunidade_atingida,
	proj.parceria_externa, prog.anotacoes_proex, prog.atividades_referenciais, prog.temario  
	FROM Proposta_Projeto proj, Proposta_Programa prog
	WHERE proj.id_proposta = prog.id_proposta AND proj.nro_versao = prog.nro_versao;

CREATE OR REPLACE VIEW membroCoexCaexPropostaProgramaOrgao AS SELECT 
	proj.id_proposta, proj.nro_versao, fin.cnpj, fin.data_inicio, fin.data_fim
	FROM membroCoexCaexPropostaPrograma proj LEFT JOIN Financia fin ON proj.id_proposta = fin.id_proposta
	AND proj.nro_versao = fin.nro_versao;

SELECT * FROM membroCoexCaexPropostaProgramaOrgao;

CREATE OR REPLACE VIEW membroCoexCaexPropostaProgramaPessoa AS SELECT 
	proj.id_proposta, proj.nro_versao, pes.nro_pessoa, pes.nome
	FROM membroCoexCaexPropostaPrograma proj LEFT JOIN 
	(SELECT pessoa.nome, envolve.nro_pessoa, envolve.id_proposta FROM Pessoa pessoa, Envolve envolve 
	WHERE envolve.nro_pessoa = pessoa.nro_pessoa) pes ON proj.id_proposta = pes.id_proposta; 

SELECT * FROM membroCoexCaexPropostaProgramaPessoa;

-- (Bruna) RF 85
CREATE OR REPLACE PROCEDURE alterarEdital
	(new_id_edital IN NUMBER, new_restricoes IN VARCHAR2, new_nro_bolsistas IN NUMBER, new_valor IN FLOAT, new_duracao IN NUMBER, new_recurso_custeio IN VARCHAR2)
	AS 
	BEGIN
		UPDATE Edital SET restricoes = new_restricoes, nro_bolsistas = new_nro_bolsistas, 
			valor = new_valor, duracao = new_duracao, recurso_custeio = new_recurso_custeio
			WHERE id_edital = new_id_edital; 
	COMMIT;
	END;
/

-- (Bruna) RF 82
CREATE OR REPLACE VIEW membroCaexReuniao AS 
	SELECT r.cod_reuniao, r.prioridade, r.local, r.hora, r.minuto, r.data
	FROM Reuniao r WHERE r.tipo = 'CaEx';

SELECT * FROM membroCaexReuniao;

CREATE OR REPLACE VIEW membroCaexReuniaoPauta AS SELECT 
	r.cod_reuniao, p.nome FROM Pauta_Reuniao p JOIN membroCaexReuniao r ON p.cod_reuniao = r.cod_reuniao;

SELECT * FROM membroCaexReuniaoPauta;

-- (Bruna) RF 81
CREATE OR REPLACE VIEW membroCoexReuniao AS 
	SELECT r.cod_reuniao, r.prioridade, r.local, r.hora, r.minuto, r.data
	FROM Reuniao r WHERE r.tipo = 'CoEx';

SELECT * FROM membroCoexReuniao;

CREATE OR REPLACE VIEW membroCoexReuniaoPauta AS SELECT 
	r.cod_reuniao, p.nome FROM Pauta_Reuniao p JOIN membroCoexReuniao r ON p.cod_reuniao = r.cod_reuniao;

SELECT * FROM membroCoexReuniaoPauta;

-- (Bruna) RF 83
CREATE OR REPLACE VIEW proReitorReuniao AS 
	SELECT cod_reuniao, prioridade, local, hora, minuto, data, tipo, ata
	FROM Reuniao;

SELECT * FROM proReitorReuniao;

CREATE OR REPLACE VIEW proReitorReuniaoPauta AS SELECT 
	r.cod_reuniao, p.nome FROM Pauta_Reuniao p JOIN proReitorReuniao r ON p.cod_reuniao = r.cod_reuniao;

SELECT * FROM proReitorReuniaoPauta;

-- (Bruna) RF 64
CREATE OR REPLACE TRIGGER inserirProReitor
	BEFORE INSERT ON Pro_Reitor
	DECLARE v_data_fim DATE;
	v_system_date DATE;
	BEGIN
		SELECT MAX(data_fim) INTO v_data_fim FROM Pro_Reitor;
		SELECT SYSDATE INTO v_system_date FROM Dual;
		IF v_system_date < v_data_fim THEN
			RAISE_APPLICATION_ERROR(-20205,'Voce so pode cadastrar um Pro-Reitor ao fim do seu periodo de chefia');
		END IF;
	END inserirProReitor;
/

-- (Bruna) RF 70
CREATE OR REPLACE PROCEDURE removerServidor
	(servidor_atual_nro_pessoa IN NUMBER, servidor_atual_siape IN NUMBER, new_servidor_nro IN NUMBER, new_servidor_siape IN NUMBER)
	IS 
	CURSOR c1 IS SELECT r.id_proposta, r.nro_versao, r.nro_pessoa, r.siape, r.data_inicio, r.data_fim FROM Responsavel r
		WHERE r.siape = servidor_atual_siape AND (r.data_fim IS NULL OR r.data_fim >= (SELECT SYSDATE FROM Dual)) FOR UPDATE;
	c1row c1%ROWTYPE;
	BEGIN 
		OPEN c1;
		LOOP 
			FETCH c1 INTO c1row;	
			EXIT WHEN c1%NOTFOUND;
			UPDATE Servidor SET data_demissao = (SELECT SYSDATE FROM Dual) WHERE nro_pessoa = servidor_atual_nro_pessoa AND siape = servidor_atual_siape;
			UPDATE Responsavel SET data_fim = (SELECT SYSDATE FROM Dual) WHERE CURRENT OF c1; 
			INSERT INTO Responsavel (id_proposta, nro_versao, nro_pessoa, siape, data_inicio) 
				VALUES (c1row.id_proposta, c1row.nro_versao, new_servidor_nro, new_servidor_siape, (SELECT SYSDATE FROM Dual));
		END LOOP;
		CLOSE c1;
	END removerServidor;
/

-- (Bruna) RF 63
CREATE OR REPLACE VIEW visoes AS 
	SELECT p.nro_pessoa, 'Discente' AS tipo FROM Interno p, Discente d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL 
	SELECT p.nro_pessoa, 'Docente' AS tipo FROM Interno p, Docente d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL 
	SELECT p.nro_pessoa, 'TA' AS tipo FROM Interno p, TA d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL 
	SELECT p.nro_pessoa, 'Pro_Reitor' AS tipo FROM Interno p, Pro_Reitor d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL
	SELECT p.nro_pessoa, 'Membro_CaEx' AS tipo FROM Interno p, Membro_CaEx d WHERE p.nro_pessoa = d.nro_pessoa
	UNION ALL
	SELECT p.nro_pessoa, 'Membro_CoEx' AS tipo FROM Interno p, Membro_CoEx d WHERE p.nro_pessoa = d.nro_pessoa;

SELECT * FROM visoes ORDER BY nro_pessoa ASC;

CREATE OR REPLACE FUNCTION fazLogin(login_in IN VARCHAR, senha_in IN VARCHAR, tipo_in IN VARCHAR)
	RETURN VARCHAR2
	IS
	v_nro_pessoa NUMBER;
	BEGIN 
	SELECT UNIQUE(nro_pessoa) INTO v_nro_pessoa FROM visoes 
		WHERE nro_pessoa = (SELECT nro_pessoa FROM Interno WHERE login = login_in AND senha = senha_in) AND tipo = tipo_in;
	RETURN ('1');
	EXCEPTION WHEN no_data_found THEN RETURN ('0');
	END;
/

CREATE OR REPLACE PROCEDURE saidaLogin(valorRetorno IN VARCHAR)
	IS 
	BEGIN 
		IF valorRetorno = '0' THEN
			apex_error.add_error('Usuario não encontrado!',NULL,apex_error.c_inline_in_notification );
		END IF;
	END saidaLogin;
/

-- (Bruna) RF 72
CREATE OR REPLACE TRIGGER convocaReuniao
	BEFORE INSERT ON Reuniao
	FOR EACH ROW
	DECLARE v_sysdate DATE;
	v_maxcodreuniao VARCHAR(20);
	BEGIN
		SELECT SYSDATE INTO v_sysdate FROM Dual; 
		SELECT MAX(cod_reuniao)+1 INTO v_maxcodreuniao FROM Reuniao;
		IF :new.data_convocacao IS NULL THEN
			:new.data_convocacao := v_sysdate;
		END IF;
		IF :new.data < :new.data_convocacao THEN
			RAISE_APPLICATION_ERROR(-20206,'Data de convocação inválida');
		END IF;
		IF :new.prioridade NOT LIKE 'Alta' AND :new.prioridade NOT LIKE 'Baixa' 
			AND :new.prioridade NOT LIKE 'Media' THEN
			RAISE_APPLICATION_ERROR(-20207,'Prioridade inválida');
		END IF;
		IF :new.tipo NOT LIKE 'CaEx' AND :new.tipo NOT LIKE 'CoEx' THEN
			RAISE_APPLICATION_ERROR(-20208,'Tipo inválido');
		END IF;
		IF :new.hora < 0 OR :new.hora > 23 THEN
			RAISE_APPLICATION_ERROR(-20209,'Hora inválida');
		END IF;
		IF :new.minuto < 0 OR :new.minuto > 59 THEN
			RAISE_APPLICATION_ERROR(-20210,'Minuto inválido');
		END IF;
		:new.cod_reuniao := v_maxcodreuniao;
	END convocaReuniao;
/

CREATE OR REPLACE TRIGGER inserePauta
	BEFORE INSERT ON Pauta_Reuniao
	FOR EACH ROW
	DECLARE v_maxcodreuniao VARCHAR(20);
	BEGIN
		SELECT MAX(cod_reuniao) INTO v_maxcodreuniao FROM Reuniao;
		:new.cod_reuniao := v_maxcodreuniao;
	END;
/

-- (Bruna) RF 73
CREATE OR REPLACE TRIGGER checaAta
	BEFORE UPDATE ON Reuniao
	FOR EACH ROW
	BEGIN
		IF :old.ata IS NOT NULL THEN
			apex_error.add_error('Ata já foi inserida anteriormente!',NULL,apex_error.c_inline_in_notification );
		END IF;
	END checaAta;
/

CREATE OR REPLACE PROCEDURE insereAta(cod_reuniao_in IN VARCHAR, nro_pessoa_in IN NUMBER, siape_in IN NUMBER, data_inicio_in IN DATE, ata_in IN VARCHAR)
	IS 
	v_codreuniao VARCHAR(20);
	v_nro_pessoa NUMBER;
	v_siape NUMBER(7);
	v_datainicio DATE;
	BEGIN
		IF ata_in IS NOT NULL THEN 
			SELECT cod_reuniao, nro_pessoa_pro_reitor, siape_pro_reitor, data_inicio_pro_reitor INTO v_codreuniao, v_nro_pessoa, v_siape, v_datainicio 
				FROM Reuniao WHERE cod_reuniao = cod_reuniao_in AND nro_pessoa_pro_reitor = nro_pessoa_in AND 
				siape_pro_reitor = siape_in AND data_inicio_pro_reitor = data_inicio_in;
			IF sql%FOUND THEN	
				UPDATE Reuniao SET ata = ata_in WHERE cod_reuniao = cod_reuniao_in;
			ELSE
				apex_error.add_error('Codigo de Reuniao não encontrado!',NULL,apex_error.c_inline_in_notification );
			END IF;
		END IF;
	END insereAta;
/

-- (Bruna) RF Novo, 11
-- Uma reunião é identificada pelo seu codigo (cod_reuniao), um valor numerico
-- Apenas o Pro-Reitor pode convocar reunioes (nivel administrativo)
-- Para convocação de uma reunião, é feita uma inserção na tabela Reunião
-- Uma trigger faz com que esse codigo seja ajustado automaticamente, sendo o valor maximo de codigo na tabela mais 1
-- O Pro-Reitor pode querer cancelar um conjunto de Reunioes convocadas 
-- O cancelamento é representado pela deleção na tabela Reunião
-- Porem, uma reuniao so pode ser cancelada se ela ainda não tiver acontecido (data)
-- Para cancelamento de um conjunto de reuniões, podemos criar uma procedure em que o Pro-Reitor insere o codigo da reuniao a partir do qual quer fazer o cancelamento
-- E pode inserir o codigo ate o qual quer fazer o cancelamento (mas pode fornecer esse valor como sendo NULL e, nesse caso, pega-se ate o valor maximo da tabela Reuniao)
-- A procedure esta explicitada a seguir: 
CREATE OR REPLACE PROCEDURE cancelarReunioes(v_cod_min IN VARCHAR, v_cod_max IN VARCHAR)
	IS
	t_cod_max VARCHAR(20);
	t_data DATE;
	t_system_date DATE;
	BEGIN 
		SELECT SYSDATE INTO t_system_date FROM Dual;
		IF v_cod_max is NULL THEN 
			SELECT MAX(cod_reuniao) INTO t_cod_max FROM Reuniao;
		ELSE
			t_cod_max := v_cod_max;
		END IF;
		FOR i IN v_cod_min..t_cod_max LOOP
			SELECT data INTO t_data FROM Reuniao WHERE cod_reuniao = i;
			IF t_data > t_system_date THEN 
				DELETE FROM Reuniao WHERE cod_reuniao = i;
			END IF;
		END LOOP;
	END;
/

-- (Bruna) RF Novo, 12
-- Ajusta o cod_reuniao, ajeitando a contagem em caso de cancelamento de reuniões
CREATE SEQUENCE resetaContagem
	START WITH 40 INCREMENT BY 
	1 MAXVALUE 1000 NOCYCLE;
/

CREATE OR REPLACE PROCEDURE resetaContagemReuniao
	IS
	CURSOR c1 IS SELECT cod_reuniao FROM Reuniao;
	v_temp NUMBER;
	v_temp2 NUMBER;
	BEGIN
		OPEN c1;
		FETCH c1 INTO v_temp2;	
		WHILE c1%FOUND LOOP
			SELECT resetaContagem.NEXTVAL INTO v_temp FROM Dual;
			UPDATE Reuniao SET cod_reuniao = v_temp WHERE cod_reuniao = v_temp2;
		END LOOP;
		CLOSE c1;
	END;
/

-- (Bruna) RF Novo, 13
-- Retorna o numero de reunioes convocadas para determinada data
CREATE OR REPLACE FUNCTION numeroReunioesData(v_data IN DATE)
	RETURN NUMBER
	IS
	v_saida NUMBER;
	BEGIN 
		SELECT Contagem INTO v_saida FROM (SELECT data, COUNT(data) Contagem FROM Reuniao GROUP BY data) 
			WHERE data = v_data;
		RETURN(v_saida);
		EXCEPTION WHEN no_data_found THEN RETURN ('0');
	END;
/

-- (Bruna) RF Novo, 14
-- Ao colocar a data de demissao de um servidor, precisamos substituir todos os projetos dos quais ele participa
CREATE OR REPLACE PROCEDURE substituiServidor
	(servidor_atual_nro_pessoa IN NUMBER, servidor_atual_siape IN NUMBER, new_servidor_nro IN NUMBER, new_servidor_siape IN NUMBER)
	IS 
	CURSOR c1(siape IN NUMBER) IS SELECT r.id_proposta, r.nro_versao, r.nro_pessoa, r.siape, r.data_inicio, r.data_fim FROM Responsavel r
		WHERE r.siape = siape AND (r.data_fim IS NULL OR r.data_fim >= (SELECT SYSDATE FROM Dual)) FOR UPDATE;
	c1row c1%ROWTYPE;
	BEGIN 
		OPEN c1(servidor_atual_siape);
		LOOP 
			FETCH c1 INTO c1row;	
			EXIT WHEN c1%NOTFOUND;
			UPDATE Servidor SET data_demissao = (SELECT SYSDATE FROM Dual) WHERE nro_pessoa = servidor_atual_nro_pessoa AND siape = servidor_atual_siape;
			UPDATE Responsavel SET data_fim = (SELECT SYSDATE FROM Dual) WHERE CURRENT OF c1; 
			INSERT INTO Responsavel (id_proposta, nro_versao, nro_pessoa, siape, data_inicio) 
				VALUES (c1row.id_proposta, c1row.nro_versao, new_servidor_nro, new_servidor_siape, (SELECT SYSDATE FROM Dual));
		END LOOP;
		CLOSE c1;
	END;
/