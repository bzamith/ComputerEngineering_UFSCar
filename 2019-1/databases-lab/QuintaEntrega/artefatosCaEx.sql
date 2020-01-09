-- Visão: Membro CaEx
-- Consultar Reunião e Pauta (Views)
CREATE OR REPLACE VIEW membroCaexReuniao AS 
	SELECT r.cod_reuniao, r.prioridade, r.local, r.hora, r.minuto, r.data
	FROM Reuniao r WHERE r.tipo = 'CaEx';

CREATE OR REPLACE VIEW membroCaexReuniaoPauta AS SELECT 
	r.cod_reuniao, p.nome FROM Pauta_Reuniao p JOIN membroCaexReuniao r ON p.cod_reuniao = r.cod_reuniao;

-- Consultar Proposta Programa de Extensao (Views)
CREATE OR REPLACE VIEW membroCoexCaexPP AS SELECT 
	proj.id_proposta,proj.titulo, proj.nro_versao, proj.nro_do_processo, proj.abrangencia, proj.data_inicio_prevista, 
	proj.data_termino_previsto, proj.outros_setores, proj.linha_programática, proj.grande_area,
	proj.area_tematica_principal, proj.area_tematica_secundaria, proj.resumo, proj.publico_alvo,
	proj.palavra_chave1, proj.palavra_chave2, proj.palavra_chave3, proj.comunidade_atingida,
	proj.parceria_externa, prog.anotacoes_proex, prog.atividades_referenciais, prog.temario  
	FROM Proposta_Projeto proj, Proposta_Programa prog
	WHERE proj.id_proposta = prog.id_proposta AND proj.nro_versao = prog.nro_versao;

CREATE OR REPLACE VIEW membroCoexCaexPPRecente AS SELECT 
	proj.id_proposta,proj.titulo, proj.nro_versao, proj.nro_do_processo, proj.abrangencia, proj.data_inicio_prevista, 
	proj.data_termino_previsto, proj.outros_setores, proj.linha_programática, proj.grande_area,
	proj.area_tematica_principal, proj.area_tematica_secundaria, proj.resumo, proj.publico_alvo,
	proj.palavra_chave1, proj.palavra_chave2, proj.palavra_chave3, proj.comunidade_atingida,
	proj.parceria_externa, prog.anotacoes_proex, prog.atividades_referenciais, prog.temario  
	FROM Proposta_Projeto proj, Proposta_Programa prog
	WHERE proj.id_proposta = prog.id_proposta AND proj.nro_versao = prog.nro_versao 
	AND proj.nro_versao = pegaMaiorVersao(proj.id_proposta);

CREATE OR REPLACE VIEW membroCoexCaexPPOrgao AS SELECT 
	proj.id_proposta, proj.nro_versao, fin.cnpj, fin.data_inicio, fin.data_fim
	FROM membroCoexCaexPPRecente proj INNER JOIN Financia fin ON proj.id_proposta = fin.id_proposta
	AND proj.nro_versao = fin.nro_versao;

CREATE OR REPLACE VIEW membroCoexCaexPPPessoa AS SELECT 
	proj.id_proposta, proj.nro_versao, pes.nome
	FROM membroCoexCaexPPRecente proj INNER JOIN 
	(SELECT pessoa.nome, envolve.nro_pessoa, envolve.id_proposta FROM Pessoa pessoa, Envolve envolve 
	WHERE envolve.nro_pessoa = pessoa.nro_pessoa) pes ON proj.id_proposta = pes.id_proposta; 

-- Consultar Proposta Atividade de Extensao (Views)
CREATE OR REPLACE VIEW membroCoexCaexPA AS 
	SELECT
	proj.id_proposta,'ACIEPE' AS categoria, proj.titulo, proj.nro_versao, proj.nro_do_processo, proj.abrangencia, 
	proj.data_inicio_prevista, 	proj.data_termino_previsto, proj.outros_setores, proj.linha_programática, 
	proj.grande_area, proj.area_tematica_principal, proj.area_tematica_secundaria, proj.resumo, proj.publico_alvo,
	proj.palavra_chave1, proj.palavra_chave2, proj.palavra_chave3, proj.comunidade_atingida,
	proj.parceria_externa, atv.local, atv.pneplrld, atv.informacoes_complementares, atv.previsao_publico,
	atv.tipo, atv.subtipo, atv.tipo_financiamento, atv.reoferta
	FROM Proposta_Projeto proj, Proposta_Atividade_Extensao atv, Proposta_ACIEPE aciepe
	WHERE proj.id_proposta = atv.id_proposta_proposta AND proj.nro_versao = atv.nro_versao_proposta
		AND proj.id_proposta = aciepe.id_proposta AND proj.nro_versao = aciepe.nro_versao
	UNION ALL 
	SELECT
	proj.id_proposta,'Atividades Gerais' AS categoria, proj.titulo, proj.nro_versao, proj.nro_do_processo, proj.abrangencia, 
	proj.data_inicio_prevista, proj.data_termino_previsto, proj.outros_setores, proj.linha_programática, 
	proj.grande_area, proj.area_tematica_principal, proj.area_tematica_secundaria, proj.resumo, proj.publico_alvo,
	proj.palavra_chave1, proj.palavra_chave2, proj.palavra_chave3, proj.comunidade_atingida,
	proj.parceria_externa, atv.local, atv.pneplrld, atv.informacoes_complementares, atv.previsao_publico,
	atv.tipo, atv.subtipo, atv.tipo_financiamento, atv.reoferta
	FROM Proposta_Projeto proj, Proposta_Atividade_Extensao atv, Proposta_Atividades_Gerais gerais
	WHERE proj.id_proposta = atv.id_proposta_proposta AND proj.nro_versao = atv.nro_versao_proposta
		AND proj.id_proposta = gerais.id_proposta AND proj.nro_versao = gerais.nro_versao;

CREATE OR REPLACE VIEW membroCoexCaexPARecente AS 
	SELECT
	proj.id_proposta,'ACIEPE' AS categoria, proj.titulo, proj.nro_versao, proj.nro_do_processo, proj.abrangencia, 
	proj.data_inicio_prevista, 	proj.data_termino_previsto, proj.outros_setores, proj.linha_programática, 
	proj.grande_area, proj.area_tematica_principal, proj.area_tematica_secundaria, proj.resumo, proj.publico_alvo,
	proj.palavra_chave1, proj.palavra_chave2, proj.palavra_chave3, proj.comunidade_atingida,
	proj.parceria_externa, atv.local, atv.pneplrld, atv.informacoes_complementares, atv.previsao_publico,
	atv.tipo, atv.subtipo, atv.tipo_financiamento, atv.reoferta
	FROM Proposta_Projeto proj, Proposta_Atividade_Extensao atv, Proposta_ACIEPE aciepe
	WHERE proj.id_proposta = atv.id_proposta_proposta AND proj.nro_versao = atv.nro_versao_proposta
		AND proj.id_proposta = aciepe.id_proposta AND proj.nro_versao = aciepe.nro_versao
		AND proj.nro_versao = pegaMaiorVersao(proj.id_proposta)
	UNION ALL 
	SELECT
	proj.id_proposta,'Atividades Gerais' AS categoria, proj.titulo, proj.nro_versao, proj.nro_do_processo, proj.abrangencia, 
	proj.data_inicio_prevista, proj.data_termino_previsto, proj.outros_setores, proj.linha_programática, 
	proj.grande_area, proj.area_tematica_principal, proj.area_tematica_secundaria, proj.resumo, proj.publico_alvo,
	proj.palavra_chave1, proj.palavra_chave2, proj.palavra_chave3, proj.comunidade_atingida,
	proj.parceria_externa, atv.local, atv.pneplrld, atv.informacoes_complementares, atv.previsao_publico,
	atv.tipo, atv.subtipo, atv.tipo_financiamento, atv.reoferta
	FROM Proposta_Projeto proj, Proposta_Atividade_Extensao atv, Proposta_Atividades_Gerais gerais
	WHERE proj.id_proposta = atv.id_proposta_proposta AND proj.nro_versao = atv.nro_versao_proposta
		AND proj.id_proposta = gerais.id_proposta AND proj.nro_versao = gerais.nro_versao
		AND proj.nro_versao = pegaMaiorVersao(proj.id_proposta);

CREATE OR REPLACE VIEW membroCoexCaexPAOrgao AS SELECT 
	proj.id_proposta, proj.nro_versao, fin.cnpj, fin.data_inicio, fin.data_fim
	FROM membroCoexCaexPA proj INNER JOIN Financia fin ON proj.id_proposta = fin.id_proposta
	AND proj.nro_versao = fin.nro_versao;

CREATE OR REPLACE VIEW membroCoexCaexPAPessoa AS SELECT 
	proj.id_proposta, proj.nro_versao, pes.nome
	FROM membroCoexCaexPA proj INNER JOIN 
	(SELECT pessoa.nome, envolve.nro_pessoa, envolve.id_proposta FROM Pessoa pessoa, Envolve envolve 
	WHERE envolve.nro_pessoa = pessoa.nro_pessoa) pes ON proj.id_proposta = pes.id_proposta; 

-- Abrir Edital (Trigger e Procedure)
CREATE OR REPLACE TRIGGER insereEdital
	BEFORE INSERT OR UPDATE ON Edital FOR EACH ROW
	DECLARE v_idedital NUMBER;
	v_sysdate DATE;
	BEGIN
		SELECT SYSDATE INTO v_sysdate FROM DUAL;
		IF ((:new.nro_bolsistas IS NOT NULL) AND (:new.nro_bolsistas < 0)) THEN  
			RAISE_APPLICATION_ERROR(-20017,'Numero de bolsistas não pode ser menor que zero!');
		END IF;
		IF ((:new.valor IS NOT NULL) AND (:new.valor < 0)) THEN  
			RAISE_APPLICATION_ERROR(-20018,'Valor não pode ser menor que zero!');
		END IF;
		IF ((:new.duracao IS NOT NULL) AND (:new.duracao < 0)) THEN  
			RAISE_APPLICATION_ERROR(-20019,'Duração não pode ser menor que zero!');
		END IF;
		IF((:new.restricoes IS NULL) AND (:new.nro_bolsistas IS NULL) AND (:new.valor IS NULL) AND (:new.duracao IS NULL) AND (:new.recurso_custeio IS NULL)) THEN
			RAISE_APPLICATION_ERROR(-20019,'Você precisa preencher pelo menos um campo!');
		END IF;
		IF INSERTING THEN 
			SELECT MAX(id_edital)+1 INTO v_idedital FROM Edital;
			:new.id_edital := v_idedital;
		END IF;
	END;
/

CREATE OR REPLACE PROCEDURE abreEdital(numero_in IN NUMBER,siape_in IN NUMBER,sigla_in IN VARCHAR2,data_inicio_in IN DATE,
	data_fim_in IN DATE, restricoes_in IN VARCHAR2,bolsistas_in IN NUMBER,valor_in IN FLOAT,duracao_in IN NUMBER,recurso_in IN VARCHAR2)
	IS
	BEGIN
		IF checaDataFim(data_fim_in) = '1' THEN	
			INSERT INTO Edital 
	    		(nro_pessoa, siape, sigla, data_inicio, restricoes, nro_bolsistas, valor, duracao, recurso_custeio)
	    		VALUES 
				(numero_in,siape_in,sigla_in,data_inicio_in,restricoes_in,bolsistas_in,valor_in,duracao_in,recurso_in);
		ELSE 
			RAISE_APPLICATION_ERROR(-20020,'Você não pode mais abrir editais (seu período de Membro do CaEx esgotou)!');
		END IF;
	END;
/

-- Alterar Edital (Procedure)
CREATE OR REPLACE PROCEDURE alteraEdital
	(data_fim_in IN DATE, new_id_edital IN NUMBER, new_restricoes IN VARCHAR2, new_nro_bolsistas IN NUMBER, new_valor IN FLOAT, new_duracao IN NUMBER, new_recurso_custeio IN VARCHAR2)
	AS 
	v_idedital NUMBER;
	BEGIN
		IF checaDataFim(data_fim_in) = '1' THEN	
			IF new_id_edital IS NULL THEN 
				RAISE_APPLICATION_ERROR(-20021,'Inserir id de edital!');
			ELSE
				SELECT id_edital INTO v_idedital FROM Edital WHERE id_edital = new_id_edital;
				UPDATE Edital SET restricoes = new_restricoes, nro_bolsistas = new_nro_bolsistas, 
					valor = new_valor, duracao = new_duracao, recurso_custeio = new_recurso_custeio
					WHERE id_edital = new_id_edital; 
			END IF;
		ELSE 
			RAISE_APPLICATION_ERROR(-20021,'Você não pode mais alterar editais (seu período de Membro do CaEx esgotou)!');
		END IF;
		EXCEPTION WHEN no_data_found THEN
			RAISE_APPLICATION_ERROR(-20312,'Edital não encontrado!');
	END;
/

-- Cadastrar Pessoa Externa (Procedure)
CREATE OR REPLACE PROCEDURE cadastraExterno
(ex_nome IN VARCHAR2, ex_email IN VARCHAR2, tipo_doc IN VARCHAR2, nro_doc IN NUMBER, data_fim_in IN DATE)
IS
v_nro_pessoa NUMBER;
	BEGIN
		IF checaDataFim(data_fim_in) = '1' THEN	
			IF (ex_nome IS NULL) OR (ex_email IS NULL) OR (nro_doc IS NULL) THEN
				RAISE_APPLICATION_ERROR(-20022,'Todos os campos são obrigatórios!');
		    ELSIF NOT(tipo_doc = 'Passaporte') AND NOT(tipo_doc = 'CPF') THEN
		        RAISE_APPLICATION_ERROR(-20022, 'Tipo de documento inválido');
		    ELSE
		    	SELECT MAX(nro_pessoa)+1 INTO v_nro_pessoa FROM Pessoa;
		        INSERT INTO Pessoa VALUES (v_nro_pessoa, ex_nome);
		        INSERT INTO Email_Pessoa (email, nro_pessoa) VALUES (ex_email, v_nro_pessoa);
		        INSERT INTO Externo (nro_pessoa) VALUES (v_nro_pessoa);
		        IF (tipo_doc = 'Passaporte') THEN
		            INSERT INTO Estrangeiro (passaporte, nro_pessoa) VALUES (nro_doc, v_nro_pessoa);
		        ELSE 
		            INSERT INTO Brasileiro (cpf, nro_pessoa) VALUES (nro_doc, v_nro_pessoa);
		        END IF;
		    END IF;
		ELSE 
			RAISE_APPLICATION_ERROR(-20023,'Você não pode mais cadastrar pessoas (seu período de Membro do CaEx esgotou)!');
		END IF;
	END;

-- Cadastrar Servidor (Procedure)
CREATE OR REPLACE PROCEDURE cadastraServidor
(nome_in IN VARCHAR2, email_in IN VARCHAR2, tipo_doc IN VARCHAR2, nro_doc IN NUMBER, siape_in IN NUMBER, 
	data_admissao_in IN DATE, sigla_setor_in IN VARCHAR2, tipo_in IN VARCHAR2, login_in IN VARCHAR, senha_in IN VARCHAR,
	senha_in_2 IN VARCHAR, data_fim_in IN DATE)
	IS
	v_nro_pessoa NUMBER;
	BEGIN
		IF checaDataFim(data_fim_in) = '1' THEN	
			IF (nome_in IS NULL) OR (email_in IS NULL) OR (nro_doc IS NULL) 
				OR (siape_in IS NULL) OR (data_admissao_in IS NULL) OR (login_in IS NULL) 
				OR (senha_in IS NULL) OR (senha_in_2 IS NULL) THEN
				RAISE_APPLICATION_ERROR(-20022,'Todos os campos são obrigatórios!');
			ELSIF NOT(senha_in = senha_in_2) THEN
		    	RAISE_APPLICATION_ERROR(-20026, 'As senhas não correspondem');
		    ELSE
		    	SELECT MAX(nro_pessoa)+1 INTO v_nro_pessoa FROM Pessoa;
		        INSERT INTO Pessoa VALUES (v_nro_pessoa, nome_in);
		        INSERT INTO Email_Pessoa (email, nro_pessoa) VALUES (email_in, v_nro_pessoa);
		        INSERT INTO Interno (nro_pessoa, senha, login) VALUES (v_nro_pessoa, senha_in, login_in);
		        IF (tipo_doc = 'Passaporte') THEN
		            INSERT INTO Estrangeiro (passaporte, nro_pessoa) VALUES (nro_doc, v_nro_pessoa);
		        ELSE 
		            INSERT INTO Brasileiro (cpf, nro_pessoa) VALUES (nro_doc, v_nro_pessoa);
		        END IF;
		        INSERT INTO Servidor VALUES (v_nro_pessoa, siape_in, data_admissao_in, NULL);
		        IF (tipo_in = 'TA') THEN
		        	INSERT INTO TA VALUES (v_nro_pessoa, siape_in);
		        ELSE
		        	INSERT INTO Docente VALUES (v_nro_pessoa, siape_in);
		        INSERT INTO Lotado VALUES (sigla_setor_in, v_nro_pessoa, siape_in, data_admissao_in, NULL);
		        END IF;
		    END IF;
		ELSE 
			RAISE_APPLICATION_ERROR(-20027,'Você não pode mais cadastrar pessoas (seu período de Membro do CaEx esgotou)!');
		END IF;
	END;
/

-- Cadastrar Discente (Procedure)
CREATE OR REPLACE PROCEDURE cadastraDiscente
(nome_in IN VARCHAR2, email_in IN VARCHAR2, tipo_doc IN VARCHAR2, nro_doc IN NUMBER, ra_in IN NUMBER, 
	data_ingresso_in IN DATE, sigla_setor_in IN VARCHAR2, curso_in IN VARCHAR2, login_in IN VARCHAR, senha_in IN VARCHAR,
	senha_in_2 IN VARCHAR, data_fim_in IN DATE)
	IS
	v_nro_pessoa NUMBER;
	BEGIN
		IF checaDataFim(data_fim_in) = '1' THEN
			IF (nome_in IS NULL) OR (email_in IS NULL) OR (nro_doc IS NULL) 
				OR (ra_in IS NULL) OR (data_ingresso_in IS NULL) OR (curso_in IS NULL) OR (login_in IS NULL) 
				OR (senha_in IS NULL) OR (senha_in_2 IS NULL) THEN
				RAISE_APPLICATION_ERROR(-20022,'Todos os campos são obrigatórios!');
			ELSIF NOT(senha_in = senha_in_2) THEN
		    	RAISE_APPLICATION_ERROR(-20028, 'As senhas não correspondem');
		    ELSE
		    	SELECT MAX(nro_pessoa)+1 INTO v_nro_pessoa FROM Pessoa;
		        INSERT INTO Pessoa VALUES (v_nro_pessoa, nome_in);
		        INSERT INTO Email_Pessoa (email, nro_pessoa) VALUES (email_in, v_nro_pessoa);
		        INSERT INTO Interno (nro_pessoa, senha, login) VALUES (v_nro_pessoa, senha_in, login_in);
		        IF (tipo_doc = 'Passaporte') THEN
		            INSERT INTO Estrangeiro (passaporte, nro_pessoa) VALUES (nro_doc, v_nro_pessoa);
		        ELSE 
		            INSERT INTO Brasileiro (cpf, nro_pessoa) VALUES (nro_doc, v_nro_pessoa);
		        END IF;
		        INSERT INTO Discente VALUES (v_nro_pessoa, ra_in, data_ingresso_in, NULL, curso_in, sigla_setor_in,
		        	data_ingresso_in,NULL);
	    	END IF;
	    ELSE 
			RAISE_APPLICATION_ERROR(-20029,'Você não pode mais cadastrar pessoas (seu período de Membro do CaEx esgotou)!');
		END IF;
	END;
/

-- Associar ao CoEx (Procedure)
CREATE OR REPLACE PROCEDURE associaCoEx(num_in IN NUMBER, tipo_in IN VARCHAR2, data_fim_in IN DATE)
IS
    v_nro_pessoa NUMBER;    
    v_sysdate DATE;
BEGIN
    IF checaDataFim(data_fim_in) = '1' THEN
	    SELECT SYSDATE INTO v_sysdate FROM DUAL;
	    IF (tipo_in = 'Servidor') THEN
	    	SELECT nro_pessoa INTO v_nro_pessoa FROM Servidor 
	    		WHERE siape = num_in;
	    ELSE 
	    	SELECT nro_pessoa INTO v_nro_pessoa FROM Discente 
	    		WHERE ra = num_in; 
	    END IF;
	    INSERT INTO Membro_CoEx VALUES (v_nro_pessoa, 'CoEx', v_sysdate, NULL);
	ELSE 
		RAISE_APPLICATION_ERROR(-20030,'Você não pode mais cadastrar pessoas (seu período de Membro do CaEx esgotou)!');
	END IF;
	EXCEPTION WHEN no_data_found THEN 
		RAISE_APPLICATION_ERROR(-20031,tipo_in||' não encontrado!');
END;
/

-- Associar ao CaEx (Procedure)
CREATE OR REPLACE PROCEDURE associaCaEx(num_in IN NUMBER, data_fim_in IN DATE)
IS
    v_nro_pessoa NUMBER;    
    v_sysdate DATE;
BEGIN
	IF checaDataFim(data_fim_in) = '1' THEN
	    SELECT SYSDATE INTO v_sysdate FROM DUAL;
	   	SELECT nro_pessoa INTO v_nro_pessoa FROM Servidor 
	    		WHERE siape = num_in;
	    INSERT INTO Membro_CaEx VALUES (v_nro_pessoa, num_in, 'CaEx', v_sysdate, NULL);
	ELSE 
		RAISE_APPLICATION_ERROR(-20032,'Você não pode mais cadastrar pessoas (seu período de Membro do CaEx esgotou)!');
	END IF;
	EXCEPTION WHEN no_data_found THEN 
		RAISE_APPLICATION_ERROR(-20033,'Servidor não encontrado!');
END;

-- Demitir Servidor (Procedure)
CREATE OR REPLACE PROCEDURE demiteServidor
	(servidor_atual_siape IN NUMBER, new_servidor_siape IN NUMBER, data_fim_in IN DATE)
	IS 
	CURSOR c1 IS SELECT r.id_proposta, r.nro_versao, r.nro_pessoa, r.siape, r.data_inicio, r.data_fim FROM Responsavel r
		WHERE r.siape = servidor_atual_siape AND (r.data_fim IS NULL OR r.data_fim >= (SELECT SYSDATE FROM Dual)) FOR UPDATE;
	c1row c1%ROWTYPE;
	nro_pessoa_atual NUMBER;
	nro_pessoa_novo NUMBER;
	v_sysdate DATE;
	BEGIN 
		IF checaDataFim(data_fim_in) = '1' THEN
			SELECT SYSDATE INTO v_sysdate FROM Dual;
			SELECT nro_pessoa INTO nro_pessoa_atual FROM Servidor WHERE siape = servidor_atual_siape;
			SELECT nro_pessoa INTO nro_pessoa_novo FROM Servidor WHERE siape = new_servidor_siape;
			UPDATE Envolve SET data_fim = v_sysdate WHERE nro_pessoa = nro_pessoa_atual AND data_fim IS NULL;
			UPDATE Lotado SET data_fim = v_sysdate WHERE nro_pessoa = nro_pessoa_atual AND data_fim IS NULL;
			OPEN c1;
			LOOP 
				FETCH c1 INTO c1row;	
				EXIT WHEN c1%NOTFOUND;
				UPDATE Servidor SET data_demissao = v_sysdate WHERE nro_pessoa = nro_pessoa_atual AND siape = servidor_atual_siape;
				UPDATE Responsavel SET data_fim = v_sysdate WHERE CURRENT OF c1;
				INSERT INTO Responsavel (id_proposta, nro_versao, nro_pessoa, siape, data_inicio) 
					VALUES (c1row.id_proposta, c1row.nro_versao, nro_pessoa_novo, new_servidor_siape, v_sysdate);
				INSERT INTO Envolve (id_proposta, nro_versao, nro_pessoa, data_inicio) 
					VALUES (c1row.id_proposta, c1row.nro_versao, nro_pessoa_novo, v_sysdate);
			END LOOP;
			CLOSE c1;
		ELSE 
			RAISE_APPLICATION_ERROR(-20034,'Você não pode mais remover pessoas (seu período de Membro do CaEx esgotou)!');
		END IF;
		EXCEPTION WHEN no_data_found THEN 
			RAISE_APPLICATION_ERROR(-20035,'Servidor não encontrado!');
	END;
/

-- Egressar Discente (Procedure)
CREATE OR REPLACE PROCEDURE egressaDiscente
	(discente_ra IN NUMBER, data_fim_in IN DATE)
	IS 
	v_nro_pessoa NUMBER;
	v_sysdate DATE;
	BEGIN 
		IF checaDataFim(data_fim_in) = '1' THEN
			SELECT SYSDATE INTO v_sysdate FROM Dual;
			SELECT nro_pessoa INTO v_nro_pessoa FROM Discente WHERE ra = discente_ra;
			UPDATE Discente SET data_egresso = v_sysdate WHERE nro_pessoa = v_nro_pessoa AND ra = discente_ra;
			UPDATE Envolve SET data_fim = v_sysdate WHERE nro_pessoa = v_nro_pessoa AND data_fim IS NULL;
		ELSE 
			RAISE_APPLICATION_ERROR(-20036,'Você não pode mais remover pessoas (seu período de Membro do CaEx esgotou)!');
		END IF;
		EXCEPTION WHEN no_data_found THEN 
			RAISE_APPLICATION_ERROR(-20037,'Discente não encontrado!');
	END;
/
